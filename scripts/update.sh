#!/bin/bash

####################################################################################
# Robot-side script for installing an update. Takes the tarball given in an
# individual update, verifies that it is from us, then proceeds to defer to
# the individual update script to complete the process.
####################################################################################

UPDATES_DIR=/home/ubuntu/updates
TEMP_DIR=$UPDATES_DIR/temp

if ! ls $UPDATES_DIR/frankfurter-update-*.tar.gz 1> /dev/null 2>&1; then
  exit
fi
mkdir -p $TEMP_DIR

sudo stop runtime
cd $UPDATES_DIR

# fail fast. In particular, stop execution if the key cannot be verified.
set -e

# TODO(vdonato): for now we're assuming there's only one update file, and this should be the case
#                if nothing ever crashes, but this should be more robust and pick the newest
#                update tarball in the case that there are multiple.

# verify that the tarball came from us and not some random kid
gpg --verify frankfurter-update-*.tar.gz.asc frankfurter-update-*.tar.gz
tar -xf $UPDATES_DIR/frankfurter-update-*.tar.gz -C $TEMP_DIR

# an update tarball should have all of the instructions on how to install itself in its
# install_update.sh script, so we simply defer to it here.
./$TEMP_DIR/install_update.sh
sudo start runtime
