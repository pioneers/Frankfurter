#!/bin/bash

####################################################################################
# Instructions to install a specific update. Packaged in the tarballs used to
# distribute updates.
####################################################################################

UPDATES_DIR=~/updates
RUNTIME_DIR=~/daemon/runtime
TEMP_DIR=$UPDATES_DIR/temp

####################################################################################
# Update hibike:                                                                   #
####################################################################################
mv $TEMP_DIR/hibike ~/hibike_new
rm -rf ~/hibike_old
mv ~/hibike ~/hibike_old
mv ~/hibike_new ~/hibike

####################################################################################
# Update runtime:                                                                  #
# This is a bit more involved as we need to avoid deleting student code.           #
####################################################################################
cp -r $RUNTIME_DIR/student_code $TEMP_DIR
mv $TEMP_DIR/daemon ~/daemon_new
rm -rf ~/daemon_old
mv ~/daemon ~/daemon_old
mv ~/daemon_new ~/daemon
cp -r $TEMP_DIR/student_code $RUNTIME_DIR

ln -s ~/hibike/hibikeDevices.csv $RUNTIME_DIR/hibikeDevices.csv
####################################################################################
# Cleanup!                                                                         #
####################################################################################
rm -rf $TEMP_DIR
