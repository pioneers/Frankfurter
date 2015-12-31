#!/bin/bash

UPDATES_DIR=~/updates
DAWN_DIR=~/daemon/app
RUNTIME_DIR=~/daemon/runtime
TEMP_DIR=$UPDATES_DIR/temp

####################################################################################
# Update hibike:                                                                   #
# I'm pretty sure it's okay to just completely wipe and recopy hibike like this... #
# Will of course fix this if this isn't the case.                                  #
####################################################################################
rm -rf ~/hibike
cp -r $TEMP_DIR/hibike ~

####################################################################################
# Update dawn/runtime:                                                             #
# This is a bit more involved as we need to avoid deleting student code as well as #
# the node modules since they take forever and a day to install.                   #
# Aside from saving things to the side and copying them back, we're pretty much    #
# doing the same thing as with hibike and wiping and recopying Dawn and Runtime... #
####################################################################################
cp -r $DAWN_DIR/node_modules $TEMP_DIR
cp -r $RUNTIME_DIR/student_code $TEMP_DIR
rm -rf ~/daemon
cp -r $TEMP_DIR/daemon ~
cp -r $TEMP_DIR/node_modules $DAWN_DIR
cp -r $TEMP_DIR/student_code $RUNTIME_DIR


ln -s ~/hibike/hibikeDevices.csv $RUNTIME_DIR/hibikeDevices.csv

cd $DAWN_DIR
gulp build

####################################################################################
# Cleanup!                                                                         #
####################################################################################
rm -rf $TEMP_DIR $UPDATES_DIR/frankfurter-update*.tar.gz
