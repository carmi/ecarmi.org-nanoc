---
title: Setup HAProxy stats over HTTPS
slug: setup-haproxy-stats-over-https
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2015-01-21"
updated_at: "2015-01-21"
published: true
featured: true
comments_enabled: true
summary: Setting up HAProxy's stats interface over secure HTTPS
---
### The Short Version:

Use a `bind` in the stats block and append `ssl crt /path/to/ssl.pem` so you'd have something like:

    bind *:50000 ssl crt /etc/ssl/mysite_com.pem

### The Long Version:
I use [HAProxy](http://www.haproxy.org/) as a load balancer and SSL/TLS terminator. It has a nice stats feature with useful information. However, most stats configurations and examples are over unencrypted HTTP. This is fine if it is only available via a private network. But HAProxy is usually a front-end load balancer so it is often accessible across the dangerous open internet. And if you are using Basic Auth user authentication for your HAProxy stats over HTTP then anyone can easily see the Username/Password combo that you are using sending in, effectively comprising the authentication.

So I want my stats to be over HTTPS just like everything else. I went out in search of this and didn't find much information, so I thought this would be useful to other people (and my future self.)

All the config for the load balancing and SSL termination live in a `haproxy.cfg` file.

To enable stats over SSL you can simply add `ssl crt /path/to/ssl.pem` to your `bind` statement in the `stats` declaration block.


    listen stats
      bind *:50000 ssl crt /etc/ssl/mysite_com.pem
      mode http
      stats enable
      stats hide-version
      stats realm Haproxy\ Statistics
      stats uri /stats
      stats auth username:password

Here I setup the stats interface to listen on all IPs over port `50000`.
I also set the URL of the stats site to `/stats` and setup basic auth.
Since I already have an SSL certificate for my website, I can use that for the stats page also. If I access the stats site by the IP address of my server like <https://165.215.238.72:50000/stats> I will get an SSL warning mismatch. This is actually fine because I can verify that the certificate is valid and is my own. But wouldn't it be nice if we could just make this a valid certificate?

Well, we actually can with zero work. Since my DNS entry for my site resolves to the HAProxy load balancer I can just append the specific port to my domain and get access with my valid certificate: <https://example.com:50000/stats>.
