FROM php:7.4.5-zts-alpine3.11

LABEL maintainer="Liruizhao <liruizhaoatphp@outlook.com>" version="1.0"

ENV PHP_DEPS="ca-certificates curl wget tar xz libzip libressl tzdata pcre autoconf"
ENV PHP_EXT_OPTS="pcntl bcmath redis exif sockets pdo_mysql shmop sysvmsg sysvem sysvshm gd"

##
# ---------- building ----------
##
RUN set -ex \
    # change apk source repo
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories \
    && docker-php-source extract \
    && apk update && apk add --no-cache ${PHP_DEPS} \
    && cd /tmp && wget -c https://pecl.php.net/get/redis-5.2.1.tgz && tar -zxvf /tmp/redis-5.2.1.tgz && mv /tmp/redis-5.2.1 /usr/src/php/ext/redis \
    && docker-php-ext-install ${PHP_EXT_OPTS} \
    && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php7 \
    && php -v \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
