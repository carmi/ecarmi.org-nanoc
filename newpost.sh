#!/bin/sh

# A bash script to create a new nanoc post.

## SETTINGS

# Author
AUTHOR="Evan H. Carmi"

# Directory structure
DIR_BASE="content/writing/"
FILE_ENDING=".md"

# Date and title
YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
/bin/echo -n "Enter title: "
read RAW_TITLE
TITLE=$(echo "$RAW_TITLE" | sed -e 's/[ _]/-/g' -e 's/[^a-zA-Z0-9-]//g' -e 's/-$//g')

FILE_PATH=$DIR_BASE$TITLE$FILE_ENDING


# Create new file if it doesn't exist

if [ ! -f $FILE_PATH ];
then
  echo "---
  title: $RAW_TITLE
  slug: $TITLE
  kind: article
  author: $AUTHOR
  created_at: $YEAR-$MONTH-$DAY
  updated_at: $YEAR-$MONTH-$DAY
  published: false
  ---
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam lacus ligula,
  accumsan id imperdiet rhoncus, dapibus vitae arcu. Nulla non quam erat, luctus
  consequat nisi. Integer hendrerit lacus sagittis erat fermentum tincidunt. Cras
  vel dui neque. In sagittis commodo luctus. Mauris non metus dolor, ut suscipit
  dui. Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum. Donec
  gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque
  elit in tortor. Mauris gravida, purus at ultrices sollicitudin, purus diam
  dapibus leo, ut eleifend dolor tellus feugiat lacus. Class aptent taciti
  sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam ut
  fringilla dolor. Cras elit tellus, egestas eget congue sit amet, consequat in
  orci." > $FILE_PATH
  echo "Created $FILE_PATH"
else
  echo "ERROR: $FILE_PATH already exists. Please delete it before continuing."
fi
