#!/bin/bash
defaultConatinerName="easyder-php54";

echo -n "please enter nginx container name(default:${defaultConatinerName})->"
read containerName

if [ ! ${containerName} ];then
    containerName="${defaultConatinerName}";
fi

docker exec -it ${containerName} /bin/bash
