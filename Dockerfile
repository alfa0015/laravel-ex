FROM php:7
RUN docker-php-ext-install pdo mbstring
RUN php -r "copy('http://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
WORKDIR /opt/app-root/src
COPY . /opt/app-root/src
RUN composer install --no-plugins --no-scripts
RUN chmod 777 storage
CMD ["php","artisan","serve", "--host=0.0.0.0", "--port=8080"]
EXPOSE 8080
