FROM debian:stretch
MAINTAINER Jonathan Grimmtjärn <stamp@stamp.se>

ENV QUEUE_CONNECTION=redis
ENV QUEUE_NAME=default

RUN apt-get update -yqq && apt-get install -yyqq \
git \
openssh-client \
php-imagick \
php7.0-fpm \
php7.0-bcmath \
php7.0-curl \
php7.0-fpm \
php7.0-gd \
php7.0-mbstring \
php7.0-mysql \
php7.0-xml \
php7.0-zip \
php7.0-xdebug

# Download trusted certs 
RUN mkdir -p /etc/ssl/certs && update-ca-certificates

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www
CMD ["php", "artisan", "serve", "--port=80", "--host=0.0.0.0"]
# CMD php ./artisan serve --port=80 --host=0.0.0.0

EXPOSE 80
