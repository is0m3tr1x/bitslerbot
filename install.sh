  GNU nano 2.5.3                                           File: install.sh                                                                                              

#!/bin/bash
# Simple install script

## make some dirs
echo "Making dirs..."
mkdir ./strategies
mkdir ./log
mkdir ./odds
mkdir ./web

## set permissions on scripts
echo "Setting perms..."
chmod a+x ./*.sh

## chmod the scriot dir recursively
chmod -R 775 ../bitslerbot

cat ./README

exit 0
