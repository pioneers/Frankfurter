#!/bin/bash

##############################################################################################
# Initially configures a frank robot, assuming the robot has been freshly flashed with       #
# Ubuntu. Note that this script will not be used in production as it is far too slow, and we #
# will instead be flashing the eMMC of a single "master" frank onto each robot for the sake  #
# of speed. This script exists for the purpose of having an easily maintainable way to bring #
# up a master frank. We assume this master frank is set up while tethered to a computer with #
# internet sharing.                                                                          #
#                                                                                            #
# Network config, along with the setup of a few miscellaneous settings (that will need to be #
# changed from robot to robot) will be handled by a separate script run on a robot-by-robot  #
# basis.                                                                                     #
##############################################################################################

# Install (most) apt-get packages ############################################################
sudo apt-get install -y make build-essential gcc git htop curl memcached libevent-dev vim

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)
cd ~

# Install python, pip, and pip packages ######################################################
sudo apt-get -y upgrade
sudo apt-get install -y python python-dev python-pip
sudo pip install --upgrade pyserial pyyaml python-memcached flask flask-socketio eventlet
# there's no stable release version of pyusb in pip right now, so we need the --pre flag
sudo pip install --pre pyusb

# Install pygrizzly ##########################################################################
git clone https://github.com/pioneers/python-grizzly
cd python-grizzly
sudo python setup.py install
cd ..
sudo rm -rf python-grizzly

# download hibike and runtime ################################################################
git clone https://github.com/pioneers/daemon ~/daemon
git clone https://github.com/pioneers/hibike ~/hibike
ln -s ~/hibike/hibikeDevices.csv ~/daemon/runtime/hibikeDevices.csv

# set up things we need to update runtime and hibike #########################################
mkdir -p ~/updates
cp $REPO_ROOT_DIR/scripts/update.sh ~/updates/

# TODO(vdonato): updates, hibike, and daemon folder seem to be owned by root. change the owner
#                to ubuntu

# XXX: not sure if the beaglebone needs to run gpg as root for whatever reason
gpg --ignore-time-conflict --import $REPO_ROOT_DIR/resources/frankfurter_vincent.gpg
gpg --ignore-time-conflict --sign-key vincentdonato@pioneers.berkeley.edu

# copy .conf files into /etc/init so that hibike/dawn/runtime start on boot ##################
sudo cp $REPO_ROOT_DIR/resources/runtime.conf /etc/init
sudo cp $REPO_ROOT_DIR/resources/memcached.conf /etc/init
sudo rm /etc/init.d/memcached

#copy config files for grizzlies, memcached, and network interfaces
sudo cp $REPO_ROOT_DIR/resources/50-grizzlybear.rules /etc/udev/rules.d/
sudo cp $REPO_ROOT_DIR/resources/interfaces /etc/network/interfaces

echo "export PYTHONPATH=$HOME/hibike:$PYTHONPATH" >> ~/.bashrc

# stop the apache server from auto-starting
sudo rm -f /etc/init.d/apache2
# TODO(vdonato): clean out more startup processes)

# Disable password login and add our ssh key to authorized_keys ##############################
sudo cp $REPO_ROOT_DIR/resources/sshd_config /etc/ssh/sshd_config

mkdir -p ~/.ssh
# Ask Vincent for the private key, or just add your own public key here.
cat $REPO_ROOT_DIR/resources/frankfurter_vincent.pub >> ~/.ssh/authorized_keys
