#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Markdownify On-Call
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

pbpaste | grep '•' | perl -pe 's|^\s+•\s+(.*?) \((.*)#(.*)\)$|* [] [$1](https://github.com/$2/pull/$3)|g' | sort | uniq | pbcopy
