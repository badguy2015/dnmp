#!/bin/bash
defaultConatinerName="easyder-php73";

echo -n "please enter nginx container name(default:${defaultConatinerName})->"
read containerName

if [ ! ${containerName} ];then
    containerName="${defaultConatinerName}";
fi

docker exec -it ${containerName} systemctl stop php73-php-fpm
