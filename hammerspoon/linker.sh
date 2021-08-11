#!/bin/bash

#Creates symbolic Link to workflows in Alfred

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORKFLOW_DIR=~/.hammerspoon

cd "$WORKFLOW_DIR"

IFS=$'\n';for f in $(ls -d $DIR/spoons/*)
do
    rm `basename $f`
    ln -fsv "$f" `basename $f`
done
