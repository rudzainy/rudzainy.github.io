#!/usr/bin/env ruby
# frozen_string_literal: true

# Reports internal links and asset references in the built site that point at
# nothing. Build first, then: ruby tools/check-links.rb [_site]
# Exits 1 when anything is broken. /components/ is reported separately because
# it links to partial snippets that are never built.
root = File.expand_path(ARGV[0] || '_site')
abort "No build at #{root}; run jekyll build first." unless Dir.exist?(root)

broken = Hash.new { |h, k| h[k] = [] }
Dir.glob("#{root}/**/*.html").each do |file|
  html = File.read(file, encoding: 'utf-8')
  html.scan(/(?:href|src)="([^"#?]+)/).flatten.uniq.each do |ref|
    next if ref.match?(%r{\A(?:[a-z][a-z0-9+.-]*:|//)}i)

    path = ref.start_with?('/') ? File.join(root, ref) : File.join(File.dirname(file), ref)
    path = File.join(path, 'index.html') if File.directory?(path)
    broken[ref] << file.delete_prefix(root) unless File.exist?(path)
  end
end

site, components = broken.partition { |_, pages| pages.any? { |p| !p.start_with?('/components/') } }
site.each { |ref, pages| puts "#{ref}  <- #{pages.uniq.join(', ')}" }
puts "Broken (site): #{site.size}"
puts "Broken (components/ only, informational): #{components.size}"
exit(site.empty? ? 0 : 1)
