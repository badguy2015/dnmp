#!/bin/bash

# install docker if not exist
function installDocker() {
	if [ "$(docker --version 2>/dev/null)" ]; then
        echo 'docker exist'
        return
    else
      installCurl
      cd ${config['installDir']}
      curl -fsSL get.docker.com -o get-docker.sh
      sudo sh get-docker.sh --mirror Aliyun
      systemctl start docker
      systemctl enable docker
      rm -rf ${config['installDir']}/get-docker.sh
    fi
}

# add registry-mirrors
function addRegistryMirrors() {
	if [ ! -d "/etc/docker" ];then
		mkdir -p /etc/docker
	fi

	{
 "registry-mirrors" : [
   "https://mirror.ccs.tencentyun.com",
   "http://registry.docker-cn.com",
   "http://docker.mirrors.ustc.edu.cn",
   "http://hub-mirror.c.163.com",
 ]
}
	# 配置源、dns
	echo -e "{\n  \"registry-mirrors\": [\n   \"https://mirror.ccs.tencentyun.com\",\n   \"http://registry.docker-cn.com\",\n   \"http://docker.mirrors.ustc.edu.cn\",\n   \"https://hub-mirror.163.com\",\n   \"https://dockerhub.azk8s.cn\"\n ],\n \"dns\": [\n    \"8.8.8.8\",\n    \"114.114.114.114\" \n ]\n}">/etc/docker/daemn.json
}

# install curl if not exist
function installCurl() {
	if [ "$(curl --version 2>/dev/null)" ]; then
		echo 'curl exist'
    	return
	else
		yum install -y curl
	fi
}

# install git if not exist
function installGit() {
	if [ "$(git --version)" ];then
		echo 'git exist'
    	return
	else
	    yum install -y git
	fi
}

#download Tpl from git
function downloadTpl() {
	installGit
	if [ ! -d "${config[installDir]}" ];then
		mkdir -p ${config[installDir]}
	fi
	cd ${config[installDir]}
	if [ -d "${config[installDir]}/dnmp" ];then
          echo "do nothing" #		cd dnmp && git fetch --all && git reset --hard origin/master && git pull
	else
	    git config --global core.autocrlf false
		git clone ${config[tplUrl]}
	fi

  if [ -f "${config[installDir]}/dnmp/external/docker_images/badguy-dnmp_nginx-1.0" ];then
      docker load < ${config[installDir]}/dnmp/external/docker_images/badguy-dnmp_nginx-1.0;
  fi
  if [ -f "${config[installDir]}/dnmp/external/docker_images/badguy-dnmp_php73-1.0" ];then
      docker load < ${config[installDir]}/dnmp/external/docker_images/badguy-dnmp_php73-1.0;
  fi
  if [ -f "${config[installDir]}/dnmp/external/docker_images/badguy-dnmp_php56-1.0" ];then
      docker load < ${config[installDir]}/dnmp/external/docker_images/badguy-dnmp_php56-1.0;
  fi
  if [ -f "${config[installDir]}/dnmp/external/docker_images/mariadb-10.1" ];then
      docker load < ${config[installDir]}/dnmp/external/docker_images/mariadb-10.1;
  fi

}

function build() {
	installDockerCompose
	cd ${config['installDir']}/dnmp
	docker-compose up -d --build
	docker-compose ps
}

# install docker-compose if not exist
function installDockerCompose() {
	if [ "$(docker-compose -v)" ];then
		echo 'docker-compose exist'
    	return
	else
	    sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	    sudo chmod +x /usr/local/bin/docker-compose
	fi
}

declare -A config
config=(
	[installDir]="$(dirname $(pwd))"
	[tplUrl]="https://github.com/badguy2015/dnmp.git"
)


#installDocker
addRegistryMirrors
downloadTpl
build
