#!/bin/zsh
sudo dpkg-reconfigure virtualbox-dkms
sudo modprobe vboxdrv
sudo /sbin/vboxconfig