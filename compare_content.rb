#!/usr/bin/env ruby
# encoding: UTF-8
# Content Comparison Script
# Compares HTML and Markdown files to detect content differences

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'fileutils'

# ANSI color codes for output
class String
  def red; "\e[31m#{self}\e[0m" end
  def green; "\e[32m#{self}\e[0m" end
  def yellow; "\e[33m#{self}\e[0m" end
  def blue; "\e[34m#{self}\e[0m" end
  def bold; "\e[1m#{self}\e[0m" end
end

def extract_html_content(html_file)
  content = File.read(html_file, encoding: 'UTF-8')

  # Extract content between <article> or <main> tags
  if content =~ /<article[^>]*>(.*?)<\/article>/m
    article_content = $1
  elsif content =~ /<main[^>]*>(.*?)<\/main>/m
    article_content = $1
  else
    return nil
  end

  # Remove HTML tags but keep text
  text = article_content.gsub(/<script[^>]*>.*?<\/script>/m, '')
  text = text.gsub(/<style[^>]*>.*?<\/style>/m, '')
  text = text.gsub(/<[^>]+>/, ' ')
  text = text.gsub(/\s+/, ' ').strip

  text
end

def extract_markdown_content(md_file)
  content = File.read(md_file, encoding: 'UTF-8')

  # Remove frontmatter
  content = content.sub(/^---\n.*?---\n/m, '')

  # Remove extra whitespace
  content = content.gsub(/\s+/, ' ').strip

  content
end

def compare_content_length(html_text, md_text)
  html_len = html_text&.length || 0
  md_len = md_text&.length || 0

  return 0 if html_len == 0 && md_len == 0

  diff_percent = ((html_len - md_len).abs.to_f / [html_len, md_len].max * 100).round(2)
  diff_percent
end

# Main comparison logic
categories = ['balance', 'life', 'work']
results = {
  identical: [],
  minor_diff: [],
  major_diff: [],
  missing_md: [],
  errors: []
}

puts "=" * 80
puts "CONTENT COMPARISON REPORT".bold
puts "=" * 80
puts ""

categories.each do |category|
  puts "\n#{category.upcase}".blue.bold
  puts "-" * 80

  html_files = Dir.glob("#{category}/*.html").reject { |f| f.include?('index.html') }

  html_files.each do |html_file|
    md_file = html_file.sub('.html', '.md')
    filename = File.basename(html_file)

    if !File.exist?(md_file)
      results[:missing_md] << html_file
      puts "  ⚠️  #{filename} - #{'MISSING MARKDOWN'.yellow}"
      next
    end

    begin
      html_content = extract_html_content(html_file)
      md_content = extract_markdown_content(md_file)

      if html_content.nil?
        results[:errors] << "#{html_file} - Could not extract content"
        puts "  ❌ #{filename} - #{'ERROR: Could not extract content'.red}"
        next
      end

      diff_percent = compare_content_length(html_content, md_content)

      if diff_percent == 0
        results[:identical] << html_file
        # Don't print identical files to reduce noise
      elsif diff_percent < 10
        results[:minor_diff] << { file: html_file, diff: diff_percent }
        puts "  ⚡ #{filename} - #{"Minor difference: #{diff_percent}%".yellow}"
      else
        results[:major_diff] << { file: html_file, diff: diff_percent }
        puts "  ⚠️  #{filename} - #{"MAJOR difference: #{diff_percent}%".red}"
      end

    rescue => e
      results[:errors] << "#{html_file} - #{e.message}"
      puts "  ❌ #{filename} - #{"ERROR: #{e.message}".red}"
    end
  end
end

# Summary Report
puts "\n"
puts "=" * 80
puts "SUMMARY".bold
puts "=" * 80
puts ""
puts "✅ Identical files: #{results[:identical].count}".green
puts "⚡ Minor differences (<10%): #{results[:minor_diff].count}".yellow
puts "⚠️  Major differences (≥10%): #{results[:major_diff].count}".red
puts "📝 Missing markdown files: #{results[:missing_md].count}".yellow
puts "❌ Errors: #{results[:errors].count}".red
puts ""

if results[:missing_md].any?
  puts "\nMISSING MARKDOWN FILES:".yellow.bold
  results[:missing_md].each { |f| puts "  - #{f}" }
  puts ""
end

if results[:major_diff].any?
  puts "\nMAJOR DIFFERENCES (Need Review):".red.bold
  results[:major_diff].each do |item|
    puts "  - #{item[:file]} (#{item[:diff]}% difference)"
  end
  puts ""
end

if results[:minor_diff].any?
  puts "\nMINOR DIFFERENCES:".yellow.bold
  results[:minor_diff].each do |item|
    puts "  - #{item[:file]} (#{item[:diff]}% difference)"
  end
  puts ""
end

if results[:errors].any?
  puts "\nERRORS:".red.bold
  results[:errors].each { |e| puts "  - #{e}" }
  puts ""
end

# Final assessment
puts "=" * 80
if results[:missing_md].count == 1 && results[:major_diff].empty? && results[:minor_diff].count < 5
  puts "✅ #{'GOOD NEWS: Content is mostly in sync!'.green.bold}"
  puts ""
  puts "Action needed:"
  puts "  1. Create markdown for missing HTML file (website-logs)"
  puts "  2. Review #{results[:minor_diff].count} files with minor differences (likely formatting)"
  puts "  3. Proceed with Jekyll migration"
else
  puts "⚠️  #{'ATTENTION: Manual review recommended'.yellow.bold}"
  puts ""
  puts "Action needed:"
  puts "  1. Review files with major differences"
  puts "  2. Create missing markdown files"
  puts "  3. Sync content before Jekyll migration"
end
puts "=" * 80
