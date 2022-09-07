## 使用说明
1. 先确保本地windows已安装docker-desktop,并已经启动该服务
>https://www.docker.com/get-started/

2. 下载VcXsrv
> https://sourceforge.net/projects/vcxsrv/

3. 安装VcXsrv，一路下一步，然后打开XLaunch，一路下一步
4. 下载mogdb和mogeaver压缩包，放到本文件夹
```
wget https://cdn-mogdb.enmotech.com/mogeaver/22.1.5/mogeaver-ce-22.1.5-linux.gtk.x86_64.tar.gz
wget https://cdn-mogdb.enmotech.com/mogdb-media/3.0.1/MogDB-3.0.1-CentOS-x86_64.tar.gz
```
5. 进入本目录，执行构建镜像命令
```
docker build -t mogeaver-docker:latest .
```
6. 构建完成后，执行run_mogeaver.bat即可启动mogeaver
7. 默认用户配置路径在 d:\MogeaverData ，可以通过修改run_mogeaver.bat文件变更
8. 默认gs_dump导出文件路径在 d:\dump_data ，可以通过修改run_mogeaver.bat文件变更
9. 如果需要中文字体支持，请取消dockerfile中关于“Chinese font support”部分的注释
10. 如果需要更换国内yum源，请取消dockerfile中关于“change yum repo”部分的注释

## 特点
1. 已集成openGauss客户端命令行工具，比如gsql/gs_dump等，可以通过mogeaver相关功能调用
2. 关闭程序即删除容器，节省内存资源