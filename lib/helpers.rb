require 'time'
require 'digest/md5'

# Activate helpers
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Breadcrumbs
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::XMLSitemap

def featured_articles
  articles = @items.select do |item|
    item[:kind] == 'article' && item[:featured] == true
  end
  articles.sort_by { |post| attribute_to_time(post[:created_at])}.reverse
end

def books
  books = @items.select do |item|
    item[:kind] == 'book' && item[:featured] == true
  end
  books.sort_by { |post| attribute_to_time(post[:created_at])}.reverse
end

# See: http://userprimary.net/posts/2011/01/10/optimizing-nanoc-based-websites/

# Route an Nanoc3::Item to a fingerprinted string for expires HTTP header
# happiness.
#
# @item - Nanoc3::Item to route
# @return - string serving as url for templates and Nanoc compatible route
def hashed_route(item)
  # HACK for dealing with css,scss, and sass, and js files dynamically
  # Assume directory name matches ending: /static/css/...

  ext = item.identifier.split('/')[2]

  if $development_mode
    "#{item.identifier.chop}.#{ext}"
  else
    digest = Digest::MD5.hexdigest item.raw_content
    # 6 hashed chars should be plenty.
    "#{item.identifier.chop}.#{digest[0,6]}.#{ext}"
  end
end

# Given a url to static object return the path to the unique object created
# using hashed_route.
def hashed_url(filename)
  # Strip extension and find item by identifier.
  ext = filename.match(/[.][a-z]+$/)[0]

  item = @items.detect { |x| x.identifier.include?(filename.gsub(ext,'')) }
  return hashed_route(item) unless item.nil?
end
#
#YUI_JAR = File.dirname(__FILE__) + "/../tools/yuicompressor-2.4.7.jar"
#
#class YuiCompressor < Nanoc3::Filter
#  identifier :yui_compress
#  type :text => :binary
#  def run(content, params={})
#    type = type_from_extension
#    cmd = "java -jar #{YUI_JAR} --type #{type} -o #{output_filename}"
#    IO.popen(cmd, 'w') { |f| f.write(content) }
#    raise "yuicompressor exited with #{$?} for '#{cmd}'" unless $? == 0
#  end
#
#  def type_from_extension
#    case @item[:extension]
#    when /^css/
#      "css"
#    when /^js/
#      "js"
#    else
#      raise "unknown type for yuicompressor '#{@item[:extension]}'"
#    end
#  end
#end

# Articles are sorted by descending creation date, so newer articles appear
# before older articles. Thus sorted_articles[0] is the newest article
def previous_link
  prev = sorted_articles.index(@item) + 1
  prev_article = sorted_articles[prev]
  if prev_article.nil?
    ''
  else
    title = prev_article[:title]
    html = "&larr; Previous"
    link_to(html, prev_article.reps[0], :class => "previous", :title => title)
  end
end

def next_link
  nxt = sorted_articles.index(@item) - 1
  if nxt < 0
    ''
  else
    post = sorted_articles[nxt]
    title = post[:title]
    html = "Next &rarr;"
    link_to(html, post.reps[0], :class => "next", :title => title)
  end
end
