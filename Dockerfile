FROM php:7.4-apache
# Install Packages
RUN apt-get update && \
    apt-get install -y git wget && \
    apt-get clean
# Clone Repo
RUN git clone --depth=1 -b dev https://github.com/v2board/v2board.git . && \
    wget https://github.com/composer/composer/releases/latest/download/composer.phar -O composer.phar && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install pdo_mysql && \
    php composer.phar install -vvv && \
    php artisan v2board:install && \
    php composer.phar require predis/predis && \
    rm -rf /root/.composer/cache && \
    chmod -R 755 /var/www && \
    chown -R www-data /var/www && \
    a2enmod rewrite
ADD start.sh /var/www/html/start.sh
ADD apache/.htaccess /var/www/html/public/.htaccess
ADD apache/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN chmod +x /var/www/html/start.sh
EXPOSE 80
VOLUME ["/etc/apache2", "/var/www/html/config/theme"]
CMD bash /var/www/html/start.sh