## 使用说明
1. 下载VcXsrv
> https://sourceforge.net/projects/vcxsrv/

2. 安装VcXsrv，一路下一步，然后打开XLaunch，一路下一步
3. 下载mogdb和mogeaver压缩包，放到本文件夹
```
wget https://cdn-mogdb.enmotech.com/mogeaver/22.1.5/mogeaver-ce-22.1.5-linux.gtk.x86_64.tar.gz
wget https://cdn-mogdb.enmotech.com/mogdb-media/3.0.1/MogDB-3.0.1-CentOS-x86_64.tar.gz
```
4. 进入本目录，执行构建镜像命令
```
docker build -t mogeaver-docker:latest .
```
5. 构建完成后，执行run_mogeaver.bat即可启动mogeaver

6. 默认用户配置路径在 d:\MogeaverData ，可以通过修改run_mogeaver.bat文件变更
7. 默认gs_dump导出文件路径在 d:\dump_data ，可以通过修改run_mogeaver.bat文件变更