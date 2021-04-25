FROM php:7.3.6-fpm-alpine3.9

WORKDIR /var/www

RUN apk add --no-cache openssl shadow
RUN apk add bash mysql-client
RUN docker-php-ext-install pdo pdo_mysql

RUN rm -Rf /var/www/html
RUN chown -R www-data:www-data /var/www

RUN ln -s public html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN usermod -u 1000 www-data
USER www-data

RUN chmod 755 /var/www/
RUN chown -R www-data:www-data /var/www

EXPOSE 9000

ENTRYPOINT ["php-fpm"]

