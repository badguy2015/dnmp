#!/bin/bash
defaultConatinerName="easyder-php74";

echo -n "please enter nginx container name(default:${defaultConatinerName})->"
read containerName

if [ ! ${containerName} ];then
    containerName="${defaultConatinerName}";
fi

docker exec -it ${containerName} systemctl reload php74-php-fpm
