FROM centos:centos7.7.1908

ARG servicePath=/etc/systemd/system/multi-user.target.wants
RUN rpm -Uvh https://mirrors.ustc.edu.cn/epel/7/x86_64/Packages/e/epel-release-7-12.noarch.rpm \
&& rpm -Uvh https://mirrors.ustc.edu.cn/remi/enterprise/remi-release-7.rpm \
&& if [[ ! -d "${servicePath}" ]]; then \
     echo "mkdir -p ${servicePath}..."; \
     mkdir -p "${servicePath}"; \
   fi

CMD ["/usr/sbin/init"]