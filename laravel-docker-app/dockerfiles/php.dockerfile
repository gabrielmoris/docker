FROM php:8.1-fpm-alpine

USER root

RUN apk update && \
    apk add --no-cache \
        $PHPIZE_DEPS \
        && docker-php-ext-install pdo pdo_mysql \
        && apk del --no-cache $PHPIZE_DEPS

RUN addgroup -g 1000 moris && adduser -G moris -g moris -s /bin/sh -D moris

USER moris

WORKDIR /var/www/html