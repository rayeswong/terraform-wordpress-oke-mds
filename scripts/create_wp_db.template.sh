#!/bin/bash

mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "CREATE DATABASE ${wp_schema};"
mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "CREATE USER ${wp_db_username} identified by '${wp_db_password}';"
mysqlsh --user ${admin_username} --password=${admin_password} --host ${mds_ip} --sql -e "GRANT ALL PRIVILEGES ON ${wp_schema}.* TO ${wp_db_username};"

echo "WordPress Database and User created !"
echo "WP USER = ${wp_db_username}"
echo "WP SCHEMA = ${wp_schema}"
