#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Autoclick
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

terminal-notifier -group "Autoclicking" -message "Autoclicking!"

for i in {1..100}
do
    cliclick c:.
    sleep 0.001
done

terminal-notifier -group "Autoclicking" -message "Done Autoclicking"