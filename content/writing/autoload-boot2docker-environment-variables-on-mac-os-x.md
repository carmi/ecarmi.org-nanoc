---
title: Autoload boot2docker environment variables on Mac OS X
slug: autoload-boot2docker-environment-variables
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2015-01-09"
updated_at: "2015-01-09"
published: true
featured: true
comments_enabled: true
summary: Autoload boot2docker environment variables
---
If you use Docker on Mac OS X then it's likely you are using [boot2docker](https://docs.docker.com/installation/mac/)

To autoload boot2docker's environment variables (which is necessary to connect to your local docker daemon) you need to run `boot2docker shellinit`. If you add the following line to your `~/.zshrc` or `~/.bashrc`.

    #!bash
    eval $(boot2docker shellinit 2>/dev/null)

This will initialize the boot2docker environment variables and copy the output to null (so it doesn't display anything when you open up your terminal.
