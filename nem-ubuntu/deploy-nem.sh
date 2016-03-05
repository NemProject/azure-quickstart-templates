#!/bin/bash

# print commands and arguments as they are executed
set -x

echo "initializing NEM installation"
date
ps axjf

#############
# Parameters
#############

AZUREUSER=$1
HOMEDIR="/home/$AZUREUSER"
VMNAME=`hostname`
echo "User: $AZUREUSER"
echo "User home dir: $HOMEDIR"
echo "vmname: $VMNAME"

#####################
# setup the Azure CLI
#####################
time sudo npm install azure-cli -g

####################
# Setup NEM
####################

# Generate needed config
generatedbootkey=$(< /dev/urandom tr -dc a-f0-9 | head -c64)
nodename=NIS_ON_AZURE_$(< /dev/urandom tr -dc 0-9 | head -c6)
cat >$HOME/nis.config-user.properties <<EOF
nis.bootKey = $generatedbootkey
nis.bootName = $nodename
nem.network = testnet
EOF

# start container
docker run --rm -p 7890:7890 -v $HOME/nis.config-user.properties:/package/nis/config-user.properties  rb2nem/nis