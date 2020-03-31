#!/bin/bash
defaulName="easyder-mariadb"
echo -n "please enter mariadb container name(default:${defaulName})->"
read containerName

if [ ! ${containerName} ];then
    containerName="${defaulName}";
fi

docker exec -it ${containerName} /bin/bash
