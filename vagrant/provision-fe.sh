#!/usr/bin/env bash

echo "===================== ADDING FRONTEND TOOLS ====================="

echo "Installing NodeJS..."
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Finished Installing NodeJS..."

echo "Installing Grunt"
sudo npm install -g grunt-cli
echo "Finished Installing Grunt"


echo "===================== FINISHED ADDING FRONTEND TOOLS ====================="

exit 0
