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
