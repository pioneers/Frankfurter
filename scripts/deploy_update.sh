#!/bin/bash

##############################################################################################
# Pulls the newest versions of hibike, runtime, and dawn from github and packages them       #
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
cp $ROOT_DIR/scripts/install_update.sh $TEMP_DIR

CURRENT_TIME=$(date +%s%N)
UPDATE_FILE_NAME=frankfurter-update-$CURRENT_TIME
tar -zcf $BUILD_DIR/$UPDATE_FILE_NAME".tar.gz" --directory=$TEMP_DIR .

rm -rf $TEMP_DIR

#TODO(vdonato): sign the tarball somehow
