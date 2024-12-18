#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect Headphones
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🎧

# Documentation:
# @raycast.author jverkamp
# @raycast.authorURL https://raycast.com/jverkamp

blueutil --disconnect '95-05-bb-2b-81-54' --wait-disconnect '95-05-bb-2b-81-54'
