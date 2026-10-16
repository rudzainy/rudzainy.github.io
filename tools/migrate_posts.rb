#!/usr/bin/env ruby
# frozen_string_literal: true

# Migrates the hand-written served posts to Markdown sources rendered through
# the shared Jekyll layouts (_layouts/post.html, _layouts/section.html).
#
#   ruby tools/migrate_posts.rb --check     report what is missing (exit 1 on any failure)
#   ruby tools/migrate_posts.rb --convert   write the .md posts, convert the section
#                                           indexes, rewrite root-page asset paths
#   ruby tools/migrate_posts.rb --legacy    list legacy .md with no served .html sibling
#
# Each served section/YYYY-MM-DD-slug.html becomes section/YYYY-MM-DD-slug.md:
# front matter (layout, title, date, description, category, permalink, ...) and
# the original body HTML between the navbar and the footer, kept raw. The
# served .html files are read, never modified or deleted (Task 6 removes them).
# Stdlib only.

require "yaml"
require "json"
require "date"
require "strscan"

ROOT = File.expand_path("..", __dir__)
SECTIONS = %w[work life balance].freeze
ROOT_PAGES = %w[index.html resume.html 404.html].freeze

VOID = %w[area base br col embed hr img input link meta param source track wbr].freeze
# Raw-text elements: their content is not scanned for tags. Blank lines inside
# pre/textarea are content and are kept verbatim.
RAW_TEXT = %w[script style pre textarea].freeze
VERBATIM = %w[pre textarea].freeze

DROP_KEYS = %w[layout published sitemap pin mermaid].freeze

SAMA2_LINK = %r{<a class="text-dark" href="https://sama2\.my/si/rudzainy".*?</a>}m

module Migrate
  module_function

  def rel(path) = path.delete_prefix("#{ROOT}/")

  def served_posts
    SECTIONS.flat_map { |s| Dir.glob(File.join(ROOT, s, "[0-9]*.html")).sort }
  end

  def index_pages = SECTIONS.map { |s| File.join(ROOT, s, "index.html") }

  # --- legacy markdown ----------------------------------------------------

  def front_matter(text)
    m = text.match(/\A---\s*\n(.*?)\n---\s*(?:\n|\z)/m) or return [nil, text]
    [m[1], m.post_match]
  end

  def legacy_meta(md_path)
    return {} unless File.exist?(md_path)

    fm, = front_matter(File.read(md_path, encoding: "UTF-8"))
    return {} unless fm

    YAML.safe_load(fm, permitted_classes: [Date, Time]) || {}
  rescue Psych::Exception => e
    warn "#{rel(md_path)}: legacy front matter does not parse (#{e.message}); ignored"
    {}
  end

  # --- served page anatomy ------------------------------------------------

  Page = Struct.new(:path, :head, :body_attrs, :navbar, :content, :footer, :tail, keyword_init: true)

  def parse_page(path)
    src = File.read(path, encoding: "UTF-8")
    head = src[%r{<head>\n?(.*?)\n?[ \t]*</head>}m, 1] or raise "#{rel(path)}: no <head>"
    body_m = src.match(%r{<body([^>]*)>\n?(.*?)\n?[ \t]*</body>}m) or raise "#{rel(path)}: no <body>"
    attrs = body_m[1]
    inner = body_m[2]

    nav_m = inner.match(%r{[ \t]*<!-- Top Navigation Bar -->.*?<!-- end Top Navigation Bar -->[ \t]*\n?}m) or
      raise "#{rel(path)}: no navbar block"
    after_nav = nav_m.post_match

    foot_m = after_nav.match(%r{[ \t]*<!-- Footer Section -->.*?<!-- end Footer Section -->[ \t]*\n?}m)
    if foot_m
      content = foot_m.pre_match
      footer = foot_m[0]
      tail = foot_m.post_match
    else
      js_m = after_nav.match(%r{^[ \t]*<script src="(?:\.\./|/)?jei-es\.js"></script>}) or
        raise "#{rel(path)}: no footer and no jei-es.js script"
      content = js_m.pre_match
      footer = nil
      tail = after_nav[js_m.begin(0)..]
    end
    Page.new(path: path, head: head, body_attrs: attrs, navbar: nav_m[0], content: content, footer: footer, tail: tail)
  end

  HEAD_STANDARD = [
    /http-equiv="Content-Type"/, /<title>/, /<meta charset=/, /name="viewport"/, /<meta name="description"/,
    /<!-- (end )?Bootstrap CSS & Icons ?-->/, %r{bootstrap@5\.3\.8/dist/css/bootstrap\.min\.css},
    /lucide-static@latest/, /href="(?:\.\.\/|\/)?si-es-es\.css"/
  ].freeze

  TAIL_STANDARD = [
    /<script src="(?:\.\.\/|\/)?jei-es\.js"><\/script>/, /<!-- (end )?Bootstrap JS -->/,
    %r{bootstrap@5\.3\.8/dist/js/bootstrap\.bundle\.min\.js}
  ].freeze

  def strip_ruby_on_browser(text)
    text.sub(/[ \t]*<!-- Ruby on Browser --\n.*?!-- end Ruby on Browser -->[ \t]*\n?/m, "")
  end

  def leftover(text, standard)
    lines = strip_ruby_on_browser(text).lines.reject { |l| standard.any? { |re| l =~ re } }
    dedent_block(lines.join)
  end

  # Common-indent removal for head_extra / scripts_extra. Tabs and spaces are
  # compared literally; blank runs are collapsed to one.
  def dedent_block(text)
    lines = text.lines.map(&:rstrip)
    lines.shift while lines.first&.empty?
    lines.pop while lines.last&.empty?
    return nil if lines.empty?

    indents = lines.reject(&:empty?).map { |l| l[/\A[ \t]*/] }
    common = indents.reduce { |a, b| a.chars.zip(b.chars).take_while { |x, y| x == y }.map(&:first).join }
    out = []
    lines.each do |l|
      next if l.empty? && out.last&.empty?

      out << (l.start_with?(common) ? l[common.length..] : l)
    end
    "#{out.join("\n")}\n"
  end

  def title_text(head) = head[%r{<title>(.*?)</title>}m, 1]&.strip

  def meta_description(head) = head[/<meta name="description" content="([^"]*)"/, 1]

  # Escape for the raw {{ page.* }} insertion into an attribute or <title>.
  def html_escape(str)
    str.gsub(/&(?!(?:[A-Za-z][A-Za-z0-9]*|#\d+|#x[0-9A-Fa-f]+);)/, "&amp;").gsub("<", "&lt;").gsub(">", "&gt;").gsub('"', "&quot;")
  end

  # --- asset paths --------------------------------------------------------

  ATTR_IMG = /(\b(?:src|href|poster|data-[\w-]+)=["'])(?:\.\.\/)*images\//
  URL_IMG = /(url\(\s*["']?)(?:\.\.\/)*images\//

  def rewrite_assets(text)
    count = 0
    out = text.gsub(ATTR_IMG) { count += 1; "#{$1}/images/" }
    out = out.gsub(URL_IMG) { count += 1; "#{$1}/images/" }
    out = out.gsub(/(\b(?:src|href)=["'])(?:\.\.\/)+(si-es-es\.css|jei-es\.js)/) { count += 1; "#{$1}/#{$2}" }
    out = out.gsub(/(\b(?:src|href)=["'])(si-es-es\.css|jei-es\.js)/) { count += 1; "#{$1}/#{$2}" }
    [out, count]
  end

  # Local src/href targets (root-absolute after rewrite) that do not exist.
  def missing_refs(text, page_dir)
    refs = text.scan(/\b(?:src|href|poster)=["']([^"'#?]+)/).flatten.uniq
    refs.filter_map do |ref|
      next if ref =~ %r{\A(?:[a-z][a-z0-9+.-]*:|//)}i || ref.empty?

      target = ref.start_with?("/") ? File.join(ROOT, ref) : File.expand_path(ref, page_dir)
      target = target.gsub("%20", " ")
      next if File.exist?(target) || File.exist?(File.join(target, "index.html"))
      next if ref.end_with?(".html") && File.exist?(target.sub(/\.html\z/, ".md"))

      ref
    end
  end

  # --- body scanning ------------------------------------------------------

  # Returns [states, problems]: states[i] = [depth, raw] at the start of line i.
  def line_states(body, strays = nil)
    ss = StringScanner.new(body)
    stack = []
    raw = nil
    states = [[0, nil]]
    problems = []

    until ss.eos?
      if raw
        if ss.scan(/\n/)
          states << [stack.size, raw]
        elsif ss.scan(%r{</#{raw}\s*>}i)
          stack.pop
          raw = nil
        else
          ss.scan(/[^\n<]+|</)
        end
      elsif ss.scan(/\n/)
        states << [stack.size, nil]
      elsif ss.scan(/<!--/)
        rest = ss.scan_until(/-->/) or (problems << "unterminated comment" and break)
        rest.count("\n").times { states << [stack.size, :comment] }
      elsif ss.scan(/<![A-Za-z][^>]*>/)
        nil
      elsif (tag = ss.scan(%r{<([A-Za-z][\w:-]*)((?:[^>"']|"[^"]*"|'[^']*')*)>}))
        name = ss[1].downcase
        self_closing = ss[2].end_with?("/") || VOID.include?(name)
        tag.count("\n").times { states << [stack.size, nil] }
        unless self_closing
          stack << name
          raw = name if RAW_TEXT.include?(name)
        end
      elsif ss.scan(%r{</([A-Za-z][\w:-]*)\s*>})
        name = ss[1].downcase
        if (idx = stack.rindex(name))
          problems << "unclosed <#{stack[(idx + 1)..].join('>, <')}> before </#{name}>" if idx < stack.size - 1
          stack.slice!(idx..)
        else
          problems << "stray </#{name}> at line #{states.size}"
          strays&.push([ss.charpos - ss.matched.length, ss.matched.length])
        end
      else
        ss.scan(/[^\n<]+|</)
      end
    end
    problems << "unclosed at end: #{stack.join(', ')}" unless stack.empty?
    [states, problems]
  end

  # A closing tag with no matching open element is ignored by browsers, but
  # kramdown prints it as literal text. Drop those so the DOM is unchanged.
  def drop_stray_closers(body)
    strays = []
    _, problems = line_states(body, strays)
    out = body.dup
    strays.reverse_each { |pos, len| out[pos, len] = "" }
    [out, problems.grep(/\Astray/)]
  end

  # Kramdown-safe body: top-level lines start at column 0, no blank line inside
  # any block except verbatim pre/textarea content, single blank line between
  # top-level blocks.
  def normalise_body(body)
    lines = body.lines.map { |l| l.chomp }
    states, problems = line_states(lines.join("\n"))
    base = lines.find { |l| !l.strip.empty? }.to_s[/\A[ \t]*/]
    out = []
    lines.each_with_index do |line, i|
      depth, raw = states[i] || [0, nil]
      if VERBATIM.include?(raw)
        out << line
      elsif line.strip.empty?
        out << "" if depth.zero? && raw.nil? && !out.empty? && !out.last.empty?
      elsif depth.zero? && raw.nil?
        out << line.lstrip.rstrip
      else
        out << (line.start_with?(base) ? line[base.length..] : line).rstrip
      end
    end
    out.pop while out.last&.empty?
    ["#{out.join("\n")}\n", problems]
  end

  # Blank lines that sit inside a block (outside verbatim pre/textarea), and
  # non-tag text at the top level (kramdown would wrap it in <p>).
  def body_issues(body)
    text = body.sub(/\A\{% raw %\}\n/, "").sub(/\n\{% endraw %\}\n?\z/, "\n")
    lines = text.lines.map(&:chomp)
    states, problems = line_states(lines.join("\n"))
    issues = problems.map { |p| "html: #{p}" }
    lines.each_with_index do |line, i|
      depth, raw = states[i] || [0, nil]
      next if VERBATIM.include?(raw)

      if line.strip.empty?
        issues << "blank line inside a block at body line #{i + 1}" unless depth.zero? && raw.nil?
      elsif depth.zero? && raw.nil?
        issues << "top-level line #{i + 1} is indented" if line =~ /\A(\t| {4})/
        issues << "top-level text at body line #{i + 1}" unless line.lstrip.start_with?("<")
      end
    end
    issues
  end

  def liquid_outside_raw?(body)
    body.gsub(/\{% raw %\}.*?\{% endraw %\}/m, "").match?(/\{\{|\{%/)
  end

  # --- front matter emission ----------------------------------------------

  def yaml_scalar(value)
    case value
    when %r{\A[/a-z][\w/.-]*\z} then value.match?(/\A(?:true|false|yes|no|on|off|null)\z/i) ? JSON.generate(value) : value
    when String then JSON.generate(value)
    when Array then "[#{value.map { |v| JSON.generate(v.to_s) }.join(', ')}]"
    else value.to_s
    end
  end

  def emit_front_matter(fields)
    out = +"---\n"
    fields.each do |key, value|
      next if value.nil?

      if value.is_a?(String) && value.include?("\n")
        out << "#{key}: |2\n"
        value.each_line { |l| out << (l.strip.empty? ? "\n" : "  #{l}") }
        out << "\n" unless out.end_with?("\n")
      elsif key == "date"
        out << "#{key}: #{value}\n"
      else
        out << "#{key}: #{yaml_scalar(value)}\n"
      end
    end
    out << "---\n"
  end

  # --- conversion ---------------------------------------------------------

  def expected_footer(cat)
    inc = File.read(File.join(ROOT, "_includes/footer.html"), encoding: "UTF-8")
    inc = inc.gsub(/\{%-? if layout\.back_link and cat != "" -?%\}\n?(.*?)\{%-? endif -?%\}\n?/m) { $1 }
    inc.gsub("{{ cat }}", cat).gsub("{{ cat | capitalize }}", cat.capitalize)
  end

  def expected_navbar(cat_color)
    inc = File.read(File.join(ROOT, "_includes/navbar.html"), encoding: "UTF-8")
    inc = inc.gsub(/\{%-? unless [^%]*%\}\n?(.*?)\{%-? endunless -?%\}\n?/m) { $1 }
    inc.gsub(/\{% if [^%]*%\} active\{% endif %\}/, "").gsub("{{ cat_color }}", cat_color)
  end

  def squash(html) = html.gsub(/\s+/, " ").gsub(/>\s+</, "><").strip

  COLORS = { "work" => "info", "life" => "success", "balance" => "warning" }.freeze

  Result = Struct.new(:target, :fields, :body, :notes, :missing, :problems, keyword_init: true)

  def convert_post(path)
    cat = File.basename(File.dirname(path))
    slug = File.basename(path, ".html")
    md_path = File.join(File.dirname(path), "#{slug}.md")
    legacy = legacy_meta(md_path)
    page = parse_page(path)
    notes = []

    title = legacy["title"].is_a?(String) && !legacy["title"].strip.empty? ? html_escape(legacy["title"].strip) : nil
    if title
      notes << "title: legacy md (#{legacy['title'].strip.inspect}); served <title> was #{title_text(page.head).inspect}"
    else
      title = title_text(page.head).sub(/\s+\|.*\z/, "")
      notes << "title: served <title>"
    end

    desc = meta_description(page.head)
    if desc
      notes << "description: meta"
    elsif legacy["description"].is_a?(String) && !legacy["description"].strip.empty?
      desc = html_escape(legacy["description"].strip)
      notes << "description: legacy md"
    else
      notes << "description: none (site.description fallback)"
    end

    date = legacy["date"] || slug[/\A\d{4}-\d{2}-\d{2}/]
    data_category = page.body_attrs[/data-category="([^"]+)"/, 1]
    other_attrs = page.body_attrs.gsub(/\s*data-category="[^"]*"/, "").strip
    notes << "body attributes dropped: #{other_attrs}" unless other_attrs.empty?

    head_extra = leftover(page.head, HEAD_STANDARD)
    scripts_extra = leftover(page.tail, TAIL_STANDARD)
    loads_mermaid = scripts_extra.to_s.include?("mermaid")
    notes << "head_extra: #{head_extra.lines.size} lines" if head_extra
    notes << "scripts_extra: #{scripts_extra.lines.size} lines" if scripts_extra
    tail_order = page.tail.index("mermaid") && page.tail.index("bootstrap.bundle") &&
      page.tail.index("mermaid") < page.tail.index("bootstrap.bundle")
    notes << "deviation: extra scripts now load after the Bootstrap bundle (served page loaded them before it)" if tail_order

    nav_ok = squash(page.navbar) == squash(expected_navbar(COLORS.fetch(cat)))
    notes << "deviation: navbar differs from the layout navbar (normalised)" unless nav_ok

    content = page.content
    if page.footer
      foot_ok = squash(page.footer) == squash(expected_footer(cat))
      unless foot_ok
        notes << "deviation: footer variant normalised to the layout footer"
        if (link = page.footer[SAMA2_LINK])
          last = content.rindex(%r{</article>}) or raise "#{rel(path)}: no </article> for the Sama2 link"
          insert = "\n      <p class=\"text-center\" style=\"max-width:var(--measure);margin:var(--space-5) auto 0\">#{link.gsub(/\s*\n\s*/, '')}</p>"
          close = content.index(">", last) + 1
          content = content.dup.insert(close, insert)
          notes << "deviation: live Sama2 footer link moved into the body after the last </article> (no </section> in the body)"
        end
      end
    else
      notes << "deviation: served page had no footer; the post layout adds one"
    end

    content, rewrites = rewrite_assets(content)
    head_extra, r2 = head_extra ? rewrite_assets(head_extra) : [nil, 0]
    scripts_extra, r3 = scripts_extra ? rewrite_assets(scripts_extra) : [nil, 0]
    notes << "asset paths rewritten: #{rewrites + r2 + r3}"

    content, strays = drop_stray_closers(content)
    strays.each { |s| notes << "deviation: removed #{s} (no open element; kramdown would print it as text)" }
    body, problems = normalise_body(content)
    if body.match?(/\{\{|\{%/)
      body = "{% raw %}\n#{body}{% endraw %}\n"
      notes << "body wrapped in {% raw %}"
    end

    fields = {
      "layout" => "post",
      "title" => title,
      "date" => date,
      "description" => desc,
      "category" => cat,
      "permalink" => "/#{cat}/#{slug}.html",
      "data_category" => data_category,
      "tags" => legacy["tags"].is_a?(Array) && !legacy["tags"].empty? ? legacy["tags"] : nil,
      "image" => legacy["image"].is_a?(String) && !legacy["image"].strip.empty? ? legacy["image"].strip : nil,
      "mermaid" => legacy["mermaid"] && loads_mermaid ? true : nil,
      "head_extra" => head_extra,
      "scripts_extra" => scripts_extra
    }
    dropped = legacy.keys - fields.keys
    notes << "legacy keys dropped: #{dropped.join(', ')}" unless dropped.empty? || legacy.empty?
    notes << (File.exist?(md_path) ? "overwrote legacy .md" : "new .md (no legacy sibling)")

    Result.new(target: md_path, fields: fields, body: body, notes: notes,
               missing: missing_refs(content + head_extra.to_s + scripts_extra.to_s, File.dirname(path)), problems: problems)
  end

  def convert_index(path)
    cat = File.basename(File.dirname(path))
    page = parse_page(path)
    notes = []
    data_category = page.body_attrs[/data-category="([^"]+)"/, 1]
    notes << "body data-category #{data_category.inspect} differs from #{cat}" if data_category && data_category != cat
    head_extra = leftover(page.head, HEAD_STANDARD)
    scripts_extra = leftover(page.tail, TAIL_STANDARD)
    content, rewrites = rewrite_assets(page.content)
    notes << "asset paths rewritten: #{rewrites}"
    notes << "deviation: navbar active link now set by the layout from the URL" unless page.navbar.include?(%(href="/#{cat}/" class="nav-link active"))
    fields = {
      "layout" => "section",
      "title" => title_text(page.head),
      "description" => meta_description(page.head),
      "category" => cat,
      "permalink" => "/#{cat}/",
      "head_extra" => head_extra,
      "scripts_extra" => scripts_extra
    }
    body = content.sub(/\A\n+/, "").rstrip + "\n"
    Result.new(target: path, fields: fields, body: body, notes: notes,
               missing: missing_refs(content, File.dirname(path)), problems: line_states(content)[1])
  end

  def write(result)
    fm = emit_front_matter(result.fields)
    parsed = YAML.safe_load(fm.delete_prefix("---\n").delete_suffix("---\n"), permitted_classes: [Date, Time])
    result.fields.each do |k, v|
      next if v.nil? || k == "date"
      raise "#{rel(result.target)}: front matter #{k} does not round-trip" unless parsed[k] == v
    end
    File.write(result.target, fm + result.body)
  end

  # --- check ----------------------------------------------------------------

  REQUIRED = %w[layout title permalink category].freeze

  def check_file(target, expect_layout, expect_permalink)
    failures = []
    unless File.exist?(target)
      return ["#{rel(target)} does not exist"]
    end

    fm, body = front_matter(File.read(target, encoding: "UTF-8"))
    return ["no front matter"] unless fm

    data = begin
      YAML.safe_load(fm, permitted_classes: [Date, Time]) || {}
    rescue Psych::Exception => e
      return ["front matter does not parse: #{e.message}"]
    end
    REQUIRED.each { |k| failures << "missing #{k}" if data[k].to_s.strip.empty? }
    failures << "layout is #{data['layout'].inspect}, want #{expect_layout}" if data["layout"] && data["layout"] != expect_layout
    failures << "permalink is #{data['permalink'].inspect}, want #{expect_permalink}" if data["permalink"] && data["permalink"] != expect_permalink
    failures << "published key present" if data.key?("published")
    failures << "no <main> region in body" unless body =~ /<main\b/ && body.include?("</main>")
    failures << "Liquid outside {% raw %}" if liquid_outside_raw?(body)
    failures.concat(body_issues(body)) if target.end_with?(".md")
    failures
  end

  def check
    rows = served_posts.map do |p|
      cat = File.basename(File.dirname(p))
      [p.sub(/\.html\z/, ".md"), check_file(p.sub(/\.html\z/, ".md"), "post", "/#{cat}/#{File.basename(p)}")]
    end
    rows += index_pages.map { |p| [p, check_file(p, "section", "/#{File.basename(File.dirname(p))}/")] }
    failed = rows.reject { |_, f| f.empty? }
    rows.each { |t, f| puts "#{f.empty? ? 'PASS' : 'FAIL'} #{rel(t)}#{f.empty? ? '' : " -- #{f.first(4).join('; ')}#{f.size > 4 ? " (+#{f.size - 4})" : ''}"}" }
    puts "checked #{rows.size} (#{served_posts.size} posts + #{index_pages.size} indexes): #{rows.size - failed.size} pass, #{failed.size} fail"
    failed.empty?
  end

  # --- legacy listing ---------------------------------------------------------

  def legacy_without_served
    SECTIONS.flat_map do |s|
      Dir.glob(File.join(ROOT, s, "*.md")).sort.reject { |md| File.exist?(md.sub(/\.md\z/, ".html")) }
    end
  end

  # Refuse to run twice: a converted .md would be read back as the legacy
  # source, and a converted index page has no <head> left to parse.
  def already_converted
    md = served_posts.map { |p| p.sub(/\.html\z/, ".md") }.select { |m| File.exist?(m) && File.read(m)[/\A---\n.*?^permalink:/m] }
    md + index_pages.select { |p| File.read(p).start_with?("---\n") }
  end

  def convert
    done = already_converted
    abort "already converted (restore from git first): #{done.first(3).map { |p| rel(p) }.join(', ')}" unless done.empty?
    report = []
    served_posts.each do |p|
      r = convert_post(p)
      write(r)
      report << [r, p]
    end
    index_pages.each do |p|
      r = convert_index(p)
      write(r)
      report << [r, p]
    end
    report.each do |r, p|
      puts "== #{rel(p)} -> #{rel(r.target)} [#{r.fields['category']}]"
      r.notes.each { |n| puts "   #{n}" }
      r.problems.each { |n| puts "   html: #{n}" }
      r.missing.each { |m| puts "   MISSING #{m}" }
    end
    ROOT_PAGES.each do |name|
      path = File.join(ROOT, name)
      text = File.read(path, encoding: "UTF-8")
      out, n = rewrite_assets(text)
      File.write(path, out) if n.positive?
      puts "== #{name}: asset paths rewritten: #{n}"
      missing_refs(out, ROOT).each { |m| puts "   MISSING #{m}" }
    end
  end
end

if $PROGRAM_NAME == __FILE__
  case ARGV.first
  when "--check" then exit(Migrate.check ? 0 : 1)
  when "--convert" then Migrate.convert
  when "--legacy" then puts(Migrate.legacy_without_served.map { |p| Migrate.rel(p) })
  else
    warn "usage: ruby tools/migrate_posts.rb --check | --convert | --legacy"
    exit 2
  end
end
