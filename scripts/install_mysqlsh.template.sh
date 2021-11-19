#!/bin/bash

# Install MySQL Community Edition 8.0
sudo rpm -ivh https://dev.mysql.com/get/mysql80-community-release-$(uname -r | sed 's/^.*\(el[0-9]\+\).*$/\1/')-1.noarch.rpm
sudo yum install -y mysql-shell-${mysql_version}
sudo mkdir ~${user}/.mysqlsh
sudo cp /usr/share/mysqlsh/prompt/prompt_256pl+aw.json ~${user}/.mysqlsh/prompt.json
sudo echo '{
    "history.autoSave": "true",
    "history.maxSize": "5000"
}' > ~${user}/.mysqlsh/options.json
sudo chown -R ${user} ~${user}/.mysqlsh

echo "MySQL Shell successfully installed !"
