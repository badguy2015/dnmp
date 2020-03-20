#nginx 进入容器，修改 /usr/share/nginx/html 权限
#注意 ./www/test 文件夹的权限


#安装方式
1.在线安装（推荐）
- 请阅读注意事项后,下载install.sh文件，配置安装路径${config[installDir]},直接执行;
##注意事项：
- ps:实例一：安装目录为：/docker,则把install.sh文件下载到/docker目录，添加执行权限(chmod a+x /docker/install.sh)后,直接运行(cd /docker;./install.sh)
- 在实例一的首次安装中，请保证/docker/dnmp目录不存在(install.sh文件会自动创建)
- 在线安装方法，仅限于第一次安装dnmp环境,安装成功后,需要更新，则参照离线安装方案
- 关于安装路径,install.sh执行位置，与安装路径无关;
- 安装路径规则：
    1.绝对路径;eg: [installDir]="/yourPath/";最终安装效果：/yourPath/dnmp/www/some_web_project
    2.除根目录外，末尾不要添加'/'

2.离线安装
- 下载整个项目，配置安装路径${config[installDir]}=$(dirname $(pwd)),直接执行

