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
sudo apt-get install -y make build-essential gcc git htop libzmq3-dev curl memcached

REPO_ROOT_DIR=$(git rev-parse --show-toplevel)
cd ~

# Install nodejs and global npm packages #####################################################
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g gulp coffee-script

# Install python, pip, and pip packages ######################################################
sudo apt-get install -y python python-dev python-pip
sudo pip install --upgrade pyserial pyzmq pyyaml python-memcached
sudo pip install --pre pyusb

# Install pygrizzly ##########################################################################
git clone https://github.com/pioneers/python-grizzly
cd python-grizzly
sudo python setup.py install
cd ..
sudo rm -rf python-grizzly

# download hibike, dawn, and runtime
git clone https://github.com/pioneers/daemon ~/daemon
git clone https://github.com/pioneers/hibike ~/hibike
mkdir -p ~/updates
cd ~/daemon/app
npm install
gulp build

# copy .conf files into /etc/init so that hibike/dawn/runtime start on boot
sudo cp $REPO_ROOT_DIR/resources/*.conf /etc/init
sudo cp $REPO_ROOT_DIR/resources/50-grizzlybear.rules /etc/udev/rules.d/
ln -s ~/hibike/hibikeDevices.csv ~/daemon/runtime/hibikeDevices.csv

echo "export PYTHONPATH=$HOME/hibike:$PYTHONPATH" >> ~/.bashrc

# TODO(vdonato): kill off/disable services that aren't needed
# TODO(vdonato): probably change the password on a team-by-team basis
