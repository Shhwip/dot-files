#!/bin/bash
# This script will update discord

rm /tmp/discord*
rm ~/Downloads/discord*
wget -O /tmp/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo dpkg -i /tmp/discord.deb
sudo apt-get install -f -y