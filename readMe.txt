#nginx 进入容器，修改 /usr/share/nginx/html 权限
#注意 ./www/test 文件夹的权限


#安装方式
1.在线安装
- 下载install.sh文件，配置安装路径${config[installDir]},直接执行

2.离线安装
- 下载整个项目，配置安装路径${config[installDir]}=$(dirname $(pwd)),直接执行