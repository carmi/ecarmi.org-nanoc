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

# See: http://userprimary.net/posts/2011/01/10/optimizing-nanoc-based-websites/

# Add unique string to css/js filename for use with expires headers.
#
# @item - object or path to object
# @returns - the filename to be used in routes and templates
# Note: 6-hashed chars is enough

def hash_filename(item)
  unless @items.include?(item)
    ext = item.match(/[.][a-z]+$/)[0]
    item = @items.detect { |x| x.identifier.include?(item.gsub(ext,'')) }
    return if item.nil?
  end

  digest = Digest::MD5.hexdigest item.raw_content
  "#{item.identifier.chop}.#{digest[0,6]}#{ext}"
end
