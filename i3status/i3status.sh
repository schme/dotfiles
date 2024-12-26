#!/usr/bin/env bash


i3status --config ~/.config/i3status/conf| while :
do
        read line
        LG=$(setxkbmap -query | awk '/layout/{print $2}')
        dat="[{ \"full_text\": \"KB: $LG\" },"
        echo "${line/[/$dat}" || exit 1
done
