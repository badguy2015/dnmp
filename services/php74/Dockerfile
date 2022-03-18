FROM centos:centos7.7.1908

ARG TZ
ARG servicePath=/etc/systemd/system/multi-user.target.wants
ARG serviceFile=/usr/lib/systemd/system/php74-php-fpm.service
ARG xdebugFile=/etc/opt/remi/php74/php.d/15-xdebug.ini

ARG PHP74_XDEBUG_REMOTE_ENABLE
ARG PHP74_XDEBUG_REMOTE_HOST
ARG PHP74_XDEBUG_REMOTE_PORT

RUN rpm -Uvh https://mirrors.ustc.edu.cn/epel/7/x86_64/Packages/e/epel-release-7-14.noarch.rpm \
&& rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum --enablerepo=remi install -y php74-php-fpm
RUN yum --enablerepo=remi install -y php74-php-common

RUN yum --enablerepo=remi install -y php74-php-mysql php74-php-pear php74-php-gd php74-php-devel php74-php-mbstring php74-php-mcrypt php74-php-cli php74-php-pdo php74-php-redis php74-php-pecl-memcache php74-php-bcmath php74-php-xml php74-php-intl php74-php-imagick php74-php-xdebug php74-php-xhprof \
&& if [[ ! -d "${servicePath}" ]]; then \
     echo "mkdir -p ${servicePath}..."; \
     mkdir -p "${servicePath}"; \
   fi \
&& if [[ -e "${serviceFile}" ]]; then \
     echo "ln -sf ${serviceFile} ${servicePath}/nginx.service..."; \
     ln -sf ${serviceFile} ${servicePath}/php74-php-fpm.service; \
   fi \
&& if [[ -e "${xdebugFile}" ]]; then \
     echo -e " \n   xdebug.mode=\"debug\"\n xdebug.client_host=${PHP74_XDEBUG_REMOTE_HOST}\n   xdebug.client_port=${PHP74_XDEBUG_REMOTE_PORT}" >> ${xdebugFile}; \
     ln -sf ${serviceFile} ${servicePath}/php74-php-fpm.service; \
   fi \
&& ln -sf /opt/remi/php74/root/usr/bin/php /usr/bin/php \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& ln -sf /usr/lib/systemd/system/php74-php-fpm.service /usr/lib/systemd/system/php-fpm.service \
&& export TZ="${TZ}"

RUN curl -sS https://getcomposer.org/installer | php \
&& mv composer.phar /usr/local/bin/composer \
&& composer -V \
&& yum install -y unzip \
&& composer config -g repo.packagist composer https://mirrors.cloud.tencent.com/composer \
&& composer global require slince/composer-registry-manager

EXPOSE 9000

CMD ["/usr/sbin/init"]