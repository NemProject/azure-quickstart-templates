#!/bin/bash


# save stuff in /root, ok as docker engine runs as root
home=/root


# create directories needed by nem container
mkdir $home/nem/nis -p
mkdir $home/nem/ncc -p

# get supervisord config
curl https://raw.githubusercontent.com/NewEconomyMovement/azure-quickstart-templates/nem-baas-template/docker-nem/files/supervisord.conf >/root/supervisord.conf

key=$(< /dev/urandom tr -dc a-f0-9 | head -c64)
name=nemonazure_$(< /dev/urandom tr -dc a-z | head -c 20)

# generate random name and bootkey
cat >/root/nis.config-user.properties <<EOF
nis.bootName = $name
nis.bootKey = $key
EOF


