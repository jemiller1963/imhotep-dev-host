#!/bin/bash

echo "Pass a Vagrant Name:"
read name
echo $name

defaultDir=$(pwd)

export PROJECT_DIR=$defaultDir
export VAGRANT_PROJECT_DIR=/home/vagrant/$name
export HOSTNAME=$name


echo "Exported PROJECT_DIR: $PROJECT_DIR"
echo "Exported VAGRANT_PROJECT_DIR: $VAGRANT_PROJECT_DIR"
echo "Exported HOSTNAME: $HOSTNAME"