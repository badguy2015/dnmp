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
	echo -e "{\n  \"registry-mirrors\": [\n    "https://dockerhub.azk8s.cn"\n  ]\n}">/etc/docker/daemon.json
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
		cd dnmp && git pull
	else
		git clone ${config[tplUrl]}
	fi
}

function build() {
	installDockerCompose
	cd ${config['installDir']}/dnmp
	docker-compose up -d
	docker-compose ps
}

# install docker-compose if not exist
function installDockerCompose() {
	if [ "$(docker-compose -v)" ];then
		echo 'docker-compose exist'
    	return
	else
	    #install...
	    #source 1
	    #sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	    #source 2
	    sudo curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	    sudo chmod +x /usr/local/bin/docker-compose
	fi
}

declare -A config
config=(
	[installDir]="$(dirname $(pwd))"
	[tplUrl]="https://github.com/badguy2015/dnmp.git"
)


installDocker
addRegistryMirrors
downloadTpl
build