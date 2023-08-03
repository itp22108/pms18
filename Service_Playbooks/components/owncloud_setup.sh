#!/bin/bash

### COMPATIBLE WITH PHP 7.4 ONLY ###

#1) LAMP SERVER INSTALLATION (maybe not needed)
    apt update
    apt install lamp-server^ -y
    systemctl start apache2 && systemctl enable apache2
    
    #*The above installs PHP 8.1, which is incompatible with Owncloud. Purge PHP and install version 7.4 from bellow*
    
    apt-get purge 'php*' 

#2) PHP INSTALL
    sudo apt -y install software-properties-common
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt-get update
    sudo apt -y install php7.4 php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath php7.4-intl
   

#3) MYSQL SETUP

    ### IMPORTANT ! -> https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04 ###
    
    sudo mysql --user=root -p

    CREATE DATABASE ownclouddb;
    
    CREATE USER 'ownclouduser'@'localhost' IDENTIFIED BY 'pms18project';
    
    #Grant the new user with the necessary privileges:
    GRANT ALL ON ownclouddb.* TO 'ownclouduser'@'localhost' WITH GRANT OPTION;
    
    #Enable changes by flushing the privileges:
    FLUSH PRIVILEGES;
    
    exit

#4) OWNCLOUD PACKAGE DOWNLOAD 
    wget https://download.owncloud.com/server/stable/owncloud-complete-latest.tar.bz2
    tar -xjvf owncloud-complete-latest.tar.bz2
    mv owncloud /var/www/
    rm owncloud-complete-latest.tar.bz2
    chown -R www-data: /var/www/owncloud
    
    
    nano /etc/apache2/sites-available/owncloud.conf
    
    #Paste bellow text into new file:
    #    <VirtualHost *:80>
    #        ServerName [your_VM_IP]
    #        DocumentRoot /var/www/owncloud
    #    </VirtualHost>
    
    #Enable configuration file:
        a2ensite owncloud.conf
    
    systemctl restart apache2
