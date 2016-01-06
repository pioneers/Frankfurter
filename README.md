# frankfurter
Various tools and scripts to make the deployment life easier.

## Setting up a "master copy" of frank.
Ideally, only three things need to be done.

1. Flash the Beaglebone's eMMC as outlined in
http://elinux.org/Beagleboard:Ubuntu_On_BeagleBone_Black#Main_Process (Follow Sections 1 and 4).
2. Set up internet sharing from your PC to the Beaglebone Black. Instructions for this can be found
at https://elementztechblog.wordpress.com/2014/12/22/sharing-internet-using-network-over-usb-in-beaglebone-black/
Be sure to change the network devices being used in the examples appropriately.
3. Install git (may require you to update apt-get), clone this repo, and run
scripts/master_frank_setup.sh

That's it! From here we'll be pulling the image from our frank master copy to further flash to the
rest of the Beaglebone Blacks.

## Setting up clones of frank.
Setting up a clone of frank (for a team) involves doing 2 things.

1. Flash the Beaglebone's eMMC with the master frank image (we'll get this on the wiki once it's made)
2. Run the setup script found in scripts/(this is still being written. will update when complete)

## Flashing a SmartDevice
To be added...
