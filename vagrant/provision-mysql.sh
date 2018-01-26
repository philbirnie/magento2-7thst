#!/usr/bin/env bash

echo "===================== MYSQL SETUP ====================="

DB="magento2" && export DB

# Drop and Create DB
echo "DROP DATABASE IF EXISTS ${DB}" | mysql -v
echo "CREATE DATABASE ${DB}" | mysql -v

# Drop and Create User
echo "DROP USER IF EXISTS ${DB}" | mysql -v
echo "CREATE USER ${DB} IDENTIFIED BY '${DB}'" | mysql -v
echo "GRANT ALL PRIVILEGES ON *.* TO ${DB}@'%'" | mysql -v
echo "FLUSH PRIVILEGES"

echo "===================== MYSQL SETUP COMPLETE  CREDENTIALS BELOW ====================="

echo "ROOT PASSWORD: root"
echo "DB USER: ${DB}"
echo "DB PASSWORD: ${DB}"
echo "DB: ${DB}"

exit 0
