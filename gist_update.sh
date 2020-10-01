#!/usr/bin/env sh
# -*- coding: UTF8 -*-

# Author: Guillaume Bouvier -- guillaume.bouvier@pasteur.fr
# https://research.pasteur.fr/en/member/guillaume-bouvier/
# 2020-10-01 13:16:48 (UTC+0200)

GISTURL=$(gist-paste -l | fzf)
GISTID=$(echo "$GISTURL" | awk '{print $1}' | awk -F"/" '{print $4}')
if [ -z "$GISTID" ]; then
    exit
else
    echo "Editing gist $GISTID"
    if [ -d "$GISTID" ]; then
        cd "$GISTID" || exit;
        git pull
    else
        git clone "git@gist.github.com:$GISTID.git"
        cd "$GISTID" || exit;
    fi
    vim ./*
    git commit -a -m "Gist updated"
    git push
fi
