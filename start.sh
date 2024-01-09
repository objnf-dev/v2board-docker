#!/bin/sh
cd /var/www/html
php artisan horizon &
apache2-foreground