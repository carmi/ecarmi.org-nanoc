class Nanoc3::Item
  def timeago_time
    "<time class=\"timeago created-at\" datetime=\"#{Time.parse(self[:created_at]).iso8601}\">#{Date.parse(self[:created_at]).strftime('%B %e, %Y')}</time>"
  end
end
