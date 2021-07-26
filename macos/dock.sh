#!/bin/sh

#dockutil --no-restart --remove all

dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/Obsidian.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
#dockutil --no-restart --add "/System/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/System/Applications/System Preferences.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/KeePassXC.app"

killall Dock
