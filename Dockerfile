FROM php:7.3.6-fpm-alpine3.9

WORKDIR /var/www

RUN apk add --no-cache shadow
RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

RUN rm -Rf /var/www/html
RUN chown -R www-data:www-data /var/www

RUN ln -s public html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data
USER www-data

EXPOSE 9000

ENTRYPOINT ["php-fpm"]

