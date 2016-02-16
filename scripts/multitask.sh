#!/bin/bash

##############################################################################################
# Appends appropriate DNS to resolv.conf for internet access                                 #
# Installs tmux onto ubuntu                                                                  #
# Clones the frankfurter repo and started the script in a new detached tmux session allowing #
# the user to disconnect from the ssh session and proceed to start the script on other BBB's #
#                                                                                            #
# It might be the case that tmux might have to be started as root, and to manually start the #
# script as root, THEN detach the tmux session manually                                      #
##############################################################################################

# enable passwordless sudo
echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' | sudo tee --append /etc/sudoers

# Append DNS to /etc/resolv.conf #############################################################
echo 'nameserver 8.8.8.8' | sudo tee --append /etc/resolv.conf

# Install tmux ###############################################################################
sudo apt-get update -y
sudo apt-get install tmux -y

cd $HOME_DIR

# Clone frankfurter script files #############################################################
git clone https://github.com/pioneers/frankfurter

cd ~/frankfurter

# Run .master_frank_setup.sh inside tmux #####################################################
tmux new-session -d './scripts/master_frank_setup.sh'

# Feel free to disconnect and run another script #############################################
echo 'Disconnect OK'
