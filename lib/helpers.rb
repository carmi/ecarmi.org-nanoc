require 'time'
# Activate helpers
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Breadcrumbs
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::XMLSitemap

def featured_articles
  articles = @items.select do |item|
    build_timeago(item)
    item[:kind] == 'article' && item[:featured] == true
  end
  articles.sort_by { |post| attribute_to_time(post[:created_at])}.reverse
end

def build_timeago(article)
  return unless article[:kind] == 'article'
  attrs = article.attributes
  created = Time.parse(attrs[:created_at])
  updated = Time.parse(attrs[:updated_at])

  if created.is_a? Time
    attrs[:created_time] = created.strftime("%B %e, %Y")
    attrs[:created_timeago] = created.utc.iso8601.to_s
  end

  if updated.is_a? Time
    attrs[:updated_time] = updated.strftime("%B %e, %Y")
    attrs[:updated_timeago] = updated.utc.iso8601.to_s
  end
end
