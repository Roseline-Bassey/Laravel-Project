#!/bin/bash

# Update package
sudo apt-get update -y

# Install Apache
sudo apt-get install apache2 apache2-utils -y
sudo ufw allow http

# Install MySQL 
sudo apt-get install mysql-server -y

# Install PHP and required modules
sudo apt-get install php -y

# Enable Apache extensions for php
sudo apt-get install php libapache2-mod-php php-mysql -y

# enable phpinfo page
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/test.php

# Restart Apache
sudo systemctl reload apache2

# Enable Apache to start on boot
sudo systemctl enable apache2