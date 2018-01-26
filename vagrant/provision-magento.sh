#!/usr/bin/env bash

echo "===================== STARTING MAGENTO PROVISION ====================="


echo "Installing Composer Packages (or updating existing packages) and dumping autoloaders"
cd /var/www/magento
composer install

echo "===================== ENDING MAGENTO PROVISION ====================="

exit 0
