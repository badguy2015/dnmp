FROM centos:centos7.7.1908

COPY ./source/mariadb.repo /etc/yum.repos.d/mariadb.repo

ARG TZ
ARG servicePath1=/etc/systemd/system/multi-user.target.wants
ARG servicePath2=/etc/systemd/system
ARG serviceFile=/usr/lib/systemd/system/mariadb.service

RUN yum install -y MariaDB-server MariaDB-client \
#ln -s /usr/lib/systemd/system/mariadb.service /etc/systemd/system/mysql.service
#ln -s /usr/lib/systemd/system/mariadb.service /etc/systemd/system/mysqld.service
#ln -s /usr/lib/systemd/system/mariadb.service /etc/systemd/system/multi-user.target.wants/mariadb.service
&& if [[ ! -d "${servicePath1}" ]]; then \
     echo "mkdir -p ${servicePath1}..."; \
     mkdir -p "${servicePath1}"; \
   fi \
&& if [[ -e "${serviceFile}" ]]; then \
     echo "ln -s ${serviceFile} ${servicePath1}/mariadb.service..."; \
     ln -s ${serviceFile} ${servicePath1}/mariadb.service; \
     echo "ln -s ${serviceFile} ${servicePath2}/mysql.service..."; \
     ln -s ${serviceFile} ${servicePath2}/mysql.service; \
     echo "ln -s ${serviceFile} ${servicePath2}/mysqld.service..."; \
     ln -s ${serviceFile} ${servicePath2}/mysqld.service; \
   fi \
&& export TZ="${TZ}"

EXPOSE 3306

CMD ["/usr/sbin/init"]
