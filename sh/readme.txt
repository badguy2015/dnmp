#常用命令

docker-compose:
    启动(up): /bin/bash ./docker-start.sh
    停止(down): /bin/bash ./docker-stop.sh
    重启(down&&up): /bin/bash ./docker-restart.sh

nginx容器:
    启动bin/bash ./nginx-start.sh
    停止bin/bash ./nginx-stop.sh
    重启: /bin/bash ./nginx-restart.sh
    进入容器: /bin/bash ./nginx-bash.sh

php73容器:
    启动bin/bash ./php73-start.sh
    停止bin/bash ./php73-stop.sh
    重启: /bin/bash ./php73-restart.sh
    进入容器: /bin/bash ./php73-bash.sh