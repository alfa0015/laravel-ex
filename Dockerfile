FROM php:7
RUN docker-php-ext-install pdo mbstring
RUN php -r "copy('http://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
WORKDIR /opt/app-root/src
COPY . /opt/app-root/src
RUN composer install --no-plugins --no-scripts
RUN yes | pecl install xdebug-2.7.0RC1 \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.max_nesting_level=700" >> /usr/local/etc/php/conf.d/xdebug.ini
CMD ["php","artisan","serve", "--host=0.0.0.0", "--port=8080"]
EXPOSE 8080
EXPOSE 9000
