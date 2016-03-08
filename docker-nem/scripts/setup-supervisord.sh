#!/bin/bash

home=/root
mkdir $home/nem/nis -p
mkdir $home/nem/ncc -p
curl https://raw.githubusercontent.com/NewEconomyMovement/azure-quickstart-templates/nem-baas-template/docker-nem/files/supervisord.conf >/root/supervisord.conf

