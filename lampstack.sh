#!/bin/bash

# Update package
sudo apt-get update -y

# Install Apache
sudo apt-get install apache2 -y

# Install PHP and required modules
sudo apt-get install php -y
# Enable phpinfo page
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/test.php

# Install MySQL 
sudo apt-get install mysql-server -y

# Create a file for MySQL commands
echo "CREATE USER 'roseline'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'roseline'@'localhost' WITH GRANT OPTION;" > mysql_commands.sql

# Execute MySQL commands from the file
sudo mysql < mysql_commands.sql

# Cleanup
rm mysql_commands.sql

# Install Composer
mkdir Downloads
cd Downloads/
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php 
sudo mv composer.phar /usr/local/bin/composer

# Install Git and PHP modules
sudo apt-get install git -y
sudo apt-get install php-cli php-json php-common curl php-mbstring php-zip unzip php-curl php-xml -y

cd /var/www/html
sudo rm index.html
sudo chown -R vagrant:vagrant .

# Clone the repository
git clone https://github.com/laravel/laravel.git
cd laravel
composer install
cp .env.example .env
sudo php artisan key:generate

# Change the owner of the storage and logs file to www-data
sudo chown -R www-data:www-data storage/

# Restart Apache
sudo systemctl reload apache2

# Create a virtual host configuration
echo '<VirtualHost *:80>
    DocumentRoot /var/www/html/laravel/public

    <Directory /var/www/html/laravel/public>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/laravel-error.log
    CustomLog ${APACHE_LOG_DIR}/laravel-access.log combined
</VirtualHost>' | sudo tee /etc/apache2/sites-available/test.conf

# Enable the virtual host and disable the default site
sudo a2ensite test.conf
sudo a2dissite 000-default.conf

# Restart Apache
sudo systemctl reload apache2
sudo systemctl restart apache2

# Done
echo 'Webserver is up, visit http://192.168.56.22 to view the website'