#!/bin/bash

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)

cd $REPO_ROOT_DIR
scp build/* ubuntu@192.168.7.2:~/updates/
ssh ubuntu@192.168.7.2 'sudo restart runtime'
