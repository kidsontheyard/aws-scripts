#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status.
set -e

sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt autoremove -y

# Setup KOTY folders
sudo mkdir -p /opt/koty/scripts/
sudo chown -Rf ubuntu:ubuntu /opt/koty/scripts/

# create EFS direcotry
sudo mkdir -p /efs/setup
sudo mkdir -p /efs/general

# Install the most common packages

sudo apt install memcached -y
sudo apt install locate -y
sudo apt install telnet -y
sudo apt install git -y
sudo apt install rsync -y
sudo apt install mosh -y
sudo apt install build-essential -y
sudo apt install gcc -y
sudo apt install make -y
sudo apt install autoconf -y
sudo apt install libc-dev -y
sudo apt install pkg-config -y
sudo apt install whois -y
sudo apt install lynx -y
sudo apt install zip -y
sudo apt install pwgen -y

# Image procssing uils
sudo apt install libjpeg-progs  jpegoptim gifsicle optipng pngquant webp -y

# Install NFS
sudo apt install nfs-common -y

sudo apt-get update -y && sudo apt-get upgrade -y

# MySQL CLient
sudo apt install mysql-client -y

# redis client
sudo apt install redis-tools -y
