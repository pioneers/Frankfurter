#!/bin/bash

####################################################################################
# Instructions to install a specific update. Packaged in the tarballs used to
# distribute updates.
####################################################################################

HOME_DIR=/home/ubuntu
UPDATES_DIR=$HOME_DIR/updates
RUNTIME_DIR=$HOME_DIR/daemon/runtime
TEMP_DIR=$UPDATES_DIR/temp

####################################################################################
# Update hibike:                                                                   #
# I'm pretty sure it's okay to just completely wipe and recopy hibike like this... #
# Will of course fix this if this isn't the case.                                  #
####################################################################################
rm -rf $HOME_DIR/hibike
cp -r $TEMP_DIR/hibike $HOME_DIR/

####################################################################################
# Update runtime:                                                                  #
# This is a bit more involved as we need to avoid deleting student code.           #
# Aside from saving things to the side and copying them back, we're pretty much    #
# doing the same thing as with hibike and wiping and recopying runtime.            #
####################################################################################
cp -r $RUNTIME_DIR/student_code $TEMP_DIR
rm -rf $HOME_DIR/daemon
cp -r $TEMP_DIR/daemon $HOME_DIR/
cp -r $TEMP_DIR/student_code $RUNTIME_DIR


ln -s $HOME_DIR/hibike/hibikeDevices.csv $RUNTIME_DIR/hibikeDevices.csv
####################################################################################
# Cleanup!                                                                         #
####################################################################################
rm -rf $TEMP_DIR $UPDATES_DIR/frankfurter-update*.tar.gz*
