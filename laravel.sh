#!/bin/bash

# install git
sudo apt-get update -y
sudo apt-get install git composer -y

# Clone the repository
cd /var/www/html
sudo git clone https://github.com/laravel/laravel.git
sudo composer install -y
cd laravel
sudo mv .env.example .env
sudo php artisan key:generate


# # move into the app root directory
# echo 
# cd laravel

# # rename .env
# sudo mv .env.example .env

#Install composer dependencies and composer
sudo apt-get install php-xml php-curl -y
sudo apt-get install php-cli php-json php-common curl php-mbstring php-zip unzip zip unzip php-curl php-xml -y
sleep 5

sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

#Update repo
sudo composer install -yes

# update the repo
sudo composer update -yes

sudo a2dissite 000-default.conf

# navigate to sites-availble
cd /etc/apache2/sites-available/000-default.conf

# # create your config file
# sudo touch laravel.conf

# update the content
sudo sed -n 'w 000-default.conf' <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/public

    <Directory /var/www/html/public>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/laravel-error.log
    CustomLog \${APACHE_LOG_DIR}/laravel-access.log combined

    <IfModule mod_dir.c>
        DirectoryIndex index.php
    </IfModule>
</VirtualHost>
EOF


# enable the site
sudo a2ensite laravel

# # create the site directory
# sudo mkdir -p /var/www/laravel

# # copy the content to site directory
# cd /home/vagrant
# echo $(pwd)
# sudo cp -r laravel/. /var/www/laravel/

# go back to the directory
cd /var/www/html/laravel
echo $(pwd)

# set permission for the files
sudo chown -R vagrant:www-data /var/www/html/laravel/
sudo find /var/www/html/laravel/ -type f -exec chmod 664 {} \;
sudo find /var/www/html/laravel/ -type d -exec chmod 775 {} \;
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache

# reload apache
sudo systemctl reload apache2

# done
echo 'webserver is up vist http://127.0.0.1 to view website'