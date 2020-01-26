FROM centos:centos7.7.1908

COPY ./source/nginx.repo /etc/yum.repos.d/nginx.repo

ARG TZ
ARG servicePath=/etc/systemd/system/multi-user.target.wants

RUN rpm -Uvh https://mirrors.ustc.edu.cn/epel/7/x86_64/Packages/e/epel-release-7-12.noarch.rpm \
&& rpm -Uvh https://mirrors.ustc.edu.cn/remi/enterprise/remi-release-7.rpm \
&& yum install -y nginx \
&& if [[ ! -d "${servicePath}" ]]; then \
     echo "mkdir -p ${servicePath}..."; \
     mkdir -p "${servicePath}"; \
   fi \
&& if [[ -e "/usr/lib/systemd/system/nginx.service" ]]; then \
     echo "ln -sf /usr/lib/systemd/system/nginx.service ${servicePath}/nginx.service..."; \
     ln -sf /usr/lib/systemd/system/nginx.service ${servicePath}/nginx.service; \
   fi \
&& export TZ="${TZ}"

EXPOSE 80 443

CMD ["/usr/sbin/init"]