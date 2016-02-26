#!/bin/bash

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)
cd $REPO_ROOT_DIR

if ! ls build/frankfurter-update-* 1> /dev/null 2>&1; then
    make create_update
fi

scp build/* ubuntu@192.168.7.2:~/updates/
ssh ubuntu@192.168.7.2 'sudo restart runtime'
