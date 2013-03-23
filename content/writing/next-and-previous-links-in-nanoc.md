---
title: Next and Previous Links in Nanoc
slug: next-previous-links-nanoc
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2013-03-23"
updated_at: "2013-03-23"
published: true
comments_enabled: true
tags: nanoc, ruby
summary: How to add next and previous links to a post using Nanoc
---
Note: this was tested in Nanoc 3.6.1

I've seen a few questions (and a few incorrect answers) about how to get next and previous links for a given item in [Nanoc](http://nanoc.ws/). If you are using the [blogging] module in Nanoc you can access all your articles in sorted order by descending creation date. Using this we can create a quick helper for next and previous links.

Add the following to your helpers, usually `lib/default.rb` or `lib/helpers.rb`:

    #!ruby
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

It's important to note that `sorted_articles` returns an array where `sorted_articles[0]` is the newest article. So if you want to get the next (newer) article you want to decrement the current index.

Once you have this in a helper module, you can use it in your layout with `previous_link`. My [post layout](https://github.com/carmi/ecarmi.org-nanoc/blob/develop/layouts/post.haml) is in [Haml](http://haml.info/) so it looks like:


    #!haml
    %article.post
      = yield

      %p.prev
        = previous_link
      %p.next
        = next_link

I use this on this blog, and you can check out the full source on [github](https://github.com/carmi/ecarmi.org-nanoc).

[blogging]: http://nanoc.ws/docs/api/Nanoc/Helpers/Blogging.html
