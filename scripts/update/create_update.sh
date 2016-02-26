#!/bin/bash

##############################################################################################
# Pulls the newest versions of hibike and  runtime from github and packages them nicely      #
# in a tarball along with the install_update.sh script. Then proceeds to digitally sign      #
# the file so that the signature can be verified before the robot uses the tarball to update #
##############################################################################################

ROOT_DIR=$(git rev-parse --show-toplevel)
BUILD_DIR=$ROOT_DIR/build
TEMP_DIR=$ROOT_DIR/build/temp

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
mkdir $TEMP_DIR
# currently unused, but may be useful in the case that we have to build packages from source
mkdir $TEMP_DIR/resources

git clone https://github.com/pioneers/daemon $TEMP_DIR/daemon
git clone https://github.com/pioneers/hibike $TEMP_DIR/hibike
cp $ROOT_DIR/scripts/update/install_update.sh $TEMP_DIR

CURRENT_TIME=$(date +%s%N)
UPDATE_FILE_NAME=frankfurter-update-"$CURRENT_TIME".tar.gz

cd $BUILD_DIR
tar -zcf $UPDATE_FILE_NAME --directory=$TEMP_DIR .
gpg --armor --detach-sign $UPDATE_FILE_NAME # create a signature for the tarball.

rm -rf $TEMP_DIR
