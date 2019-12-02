FROM php:7.2-fpm
COPY www.conf /etc/php-fpm.d/www.conf
COPY index.php /var/www/
WORKDIR /var/www
CMD [ "php-fpm" ]