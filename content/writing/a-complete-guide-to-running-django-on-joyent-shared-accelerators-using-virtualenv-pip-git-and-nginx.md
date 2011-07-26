---
title: A (Complete) Guide to Running Django on Joyent Shared Accelerators using Virtualenv, pip, git, and NginX
slug: django-on-joyent
markup: html
kind: article
author: Evan H. Carmi
created_at: "2011-01-24"
updated_at: "2011-01-24"
published: true
featured: true
comments_enabled: true
tags: django, python, virtualenv, git, pip, joyent
summary: A guide to installing a <a href="http://www.djangoproject.com/" title="A kick-ass Python Web framework">Django</a> application on a Joyent Shared Accelerator inside a <a href="http://virtualenv.openplans.org/" title="A tool to create isolated Python environments">Virtualenv</a> using <a href="http://pip.openplans.org/" title="pip installs packages. Python packages.">pip</a>, <a href="http://git-scm.com/" title="A distributed version control system">git</a> and <a href="http://nginx.org/" title="An HTTP server">NginX</a>
---
<div class="toc"> 
<ul> 
<li><a href="#getting-started-setting-up-your-development-environment">Getting started: setting up your development environment</a><ul> 
<li><a href="#install-django-inside-a-virtualenv">Install Django inside a virtualenv</a></li> 
<li><a href="#create-a-git-repository">Create a git repository</a></li> 
<li><a href="#use-requirements-and-pip-freeze">Use requirements and pip freeze</a></li> 
</ul> 
</li> 
<li><a href="#deploying-getting-your-app-on-the-server">Deploying: getting your app on the server</a><ul> 
<li><a href="#install-virtualenv-on-joyent">Install virtualenv on Joyent</a></li> 
<li><a href="#upload-your-application-to-the-server">Upload your application to the server</a></li> 
<li><a href="#install-packages-on-the-server-with-pip">Install packages on the server with pip</a></li> 
<li><a href="#setup-static-media">Setup static media</a></li> 
<li><a href="#setup-nginx-and-fastcgi">Setup NginX and FastCGI</a></li> 
</ul> 
</li> 
<li><a href="#coming-soon">Coming Soon</a></li> 
</ul> 
</div> 
<p>In this guide we'll go over the process of deploying a <a href="http://www.djangoproject.com/" title="A kick-ass Python Web framework">Django</a> application on a <a href="http://www.joyent.com/" title="A web host where I have a lifetime account">Joyent</a> Shared Accelerator (now called SmartMachines).</p> 
<p>We'll be using the following tools:</p> 
<ul> 
<li><em><a href="http://virtualenv.openplans.org/" title="A tool to create isolated Python environments">Virtualenv</a></em> - to isolate our Python environment and manage software versions.</li> 
<li><em><a href="http://pip.openplans.org/" title="pip installs packages. Python packages.">pip</a></em> - to install packages.</li> 
<li><em><a href="http://git-scm.com/" title="A distributed version control system">git</a></em> - for version control</li> 
<li><em><a href="http://nginx.org/" title="An HTTP server">NginX</a></em> - to serve our Django site through FastCGI.</li> 
</ul> 
<h1 id="getting-started-setting-up-your-development-environment">Getting started: setting up your development environment</h1> 
<p>Let's setup our development environment on our local machine using <a href="http://virtualenv.openplans.org/" title="A tool to create isolated Python environments">Virtualenv</a> and <a href="http://pip.openplans.org/" title="pip installs packages. Python packages.">pip</a>.</p> 
<div class="codehilite"><pre><span class="nv">$ </span>virtualenv --no-site-packages mysite
<span class="nv">$ </span><span class="nb">cd </span>mysite/
<span class="nv">$ </span>. bin/activate
<span class="nv">$ </span>pip --version
pip 0.8.2 from /home/evan/mysite/lib/python2.6/site-packages <span class="o">(</span>python 2.6<span class="o">)</span> 
</pre></div> 
 
 
<p>Inside your virtualenv upgrade pip.</p> 
<div class="codehilite"><pre>pip install --upgrade pip
</pre></div> 
 
 
<h2 id="install-django-inside-a-virtualenv">Install Django inside a virtualenv</h2> 
<p>Note: If your application is already inside a virtualenv with packages installed by pip you can skip down to the <a href="#deploying-getting-your-app-on-the-server">Deploying</a> section below.</p> 
<p>Let's install the latest stable release of Django (1.2.4 as of today) using pip.</p> 
<div class="codehilite"><pre><span class="nv">$ </span>pip install Django
Downloading/unpacking Django
  Downloading Django-1.2.4.tar.gz <span class="o">(</span>6.4Mb<span class="o">)</span>: 6.4Mb downloaded
  Running setup.py egg_info <span class="k">for </span>package Django
Installing collected packages: Django
  Running setup.py install <span class="k">for </span>Django
    changing mode of build/scripts-2.6/django-admin.py from 644 to 755
    changing mode of /home/evan/mysite/bin/django-admin.py to 755
Successfully installed Django
Cleaning up...
</pre></div> 
 
 
<p>Create a new project, myproject, here. It should be in the same directory as bin, include, and lib that were created by virtualenv.</p> 
<div class="codehilite"><pre><span class="nv">$ </span>django-admin.py startproject myproject
<span class="nv">$ </span><span class="nb">cd </span>myproject/
<span class="nv">$ </span>django-admin.py runserver
Error: Settings cannot be imported, because environment variable DJANGO_SETTINGS_MODULE is undefined.
</pre></div> 
 
 
<p>Oops! We're getting an error because Django cannot find and import our settings.py file. Let's fix that by putting our project directory into the virtualenv's site-packages directory with a symbolic link:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>ln -s <span class="sb">`</span><span class="nb">pwd</span><span class="sb">`</span> ../lib/python2.6/site-packages/<span class="sb">`</span>basename <span class="se">\`</span><span class="nb">pwd</span><span class="se">\`</span><span class="sb">`</span> 
</pre></div> 
 
 
<p>If you are using a different version of Python change <code>python2.6</code> to reflect that version.</p> 
<p>And then defining the <code>DJANGO_SETTINGS_MODULE</code> environment variable. Also, let's make it so this environment variable is set every time we activate the virtualenv.</p> 
<div class="codehilite"><pre><span class="nv">$ </span><span class="nb">export </span><span class="nv">DJANGO_SETTINGS_MODULE</span><span class="o">=</span>myproject.settings
<span class="nv">$ </span><span class="nb">echo</span> <span class="s2">&quot;!!&quot;</span> &gt;&gt; ../bin/activate
</pre></div> 
 
 
<p>Now let's try the <code>runserver</code> command again.</p> 
<div class="codehilite"><pre><span class="nv">$ </span>django-admin.py runserver
Validating models...
0 errors found
 
Django version 1.2.4, using settings <span class="s1">&#39;myproject.settings&#39;</span> 
Development server is running at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
</pre></div> 
 
 
<p>Great! Everything is working.</p> 
<h2 id="create-a-git-repository">Create a git repository</h2> 
<p>We want to create our git repository inside the myproject directory to track our Django application.</p> 
<div class="codehilite"><pre><span class="nv">$ </span>git init .
Initialized empty Git repository in /home/evan/mysite/myproject/.git/
<span class="nv">$ </span><span class="nb">echo</span> <span class="s2">&quot;My Django app for Joyent&quot;</span> &gt; README
<span class="nv">$ </span>git add README
<span class="nv">$ </span>git commit -m <span class="s2">&quot;Initialzed repository and added README&quot;</span> 
<span class="o">[</span>master <span class="o">(</span>root-commit<span class="o">)</span> 7d09bd1<span class="o">]</span> Initialzed repository and added README
1 files changed, 1 insertions<span class="o">(</span>+<span class="o">)</span>, 0 deletions<span class="o">(</span>-<span class="o">)</span> 
create mode 100644 README
</pre></div> 
 
 
<p>Here you should create your application. I'll just use the <a href="http://docs.djangoproject.com/en/dev/intro/tutorial01/" title="A tutorial to learn Django">Django Tutorial</a> for now.</p> 
<h2 id="use-requirements-and-pip-freeze">Use requirements and pip freeze</h2> 
<p>We want to create a list of all the necessary packages for our project. The <code>pip freeze</code>command can help us with this, but we can't just use every package from the list because some packages like <em>fabric</em> and <em>paramiko</em> won't successfully install on the Share Accelerator.</p> 
<p>My REQUIREMENTS file is very short:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>cat REQUIREMENTS 
<span class="nv">Django</span><span class="o">==</span>1.2.4
django-debug-toolbar<span class="o">==</span>0.8.4
<span class="nv">wsgiref</span><span class="o">==</span>0.1.2
</pre></div> 
 
 
<p>Great. Let's get this app running on Joyent.</p> 
<h1 id="deploying-getting-your-app-on-the-server">Deploying: getting your app on the server</h1> 
<p>First off, login to your virtualmin page (my server, harbor, is at <a href="https://virtualmin.joyent.us/harbor/">https://virtualmin.joyent.us/harbor/</a> )and create a virtual server for your new site if you haven't yet.</p> 
<p>Now you should create a database. I'd recommend creating a PostgreSQL database. If you'd like you can also create a separate user to access the database with. For simplicity, I'll just use my main user account for now.</p> 
<h2 id="install-virtualenv-on-joyent">Install virtualenv on Joyent</h2> 
<p>To use <code>virtualenv</code> on your server you need to first get it on your server. We'll download it from <a href="http://pypi.python.org/pypi" title="The Python Package Index">PyPi</a>.</p> 
<p><code>ssh</code> in to your server and:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>mkdir -p <span class="nb">local</span>/
<span class="nv">$ </span><span class="nb">cd local</span>/
<span class="nv">$ </span>wget -O virtualenv-1.5.1.tar.gz http://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.5.1.tar.gz
<span class="nv">$ </span>tar xzvf virtualenv-1.5.1.tar.gz
</pre></div> 
 
 
<p>Let's now create our virtualenv on our server. This is the same as on our local machine.</p> 
<div class="codehilite"><pre><span class="nv">$ </span>python virtualenv.py --no-site-packages ~/django_projects/mysite
<span class="nv">$ </span><span class="nb">cd</span> ~/django_projects/mysite/
<span class="nv">$ </span>. bin/activate
</pre></div> 
 
 
<h2 id="upload-your-application-to-the-server">Upload your application to the server</h2> 
<p>Now, get your project directory inside this newly created virtualenv. It really doesn't matter how. If you're using <a href="http://github.com/" title="Hosted git repositories">github</a> you might want to <a href="http://help.github.com/deploy-keys/" title="A github help page on using deploy keys">create a deploy key</a> These days, this seems to be the preferred way to deploy.</p> 
<p>If you're using github, clone your project with:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>git clone git@github.com:carmi/mysite.git
Initialized empty Git repository in /users/home/carmi/django_projects/mysite/mysite/.git/
</pre></div> 
 
 
<p>Great! Now we should have our project directory myproject inside our virtualenv on the same level as <code>bin</code>, <code>lib</code> and <code>include</code>. Make sure you've modified your settings file for production and updated the database settings to use your PostgreSQL database instead of sqlite3. My databases looks like:</p> 
<div class="codehilite"><pre><span class="n">DATABASES</span> <span class="o">=</span> <span class="p">{</span> 
    <span class="s">&#39;default&#39;</span><span class="p">:</span> <span class="p">{</span> 
        <span class="s">&#39;ENGINE&#39;</span><span class="p">:</span> <span class="s">&#39;postgresql_psycopg2&#39;</span><span class="p">,</span> 
        <span class="s">&#39;NAME&#39;</span><span class="p">:</span> <span class="s">&#39;carmi_django_mysite_database&#39;</span><span class="p">,</span> 
        <span class="s">&#39;USER&#39;</span><span class="p">:</span> <span class="s">&#39;carmi&#39;</span><span class="p">,</span> 
        <span class="s">&#39;PASSWORD&#39;</span><span class="p">:</span> <span class="s">&#39;password&#39;</span><span class="p">,</span> 
        <span class="s">&#39;HOST&#39;</span><span class="p">:</span> <span class="s">&#39;localhost&#39;</span><span class="p">,</span> 
        <span class="s">&#39;PORT&#39;</span><span class="p">:</span> <span class="s">&#39;5432&#39;</span><span class="p">,</span> 
    <span class="p">}</span> 
<span class="p">}</span> 
</pre></div> 
 
 
<p>Try running <code>django-admin.py syncdb</code>. If it works then your database is configured correctly.</p> 
<p>Setup the server's virtualenv.:</p> 
<div class="codehilite"><pre><span class="nv">$ </span><span class="nb">cd</span> ~/django_projects/mysite/myproject/
<span class="nv">$ </span>ln -s <span class="sb">`</span><span class="nb">pwd</span><span class="sb">`</span> ../lib/python2.6/site-packages/<span class="sb">`</span>basename <span class="se">\`</span><span class="nb">pwd</span><span class="se">\`</span><span class="sb">`</span> 
span class="nv">$ </span><span class="nb">export </span><span class="nv">DJANGO_SETTINGS_MODULE</span><span class="o">=</span>myproject.settings
<span class="nv">$ </span><span class="nb">echo</span> <span class="s2">&quot;!!&quot;</span> &gt;&gt; ../bin/activate
</pre></div> 
 
 
<h2 id="install-packages-on-the-server-with-pip">Install packages on the server with pip</h2> 
<p>Let's install the packages in our REQUIREMENTS file.</p> 
<div class="codehilite"><pre><span class="nv">$ </span>pip install -r REQUIREMENTS
</pre></div> 
 
 
<p>We will need <a href="http://trac.saddi.com/flup" title="A random collection of WSGI modules">flup</a> and psycopg2 (for PostgreSQL). Let's install those:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>pip install flup psycopg2
</pre></div> 
 
 
<h2 id="setup-static-media">Setup static media</h2> 
<p>Let's assume you have some static media for your project in <code>~/django_projects/mysite/myproject/media/</code></p> 
<p>For security reasons (but don't trust me on this) we don't want to serve static media (CSS, Javacsript) from inside our project directory. Instead, let's create some other directories to serve static media from:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>mkdir -p ~/django_projects/mysite/web/public
</pre></div> 
 
 
<p>And then create a symbolic link from there to our media directory.</p> 
<div class="codehilite"><pre><span class="nv">$ </span>ln -s ~/django_projects/mysite/myproject/media/ ~/django_projects/mysite/web/public/media
</pre></div> 
 
 
<p>Now let's link Django's <code>contrib.admin</code> media to this location:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>ln -s ~/django_projects/mysite/lib/python2.6/site-packages/django/contrib/admin/media/ ~/django_projects/mysite/myproject/media/admin
</pre></div> 
 
 
<p>And lastly let's configure our <code>settings.py</code> to use these locations:</p> 
<div class="codehilite"><pre><span class="n">MEDIA_URL</span> <span class="o">=</span> <span class="s">&#39;/media/&#39;</span> 
<span class="n">ADMIN_MEDIA_PREFIX</span> <span class="o">=</span> <span class="s">&#39;/media/admin/&#39;</span> 
</pre></div> 
 
 
<h2 id="setup-nginx-and-fastcgi">Setup NginX and FastCGI</h2> 
<p>Now let's get <a href="http://nginx.org/" title="An HTTP server">NginX</a> running.</p> 
<p>Create a <code>nginx.conf</code> file inside your site directory:</p> 
<div class="codehilite"><pre><span class="nv">$</span> <span class="nv">mkdir</span> <span class="o">-</span><span class="n">p</span> <span class="o">~</span><span class="sr">/django_projects/m</span><span class="n">ysite</span><span class="sr">/etc/</span> 
<span class="nv">$</span> <span class="nv">vim</span> <span class="o">~</span><span class="sr">/django_projects/m</span><span class="n">ysite</span><span class="sr">/etc/</span><span class="n">nginx</span><span class="o">.</span><span class="n">conf</span> 
</pre></div> 
 
 
<p>Edit your <code>nginx.conf</code> file to look like the following but with your own <a href="http://wiki.joyent.com/shared:ports" title="Joyent wiki page on Managing Ports">port number</a>, domain, and username. In the example my port is <code>10071</code>, my domain is <code>django.joyeurs.com</code>, and my username is <code>carmi</code>:</p> 
<div class="codehilite"><pre><span class="k">events</span> <span class="p">{</span> 
    <span class="kn">worker_connections</span>  <span class="mi">24</span><span class="p">;</span> 
<span class="p">}</span> 
 
<span class="k">http</span> <span class="p">{</span> 
    <span class="kn">include</span>     <span class="s">/opt/local/etc/mime.types</span><span class="p">;</span> 
    <span class="kn">default_type</span>  <span class="s">application/octet-stream</span><span class="p">;</span> 
 
    <span class="kn">server</span> <span class="p">{</span> 
        <span class="kn">listen</span>       <span class="mi">10071</span><span class="p">;</span> 
        <span class="kn">server_name</span>  <span class="s">django.joyeurs.com</span><span class="p">;</span> 
 
        <span class="kn">location</span> <span class="s">/media</span> <span class="p">{</span> 
            <span class="kn">root</span>   <span class="s">/users/home/carmi/django_projects/mysite/web/public</span><span class="p">;</span> 
        <span class="p">}</span> 
 
        <span class="kn">location</span> <span class="s">/</span> <span class="p">{</span> 
            <span class="kn">fastcgi_pass</span> <span class="s">unix:/users/home/carmi/django_projects/mysite/myproject/myproject.socket</span><span class="p">;</span> 
 
            <span class="c1"># fastcgi parameters</span> 
            <span class="kn">fastcgi_param</span> <span class="s">PATH_INFO</span> <span class="nv">$fastcgi_script_name</span><span class="p">;</span> 
            <span class="kn">fastcgi_param</span> <span class="s">QUERY_STRING</span> <span class="nv">$query_string</span><span class="p">;</span> 
            <span class="kn">fastcgi_param</span> <span class="s">REQUEST_METHOD</span> <span class="nv">$request_method</span><span class="p">;</span> 
            <span class="kn">fastcgi_param</span> <span class="s">SERVER_PORT</span> <span class="nv">$server_port</span><span class="p">;</span> 
            <span class="kn">fastcgi_param</span> <span class="s">SERVER_PROTOCOL</span> <span class="nv">$server_protocol</span><span class="p">;</span> 
            <span class="kn">fastcgi_param</span> <span class="s">SERVER_NAME</span> <span class="nv">$server_name</span><span class="p">;</span> 
            <span class="kn">fastcgi_param</span> <span class="s">CONTENT_TYPE</span> <span class="nv">$content_type</span><span class="p">;</span> 
            <span class="kn">fastcgi_param</span> <span class="s">CONTENT_LENGTH</span> <span class="nv">$content_length</span><span class="p">;</span> 
        <span class="p">}</span>    
    <span class="p">}</span>   
<span class="p">}</span> 
</pre></div> 
 
 
<p>Create an <code>init.sh</code> script in your project directory to start the Django FastCGI process that should look like:</p> 
<div class="codehilite"><pre><span class="c">#!/usr/local/bin/bash</span> 
 
<span class="c">#Activate the virtualenv</span> 
<span class="nb">source</span> /users/home/carmi/django_projects/mysite/bin/activate
 
<span class="nv">PROJECT_NAME</span><span class="o">=</span><span class="s2">&quot;myproject&quot;</span> 
<span class="nv">PROJECT_DIR</span><span class="o">=</span><span class="s2">&quot;/users/home/carmi/django_projects/mysite/myproject&quot;</span> 
<span class="nv">PID_FILE</span><span class="o">=</span><span class="s2">&quot;/users/home/carmi/django_projects/mysite/myproject/myproject.pid&quot;</span> 
<span class="nv">SOCKET_FILE</span><span class="o">=</span><span class="s2">&quot;/users/home/carmi/django_projects/mysite/myproject/myproject.socket&quot;</span> 
<span class="nv">BIN_PYTHON</span><span class="o">=</span><span class="s2">&quot;/users/home/carmi/django_projects/mysite/bin/python&quot;</span> 
<span class="nv">DJANGO_ADMIN</span><span class="o">=</span><span class="s2">&quot;/users/home/carmi/django_projects/mysite/bin/django-admin.py&quot;</span> 
<span class="nv">OPTIONS</span><span class="o">=</span><span class="s2">&quot;maxchildren=2 maxspare=2 minspare=1&quot;</span> 
<span class="nv">METHOD</span><span class="o">=</span><span class="s2">&quot;prefork&quot;</span> 
 
<span class="k">case</span> <span class="s2">&quot;$1&quot;</span> in
    start<span class="o">)</span> 
      <span class="c"># Starts the Django process</span> 
      <span class="nb">echo</span> <span class="s2">&quot;Starting Django project&quot;</span> 
      <span class="nv">$BIN_PYTHON</span> <span class="nv">$DJANGO_ADMIN</span> runfcgi <span class="nv">$OPTIONS</span> <span class="nv">method</span><span class="o">=</span><span class="nv">$METHOD</span> <span class="nv">socket</span><span class="o">=</span><span class="nv">$SOCKET_FILE</span> <span class="nv">pidfile</span><span class="o">=</span><span class="nv">$PID_FILE</span> 
  ;;  
    stop<span class="o">)</span> 
      <span class="c"># stops the daemon by cating the pidfile</span> 
      <span class="nb">echo</span> <span class="s2">&quot;Stopping Django project&quot;</span> 
      <span class="nb">kill</span> <span class="sb">`</span>/bin/cat <span class="nv">$PID_FILE</span><span class="sb">`</span> 
  ;;  
    restart<span class="o">)</span> 
      <span class="c">## Stop the service regardless of whether it was</span> 
      <span class="c">## running or not, start it again.</span> 
      <span class="nb">echo</span> <span class="s2">&quot;Restarting process&quot;</span> 
      <span class="nv">$0</span> stop
      <span class="nv">$0</span> start
  ;;  
    *<span class="o">)</span>  
      <span class="nb">echo</span> <span class="s2">&quot;Usage: init.sh (start|stop|restart)&quot;</span> 
      <span class="nb">exit </span>1
  ;;  
<span class="k">esac</span> 
</pre></div> 
 
 
<p>You'll need to make this <code>init.sh</code> file executable:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>chmod +x ~/django_projects/mysite/myproject/init.sh
</pre></div> 
 
 
<p>Startup the Django FastCGI instance with:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>~/django_projects/mysite/myproject/init.sh start
</pre></div> 
 
 
<p>This script also takes <code>start</code>, <code>stop</code>, and <code>restart</code> as parameters.</p> 
<p>Now launch NginX with your configuration file:</p> 
<div class="codehilite"><pre><span class="nv">$ </span>/usr/local/sbin/nginx -p /users/home/carmi/ -c /users/home/carmi/django_projects/mysite/etc/nginx.conf
</pre></div> 
 
 
<p>We should now having our Django application running. Go to <a href="http://domain.com:PORTNUBMER/">http://domain.com:PORTNUBMER/</a> to see it. For my app, we can login to the admin interface by going to: <a href="http://django.joyeurs.com:10071/admin/">http://django.joyeurs.com:10071/admin/</a></p> 
<p>Now, in virtualmin create bootup actions to start the Django FastCGI process and NginX on server reboots.</p> 
<p>Great! We've just covered setting up a Django application on a Joyent Shared Accelerator using virtualenv, pip, NginX, and git.</p> 
<p>Please let me know if something is not working, or if you'd just like to leave some feedback.</p> 
<h1 id="coming-soon">Coming Soon</h1> 
<p>Wait a second! This is a long guide. Are we really all going to repeat the same steps over and over? Coming soon is a python script to automate this entire install process. Stay posted.</p> 
