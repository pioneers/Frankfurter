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

# Install python, pip, and pip packages ######################################################
sudo apt-get install -y python python-dev python-pip
sudo pip install --upgrade pyserial pyzmq pyyaml python-memcached
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

# TODO(vdonato): we should really distribute a private key to everyone instead of using my key
#                to sign things, but this should work for now...
#                another option would be to sign the key of any person working on deployment, but
#                that sounds like a bit of a pain to maintain.
gpg --import $REPO_ROOT_DIR/resources/frankfurter_vincent.gpg
gpg --sign-key vincentdonato@pioneers.berkeley.edu

# copy .conf files into /etc/init so that hibike/dawn/runtime start on boot ##################
sudo cp $REPO_ROOT_DIR/resources/*.conf /etc/init

sudo cp $REPO_ROOT_DIR/resources/50-grizzlybear.rules /etc/udev/rules.d/

echo "export PYTHONPATH=$HOME/hibike:$PYTHONPATH" >> ~/.bashrc

# NOTE: for testing purposes while developing on the VM
echo "export HIBIKE_SIMULATOR=1" >> ~/.bashrc # TODO(vdonato): remove me before production

# TODO(vdonato): kill off/disable services that aren't needed. I'm fairly certain that the only
#                non-essential service that the image that we're currently flashing to the beaglebone
#                starts up on boot is an apache server, but be sure to check to see if there are
#                any others.

# TODO(vdonato): change the password on a team-by-team basis. This should be done in the script that
#                we run on each beaglebone after flashing it.
