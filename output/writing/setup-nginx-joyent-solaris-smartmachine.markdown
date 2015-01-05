
## SmartMachine == Solaris != Ubuntu

I recently setup Nginx on my Joyent [SmartMachine](http://www.joyent.com/software/smartmachines/). A SmartMachine is just a [Solaris](http://en.wikipedia.org/wiki/Solaris_(operating_system)) box. However, Solaris ain't Ubuntu. You don't have any [super cow powers](http://en.wikipedia.org/wiki/Advanced_Packaging_Tool) and things are in a slightly different spot.

Unfortunately, Joyent has <strike>no</strike>little [documentation](http://wiki.joyent.com/display/smart/SmartMachines+Home), and Solaris, like all non-Ubuntu OS's has documentation that often leaves something to be desired.

## Disable Apache

First off, you need to disable Apache so Nginx can have port 80 all to itself.

To do this you need to use the [service management facility](http://wiki.joyent.com/display/smart/About+the+Service+Management+Facility) built into Solaris. While, right now, I'm much more comfortable with upstart and init.d, I think that services might be a decent Solaris functionality. But we will have to see.

Nonetheless, to see all running services run:

    svcs -a
    STATE          STIME    FMRI
    legacy_run      0:20:04 lrc:/etc/rc2_d/S20sysetup
    legacy_run      0:20:04 lrc:/etc/rc2_d/S72autoinstall
    legacy_run      0:20:04 lrc:/etc/rc2_d/S89PRESERVE
    legacy_run      0:20:04 lrc:/etc/rc2_d/S98deallocate
    ...

You should see a list of online and disabled services. To modify these, use the `svcadm` command.

    sudo svcadm disable apache


## Install Nginx

Great. Now we can focus on Nginx.

Note: If you have never talked outloud about Nginx you may not know that it's pronounced [Engine-X](http://wiki.nginx.org/Faq#How_do_you_pronounce_.22Nginx.22.3F). That'll make reading this article in your head easier :)

Nginx is probably already installed on your SmartMachine, but to check you can use `pgkin`.

If installed you'll see:

    $ pkgin install nginx
    calculating dependencies for nginx...
    nothing to do.

And let's enable it:

    $ sudo svcadm enable nginx

Now, to confirm it's online:

    $ svcs -a | grep nginx
    online          0:20:03 svc:/network/http:nginx

Awesome.

If you ran into some issues and are unsure whether Nginx or apache is running try curl'ing localhost with the -I (send a INFO http request) to see the server type:

    $ curl -I localhost
    HTTP/1.1 200 OK
    Server: nginx
    Date: Mon, 18 Jul 2011 02:16:25 GMT
    Content-Type: text/html; charset=utf-8
    Content-Length: 5031
    Last-Modified: Sun, 17 Jul 2011 23:03:46 GMT
    Connection: keep-alive
    Accept-Ranges: bytes

Superb. We now have Nginx running on your SmartMachine. You might think that this so far is easy (and it is), but [a quick search](http://lmgtfy.com/?q=install+nginx+on+joyent+smart+machine) actually has few simple guides or docs on how to get this far.

## Configure Nginx

Okay, so first off, you'll be searching and searching for you Nginx configuration files.

We can find the default directories and files with:

    $ nginx -V
    nginx version: nginx/0.8.41
    TLS SNI support enabled
    configure arguments: --user=www --group=www --with-ld-opt='-L/opt/local/lib -Wl,-R/opt/local/lib' --prefix=/opt/local --sbin-path=/opt/local/sbin --conf-path=/opt/local/etc/nginx/nginx.conf --pid-path=/var/db/nginx/nginx.pid --lock-path=/var/db/nginx/nginx.lock --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/db/nginx/client_body_temp --http-proxy-temp-path=/var/db/nginx/proxy_temp --http-fastcgi-temp-path=/var/db/nginx/fstcgi_temp --with-http_ssl_module --with-http_dav_module --with-http_realip_module --with-http_stub_status_module

Great, what do we see?
the place to be /opt/local/etc/nginx/nginx.conf

Okay, so we go look at that in our editor of choice (vim, of course).

So we have a basic Nginx configuration. But we want a quality setup! We want to have multiple domains running on the same Nginx instance with separate configuration files. So let's set that up.

Most systems come with a sites-enabled and sites-available setup. The version you install with pkgin on Solaris sadly does not. But, there is no magic to those directories, so let's create them ourselves.

Recalling your Nginx 101 course, sites-available/ is a directory of all the possible site configuration files. Then, when you want to enable a site, you create a symlink (`ln -s`) from sites-available to sites-enabled.

We create those two directories next to where the default nginx.conf file lives.

    $ sudo mkdir -p /opt/local/etc/nginx/sites-enabled
    $ sudo mkdir -p /opt/local/etc/nginx/sites-available

Okay, now it's configuration time!

We can leave most of our default nginx.conf file the way it is. But the key line we need to add (unless it is already present in your conf) is:


    include /etc/nginx/sites-enabled/*;

This little include can be placed anywhere insude the http {} block

So my config file looks like:

    $ cat nginx.conf 
    user www www;
    worker_processes 1;
    error_log /var/log/nginx/error.log;
    pid /var/spool/nginx/nginx.pid;

    events {
            worker_connections 1024;
            use /dev/poll; # important on Solaris
    }

    http {
            include /opt/local/etc/nginx/mime.types;
            default_type application/octet-stream;
            log_format main '$remote_addr - $remote_user [$time_local] $request '
                            '"$status" $body_bytes_sent "$http_referer" '
                            '"$http_user_agent" "$http_x_forwarded_for"';
            access_log /var/log/nginx/access.log main;
            sendfile off; # important on Solaris
            keepalive_timeout 60;
            server_tokens off;
#       gzip on;
#       gzip_http_version 1.0;
#       gzip_comp_level 2;
#       gzip_proxied any;
#       gzip_types text/plain text/html text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript;

            include /opt/local/etc/nginx/sites-enabled/*;
            server {
                    listen 80;
                    # Defaults to hostname
#               server_name fgad8daa.joyent.us;
                    charset utf-8;
                    access_log /home/jill/logs/nginx.access.log main;
                    location / {
                            root /home/jill/web/public;
                            index index.html index.php maintenance.html;
                    }

                    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
#               location ~ \.php$ {
#                       proxy_pass http://127.0.0.1;
#               }

                    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
#               location ~ \.php$ {
#                       fastcgi_pass 127.0.0.1:9000;
#                       fastcgi_index index.php;
#                       fastcgi_param SCRIPT_FILENAME /home/jill/web/public$fastcgi_script_name;
#                       include /opt/local/etc/nginx/fastcgi_params;
#               }

                    location ~ /\.ht {
                            deny all;
                    }

                    error_page 500 502 503 504 /50x.html;
                    location = /50x.html {
                            root share/examples/nginx/html;
                    }
            }

            server {
                    listen 443;
                    # Defaults to hostname
#               server_name fgad8daa.joyent.us;
                    ssl on;
                    ssl_certificate /opt/local/etc/openssl/private/selfsigned.pem;
                    ssl_certificate_key /opt/local/etc/openssl/private/selfsigned.pem;
                    ssl_prefer_server_ciphers on;

                    location / {
                            root /home/jill/web/public;
                            index index.php maintenance.html;
                    }

                    location ~ /\.ht {
                            deny all;
                    }

                    error_page 500 502 503 504 /50x.html;
                    location = /50x.html {
                            root share/examples/nginx/html;
                    }
            }
    }


So I added mine right before the `server{}` block. I'm not sure what the best practice for placing this include is, but this makes logical sense, you import your settings, and then can override any of them below. This way it's easier to debug and you won't have something that's getting included overwriting your main config.

Let's create some sites!

We simply create a file in our sites-available directory.

    $ sudo vim /opt/local/etc/nginx/sites-available/staging.conf

  And my file looks like:

    server {
          listen 80;
          # Defaults to hostname
          server_name staging.ecarmi.org;
          charset utf-8;
          access_log /home/jill/www/sites/staging/logs/nginx.access.log main;
          location / {
                  root /home/jill/www/sites/staging/web/public;
                  index index.html;
          }

          location ~ /\.ht {
                  deny all;
          }

          error_page 500 502 503 504 /50x.html;
          location = /50x.html {
                  root share/examples/nginx/html;
          }
    }


And very importantly, we need to symlink this file to sites-enabled.

    $ sudo ln -s /opt/local/etc/nginx/sites-available/staging.conf /opt/local/etc/nginx/sites-enabled/

Now, we need to point a DNS record to the server. I use dnsmadeeasy, so I needed to create an A record of staging.ecarmi.org. that points to 8.12.36.10 which is the public ip address of the server.

Note, it may take a few minutes for the DNS changes to propagate.

## Create a Directory Structure

Now we need to create all those directories in the home folder and place our content there. Jill is the default user on Joyent SmartMachines, but the strucutre can be whatever.

So in jill's home directory we will create a www/sites structure and then the name of the domain. And for each domain we will need a web/public and logs/ directories

    $ mkdir -p ~/www/sites/staging/web/public/
    $ mkdir -p ~/www/sites/staging/logs

Great, and let's place our fancy website in the web/public directory.

    $ echo "hello staging server" > ~/www/sites/staging/web/public/index.html

And, don't forget to restart nginx. We really only need it to reload it's configuartion settings, so `sudo nginx -s reload` should do the trick. If this doesn't work, you can of course, restart the whole thing.

Let's see if it worked. From you local computer

    $ curl staging.ecarmi.org
    hello staging server

There it is, it worked. cURL is great to use for testing this kind of stuff out because it doesn't cache anything.

Okay, now let's create another site.

### Step one: create the directory structure and files:

    $ mkdir -p ~/www/sites/prod/logs                             
    $ mkdir -p ~/www/sites/prod/web/public
    $ echo "hello production server" > ~/www/sites/prod/web/public/index.html

and we can also copy over our previous configuration file substituting prod for staging:

    $ sudo cp /opt/local/etc/nginx/sites-available/staging.conf /opt/local/etc/nginx/sites-available/prod.conf

And don't forget to use vim (or sed) to change staging to prod.

Then symlink prod from sites-available to sites-enabled

    $ sudo ln -s /opt/local/etc/nginx/sites-available/prod.conf /opt/local/etc/nginx/sites-enabled/

### Step two:

Create a DNS A record of prod.ecarmi.org point to the same ip address, replacing ecarmi.org with your own domain.

### Step three:

have Nginx reload it's configuration settings

    $ sudo nginx -s reload

or if you want to use svcadm magic

    $ sudo svcadm refresh nginx

and then back to curl

    $ curl prod.ecarmi.org
      hello production server
    $ curl staging.ecarmi.org    
      hello staging server

You are good to go!


