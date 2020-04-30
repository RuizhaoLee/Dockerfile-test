FROM php:7.4.5-zts-alpine3.11

LABEL maintainer="Liruizhao <liruizhaoatphp@outlook.com>" version="1.0"

ENV PHP_DEPS="curl-dev enchant-dev libpng-dev gmp-dev libc-dev gc-dev imap-dev icu-dev icu-libs oniguruma-dev postgresql-dev libpq aspell-dev aspell-libs net-snmp-dev libxml2-dev lzip"

ENV PHP_EXT_OPTS="bcmath imap intl json mbstring mysqli pcntl pdo pdo_mysql pdo_pgsql pgsql phar posix pspell shmop snmp soap sockets sysvmsg sysvsem sysvshm zip"

##
# ---------- building ----------
##
RUN set -ex \
    # change apk source repo
    && apk add --no-cache ${PHP_DEPS} \
#    && wget https://libzip.org/download/libzip-1.5.2.tar.gz -O libzip.tar.gz \
#    && tar -zxvf libzip.tar.gz \ cmake .. \
#    && make && make install \
#    && cd libzip && mkdir build && cd build &&
    && docker-php-source extract \
    && docker-php-ext-install -j$(nproc) ${PHP_EXT_OPTS} \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
