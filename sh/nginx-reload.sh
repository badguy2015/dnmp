#!/bin/bash
defaultName="easyder-nginx"
echo -n "please enter nginx container name(default:${defaultName})->"
read containerName

if [ ! ${containerName} ];then
    containerName="${defaultName}";
fi

docker exec -it ${containerName} nginx -s reload
