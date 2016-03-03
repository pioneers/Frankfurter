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
####################################################################################
mv $TEMP_DIR/hibike $HOME_DIR/hibike_new
rm -rf $HOME_DIR/hibike_old
mv $HOME_DIR/hibike $HOME_DIR/hibike_old
mv $HOME_DIR/hibike_new $HOME_DIR/hibike

####################################################################################
# Update runtime:                                                                  #
# This is a bit more involved as we need to avoid deleting student code.           #
####################################################################################
cp -r $RUNTIME_DIR/student_code $TEMP_DIR
mv $TEMP_DIR/daemon $HOME_DIR/daemon_new
rm -rf $HOME_DIR/daemon_old
mv $HOME_DIR/daemon $HOME_DIR/daemon_old
mv $HOME_DIR/daemon_new $HOME_DIR/daemon
cp -r $TEMP_DIR/student_code $RUNTIME_DIR

ln -s $HOME_DIR/hibike/hibikeDevices.csv $RUNTIME_DIR/hibikeDevices.csv
####################################################################################
# Cleanup!                                                                         #
####################################################################################
rm -rf $TEMP_DIR

# Delete Authorized keys & put new public key in authorized keys
cd $HOME_DIR/frankfurter && git pull
sudo rm -rf ~/.ssh/authorized_keys
cp $HOME_DIR/resources/frankfurter_vincent.pub ~/.ssh/authorized_keys
sudo chmod 600 ~/.ssh/authorized_keys
