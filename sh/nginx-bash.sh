#!/bin/bash
defaulName="easyder-nginx"
echo -n "please enter nginx container name(default:${defaulName})->"
read containerName

if [ ! ${containerName} ];then
    containerName="${defaulName}";
fi

docker exec -it ${containerName} /bin/bash
