#!/bin/bash

nemnet=$1

# setup data disk.
# from docker-neo4j template

# create a partition table for the disk
parted -s /dev/sdc mklabel msdos

# create a single large partition
parted -s /dev/sdc mkpart primary ext4 0\% 100\%

# install the file system
mkfs.ext4 /dev/sdc1

# create the mount point
mkdir /datadisk

# mount the disk
mount /dev/sdc1 /datadisk/

# add mount to /etc/fstab to persist across reboots
echo "/dev/sdc1    /datadisk/    ext4    defaults 0 0" >> /etc/fstab



# save stuff in /datadisk
home=/datadisk


# create directories needed by nem container
mkdir $home/nem/nis -p
mkdir $home/nem/ncc -p

# get supervisord config
curl https://raw.githubusercontent.com/NewEconomyMovement/azure-quickstart-templates/nem-baas-template/docker-nem/files/supervisord.conf >$home/supervisord.conf

key=$(< /dev/urandom tr -dc a-f0-9 | head -c64)
name=nemonazure_$(< /dev/urandom tr -dc a-z | head -c 20)

# generate random name and bootkey
cat > $home/nis.config-user.properties <<EOF
nis.bootName = $name
nis.bootKey = $key
nem.network = $nemnet
EOF

chown 1000 /datadisk/nem -R
