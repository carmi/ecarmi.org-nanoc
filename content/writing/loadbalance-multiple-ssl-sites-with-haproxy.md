---
title: Load Balance multiple SSL sites with HAProxy
slug: load-balance-multiple-ssl-sites-with-haproxy
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2015-01-28"
updated_at: "2015-01-28"
published: true
featured: true
comments_enabled: true
summary: How to make a single HAProxy load balance and between two sites which both run on SSL
---

I have multiple web sites which I run over HTTPS on the same set of servers. I also use HAProxy as a load balancer and SSL terminator.  The HAProxy load balancer is the entry point for both sites. I.e. DNS for both domains point to the same IP address - that of the HAProxy node. I wasn't sure if I could manage multiple sites over HTTPS. You can!


    frontend http-in

      bind *:80
      bind *:443 ssl crt /etc/ssl/private/

      acl is_site1 hdr_end(host) -i site1.com
      acl is_site2 hdr_end(host) -i site2.com

      use_backend site1 if is_site1
      use_backend site2 if is_site2

Then we need to place our SSL/TLS certs in `/etc/ssl/private/`. If your OS has other certificates in that directory already, then you'll need to choose a new location that **only** contains the PEM files for the sites you are load balancing (here `site1.pem` and `site2.pem`). Sometimes /etc/ssl contains all the verified certificate authorities bundled into your OS, and HAProxy will try to read those as PEM files and throw an error.

The PEM files should be concatenation of the certificate, the key and optionally the certificate authorities.

HAProxy is able to manage both these sites by using [Server Name Indication](https://en.wikipedia.org/wiki/Server_Name_Indication) or SNI. Some ancient browsers do not support SNI (Internet Explorer on Windows XP).

Additionally, the amount of time to establish the secure connection is a bit longer because of the extra certificate information being exchanged.

But for me, this was a cool discovery to figure out how to do.

