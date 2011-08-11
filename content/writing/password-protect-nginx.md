---
title: Password Protect Nginx Virtualhost
slug: password-protect-nginx
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2011-08-11"
updated_at: "2011-08-11"
published: true
comments_enabled: true
tags: nginx
summary: A simple guide to enable basic authentication for an Nginx virtualhost.
---

# How to Password Protect an Nginx virtualhost

Note: These instructions were tested on a Joyent Solaris SmartMachine. It should work on all other hosts though.

### Modify nginx.conf
Go into your nginx.conf for your server and add:

    location  /  {
      auth_basic            "Restricted";
      auth_basic_user_file  sitename.htpasswd;
    }

### Create authentication file
Create the authentication file by running:

    sudo htpasswd -c sitename.htpasswd user

and it will prompt you for your password for the site.

### Reload Nginx
Tell nginx to reload its configuration files:

    sudo nginx -s reload

You're done!

### Complete Documentation
For more information read the full docs on Nginx's [basic auth module](http://wiki.nginx.org/HttpAuthBasicModule).
