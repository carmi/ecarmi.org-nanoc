#!/usr/bin/env ruby

# A ruby script to create a new nanoc post.

## SETTINGS

# Author
AUTHOR = "Evan H. Carmi"

# Directory structure
DIR_BASE = "content/writing"
FILE_ENDING = ".md"

KIND = "article"
MARKUP = "markdown"

require 'time'

puts "Please enter the title of the new post:"
raw_title = gets.strip

slug = raw_title.downcase # make lowercase
slug = slug.gsub(/[ _]/, '-') # change ' ' or '_' to '-'
slug = slug.gsub(/[^a-z0-9-]/, '') # strip everything except a-z, 0-9, and -

file_path = "#{DIR_BASE}/#{slug}#{FILE_ENDING}"

# Date and title
now = Time.now

NEW_POST = <<EOF
---
title: #{raw_title}
slug: #{slug}
markup: #{MARKUP}
kind: #{KIND}
author: #{AUTHOR}
created_at: "#{Time.now.utc.iso8601.to_s}"
updated_at: "#{Time.now.utc.iso8601.to_s}"
published: false
summary:
---
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam lacus ligula,
accumsan id imperdiet rhoncus, dapibus vitae arcu. Nulla non quam erat, luctus
consequat nisi. Integer hendrerit lacus sagittis erat fermentum tincidunt. Cras
vel dui neque. In sagittis commodo luctus. Mauris non metus dolor, ut suscipit
dui. Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum. Donec
gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque
elit in tortor. Mauris gravida, purus at ultrices sollicitudin, purus diam
dapibus leo, ut eleifend dolor tellus feugiat lacus. Class aptent taciti
sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam ut
fringilla dolor. Cras elit tellus, egestas eget congue sit amet, consequat in
orci.
EOF

# Create new file if it doesn't exist
if File.exists?(file_path)
  puts "Error: #{file_path} already exists"
else
  File.open(file_path, 'w') {|f| f.write(NEW_POST) }
  puts "Created #{file_path}"
end
