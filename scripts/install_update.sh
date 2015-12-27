#!/bin/bash

# TODO(vdonato): have home directory variable set itself correctly to be either correct for the
#                VM or for production
HOME_DIR=/home/vagrant # FIXME FIXME FIXME
UPDATES_DIR=$HOME_DIR/updates
DAWN_DIR=$HOME_DIR/daemon/app
RUNTIME_DIR=$HOME_DIR/daemon/runtime
TEMP_DIR=$UPDATES/temp

####################################################################################
# Update hibike:                                                                   #
# I'm pretty sure it's okay to just completely wipe and recopy hibike like this... #
# Will of course fix this if this isn't the case.                                  #
####################################################################################
rm -rf $HOME_DIR/hibike
cp -r $TEMP_DIR/hibike $HOME_DIR

####################################################################################
# Update dawn/runtime:                                                             #
# This is a bit more involved as we need to avoid deleting student code as well as #
# the node modules since they take forever and a day to install.                   #
# Aside from saving things to the side and copying them back, we're pretty much    #
# doing the same thing as with hibike and wiping and recopying Dawn and Runtime... #
####################################################################################
cp -r $DAWN_DIR/node_modules $TEMP_DIR
cp -r $RUNTIME_DIR/student_code $TEMP_DIR
rm -rf $HOME_DIR/daemon
cp -r $TEMP_DIR/daemon $HOME_DIR
cp -r $TEMP_DIR/node_modules $DAWN_DIR
cp -r $TEMP_DIR/student_code $RUNTIME_DIR

####################################################################################
# Cleanup!                                                                         #
####################################################################################
rm -rf $TEMP_DIR $UPDATES_DIR/frankfurter-update*.tar.gz
