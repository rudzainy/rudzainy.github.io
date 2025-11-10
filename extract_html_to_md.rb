#!/usr/bin/env ruby
# encoding: UTF-8
# HTML to Markdown Extractor
# Extracts content from HTML files and creates/updates markdown files

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'fileutils'

# List of files with MAJOR differences that need manual review
MAJOR_DIFF_FILES = [
  "balance/2003-08-28-family.html",
  "balance/2009-08-24-tm-parody-ad.html",
  "balance/2013-09-25-jantan.html",
  "balance/2015-09-25-hearts.html",
  "balance/2016-05-19-browsercrush-clone.html",
  "balance/2016-07-23-teng-quora-k-a-quora-clone.html",
  "balance/2017-07-09-self-improvement.html",
  "balance/2019-04-24-orang-kasar.html",
  "balance/2019-09-19-life.html",
  "balance/2019-12-30-teater-neon.html",
  "balance/2020-02-24-melihat.html",
  "balance/2020-07-11-thoughts-explosion.html",
  "balance/2020-09-01-not-the-stage-manager-for-sudirmania.html",
  "balance/2023-11-02-16-384.html",
  "balance/2024-01-22-rails-7-dropdown-image.html",
  "balance/2024-03-16-setup-python-3-on-macos.html",
  "balance/2024-03-16-tutorial-generate-qr-for-wifi.html",
  "balance/2024-03-27-why-rigid-corporate-structure-is-bad-for-me.html",
  "balance/2024-04-07-uiux-design-for-agriculture.html",
  "balance/2024-06-16-an-answer-to-the-question-of-windows-vs-macos.html",
  "life/2017-05-02-baloons-over-bagan.html",
  "life/2019-06-08-railway-market.html",
  "life/2021-01-03-kenapa-rudzainy-buat-hoojah.html",
  "life/2022-03-19-happyness-unlocked.html",
  "life/2022-09-15-maya.html",
  "life/2024-01-03-of-books.html",
  "life/2024-01-03-of-video-games.html",
  "life/2024-06-20-of-operating-systems.html",
  "work/2010-09-01-marliyati-froz-logo.html",
  "work/2017-09-01-next-academy-learning-portal.html",
  "work/2019-09-01-dxc-bionix-central.html",
  "work/2019-09-01-dxc-bionix-design-system.html",
  "work/2020-09-01-the-hoojah-project.html",
  "work/2022-09-01-flip-down-numbers-and-characters.html",
  "work/2023-05-18-slide-to-select.html",
  "work/2025-09-11-day-food-catalogue.html"
]

def extract_html_article_content(html_file)
  content = File.read(html_file, encoding: 'UTF-8')

  # Extract content between <article> or <main> tags
  if content =~ /<article[^>]*>(.*?)<\/article>/m
    $1
  elsif content =~ /<main[^>]*>(.*?)<\/main>/m
    $1
  else
    nil
  end
end

def extract_metadata_from_html(html_file)
  content = File.read(html_file, encoding: 'UTF-8')
  metadata = {}

  # Extract title
  if content =~ /<title>(.*?)<\/title>/m
    metadata[:title] = $1.gsub(/\s+/, ' ').strip
  end

  # Extract description
  if content =~ /<meta name="description" content="(.*?)"/m
    metadata[:description] = $1
  end

  # Extract date if present
  if content =~ /<time[^>]*datetime="([^"]+)"/
    metadata[:date] = $1
  end

  metadata
end

def get_existing_frontmatter(md_file)
  return nil unless File.exist?(md_file)

  content = File.read(md_file, encoding: 'UTF-8')
  if content =~ /^---\n(.*?)---\n/m
    $1
  else
    nil
  end
end

# Main extraction process
puts "=" * 80
puts "HTML TO MARKDOWN CONTENT EXTRACTOR"
puts "=" * 80
puts ""
puts "This script will extract article content from HTML files"
puts "and save them to a review directory for manual inspection."
puts ""
puts "Files to process: #{MAJOR_DIFF_FILES.length}"
puts ""

# Create review directory
review_dir = "html_content_review"
FileUtils.mkdir_p(review_dir)

MAJOR_DIFF_FILES.each_with_index do |html_file, index|
  next unless File.exist?(html_file)

  basename = File.basename(html_file, '.html')
  category = File.dirname(html_file)
  md_file = html_file.sub('.html', '.md')

  puts "[#{index + 1}/#{MAJOR_DIFF_FILES.length}] Processing: #{html_file}"

  begin
    # Extract HTML content
    article_content = extract_html_article_content(html_file)

    if article_content.nil?
      puts "  ⚠️  Could not find article/main content"
      next
    end

    # Extract metadata
    html_metadata = extract_metadata_from_html(html_file)

    # Get existing frontmatter if markdown exists
    existing_frontmatter = get_existing_frontmatter(md_file)

    # Create review file
    review_subdir = "#{review_dir}/#{category}"
    FileUtils.mkdir_p(review_subdir)
    review_file = "#{review_subdir}/#{basename}_extracted.html"

    # Save extracted content for review
    File.write(review_file, article_content, encoding: 'UTF-8')

    # Create a comparison file with both versions
    comparison_file = "#{review_subdir}/#{basename}_comparison.txt"
    comparison_content = "=" * 80 + "\n"
    comparison_content += "FILE: #{html_file}\n"
    comparison_content += "=" * 80 + "\n\n"

    comparison_content += "HTML METADATA:\n"
    comparison_content += "-" * 80 + "\n"
    html_metadata.each { |k, v| comparison_content += "#{k}: #{v}\n" }
    comparison_content += "\n"

    if existing_frontmatter
      comparison_content += "EXISTING MARKDOWN FRONTMATTER:\n"
      comparison_content += "-" * 80 + "\n"
      comparison_content += existing_frontmatter
      comparison_content += "\n\n"
    else
      comparison_content += "⚠️  NO EXISTING MARKDOWN FILE\n\n"
    end

    comparison_content += "EXTRACTED HTML CONTENT (first 500 chars):\n"
    comparison_content += "-" * 80 + "\n"
    comparison_content += article_content[0..500]
    comparison_content += "\n...\n\n"

    if File.exist?(md_file)
      md_content = File.read(md_file, encoding: 'UTF-8')
      md_content_no_fm = md_content.sub(/^---\n.*?---\n/m, '')
      comparison_content += "EXISTING MARKDOWN CONTENT (first 500 chars):\n"
      comparison_content += "-" * 80 + "\n"
      comparison_content += md_content_no_fm[0..500]
      comparison_content += "\n...\n"
    end

    File.write(comparison_file, comparison_content, encoding: 'UTF-8')

    puts "  ✅ Extracted to: #{review_file}"
    puts "  📊 Comparison: #{comparison_file}"

  rescue => e
    puts "  ❌ ERROR: #{e.message}"
  end
end

puts ""
puts "=" * 80
puts "EXTRACTION COMPLETE"
puts "=" * 80
puts ""
puts "Review directory created: #{review_dir}/"
puts ""
puts "Next steps:"
puts "  1. Review extracted HTML content in: #{review_dir}/"
puts "  2. Compare with existing markdown files"
puts "  3. Manually update markdown files with missing content"
puts "  4. Pay special attention to files with 100% difference"
puts ""
puts "Files are organized by category (balance/life/work)"
puts "Each file has:"
puts "  - *_extracted.html: Raw HTML content"
puts "  - *_comparison.txt: Side-by-side comparison"
puts ""
