Hello! You are browsing the source code to ecarmi.org, a Nanoc powered blog by Evan Carmi.

# Installation

Install the gems from the Gemfile

Install Pygments for syntax highlighting

   sudo easy_install Pygments

# Write, view, and publish

To publish, update the nanoc.yaml file and then run
  `rake publish`

For local development start guard:

  `guard`

and then run adsf from the root directory

  `adsf -r output -p 3333`
