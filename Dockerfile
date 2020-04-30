FROM php:7.4.5-zts-alpine3.11

LABEL maintainer="Liruizhao <liruizhaoatphp@outlook.com>" version="1.0"

ENV PHP_DEPS="bzip2-dev curl-dev libxml2-dev enchant-dev libpng-dev gmp-dev"
ENV PHP_EXT_OPTS="bcmath bz2 calendar ctype curl dom fileinfo hash iconv imap intl json ldap mbstring mysqli oci8 odbc pcntl pdo pdo_mysql pdo_pgsql pgsql phar posix pspell readline reflection session shmop simplexml snmp soap sockets sodium spl standard sysvmsg sysvsem sysvshm tidy xmlreader xmlrpc xmlwriter xsl zip"

##
# ---------- building ----------
##
RUN set -ex \
    # change apk source repo
    && apk add --no-cache ${PHP_DEPS} \
    && docker-php-source extract \
    && docker-php-ext-install -j$(nproc) ${PHP_EXT_OPTS} \
    && php -m \
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"
