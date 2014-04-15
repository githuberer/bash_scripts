#!/usr/bin/env bash
gitdir=(
    "/home/wyy/bash_scripts"
    "/home/wyy/ruby_scripts"
    "/home/wyy/wyying.github.io"
    "/home/wyy/rising_tide"
    "/home/wyy/Dropbox"
)

for d in "${gitdir[@]}"
do
    chown -R wyy.wyy $d
done


