#!/bin/bash

#Creates symbolic Link to workflows in Alfred

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
WORKFLOW_DIR=~/Library/Application\ Support/Alfred/Alfred.alfredpreferences/workflows
DOMAIN=com.ju

cd "$WORKFLOW_DIR"

IFS=$'\n';for f in $(ls -d $DIR/workflows/*)
do
    rm $DOMAIN.`basename $f`
    ln -fsv "$f" $DOMAIN.`basename $f`
done
