#!/usr/bin/env bash

echo "===================== MYSQL SETUP ====================="

DB="magento2" && export DB
DB_TEST="${DB}_test" && export DB_TEST

# Drop and Create DB
echo "DROP DATABASE IF EXISTS ${DB}" | mysql -v
echo "CREATE DATABASE ${DB}" | mysql -v

# Drop and Create User
echo "DROP USER IF EXISTS ${DB}" | mysql -v
echo "CREATE USER ${DB} IDENTIFIED BY '${DB}'" | mysql -v
echo "GRANT ALL PRIVILEGES ON *.* TO ${DB}@'%'" | mysql -v
echo "FLUSH PRIVILEGES"

# Create Test User
echo "Creating User for Integration Tests"
# Drop and Create DB
echo "DROP DATABASE IF EXISTS ${DB_TEST}" | mysql -v
echo "CREATE DATABASE ${DB_TEST}" | mysql -v

# Drop and Create User
echo "DROP USER IF EXISTS ${DB_TEST}" | mysql -v
echo "CREATE USER ${DB_TEST} IDENTIFIED BY '${DB_TEST}'" | mysql -v
echo "GRANT ALL PRIVILEGES ON *.* TO ${DB_TEST}@'%'" | mysql -v
echo "FLUSH PRIVILEGES"

echo "====================== MYSQL IMPORT (if mysql/mysql.sql.gz exists) ====================="


if [ -f /var/www/mysql/mysql.sql.gz ]; then
    gzip -d /var/www/mysql/mysql.sql.gz
    mysql -u ${DB} -p${DB} ${DB}  < /var/www/mysql/mysql.sql
    gzip /var/www/mysql/mysql.sql
fi

echo "===================== MYSQL SETUP COMPLETE  CREDENTIALS BELOW ====================="

echo "ROOT PASSWORD: root"
echo "DB USER: ${DB}"
echo "DB PASSWORD: ${DB}"
echo "DB: ${DB}"

echo "INTEGRATION TEST DATABASE USER: ${DB_TEST}"
echo "INTEGRATION TEST DATABASE PASSWORD: ${DB_TEST}"
echo "INTEGRATION TEST DATABASE DB: ${DB_TEST}"

exit 0

