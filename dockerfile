## 
## docker build -t mogeaver-docker:latest .
## docker run -it --rm --name mogeaver -v d:\MogeaverData:/root/.local/share/MogeaverData -v d:\dump_data:/root mogeaver-docker:latest
## /root/.local/share/MogeaverData is a dir that include user's config info
## /root is default backup(gs_dump) dir 

FROM pksadiq/gtk:fedora-amd64 as builder

LABEL maintainer="darkathena@qq.com"

## online download
#RUN set -eux; \
#    yum install wget -y &&\
#    wget https://cdn-mogdb.enmotech.com/mogeaver/22.1.5/mogeaver-ce-22.1.5-linux.gtk.x86_64.tar.gz  && \
#    wget https://cdn-mogdb.enmotech.com/mogdb-media/3.0.1/MogDB-3.0.1-CentOS-x86_64.tar.gz
#FROM pksadiq/gtk:fedora-amd64
#COPY --from=builder /mogeaver-ce-22.1.5-linux.gtk.x86_64.tar.gz  /tmp
#COPY --from=builder /MogDB-3.0.1-CentOS-x86_64.tar.gz  /tmp

COPY mogeaver-ce-22.1.5-linux.gtk.x86_64.tar.gz  /tmp/
COPY MogDB-3.0.1-CentOS-x86_64.tar.gz /tmp/
COPY drivers.xml /opt/

RUN tar -xvf /tmp/mogeaver-ce-22.1.5-linux.gtk.x86_64.tar.gz -C /opt && \
    tar -xvf /tmp/MogDB-3.0.1-CentOS-x86_64.tar.gz -C /tmp && \
    tar -xvf /tmp/MogDB-3.0.1-CentOS-64bit-tools.tar.gz -C /opt 

FROM pksadiq/gtk:fedora-amd64

COPY --from=builder /opt  /opt

## change yum repo
#RUN mv /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora.repo.backup && \
#    mv /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo.backup 
#RUN curl -O /etc/yum.repos.d/fedora.repo http://mirrors.aliyun.com/repo/fedora.repo && \
#    curl -O /etc/yum.repos.d/fedora-updates.repo http://mirrors.aliyun.com/repo/fedora-updates.repo && \
#    dnf makecache

RUN set -eux; \
    yum install java-latest-openjdk.x86_64 -y &&\
    rm -rf /tmp/* && \
    yum clean all && \
    dnf clean all && \
    rm -rf /var/cache/dnf/* && \
    ln -s /usr/lib64/libreadline.so.8 /usr/lib64/libreadline.so.6 && \
    ln -s /usr/lib64/libcrypt.so.2 /usr/lib64/libcrypt.so.1 && \
    echo "export DISPLAY=host.docker.internal:0"  >> /opt/start.sh && \
    echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/lib:/usr/lib64:/usr/lib:/opt/lib"  >> /opt/start.sh && \
    echo "mkdir -p /root/.local/share/MogeaverData/workspace6/.metadata/.plugins/org.jkiss.dbeaver.core"  >> /opt/start.sh && \
    echo "cp -n /opt/drivers.xml /root/.local/share/MogeaverData/workspace6/.metadata/.plugins/org.jkiss.dbeaver.core/drivers.xml"  >> /opt/start.sh && \
    echo "/opt/mogeaver/mogeaver"  >> /opt/start.sh && \
    chmod 777 /opt/start.sh 

## chinese font support
# RUN yum install cjkuni-ukai-fonts cjkuni-uming-fonts -y &&\
#     rm -rf /etc/fonts/local.conf && \
#     echo "<?xml version='1.0'?>"  >> /etc/fonts/local.conf && \
#     echo "<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>"  >> /etc/fonts/local.conf && \
#     echo "<fontconfig>"  >> /etc/fonts/local.conf && \
#     echo " <alias>"  >> /etc/fonts/local.conf && \
#     echo "  <family>serif</family>"  >> /etc/fonts/local.conf && \
#     echo "  <prefer>"  >> /etc/fonts/local.conf && \
#     echo "   <family>Liberation Serif</family>"  >> /etc/fonts/local.conf && \
#     echo "   <family>AR PL UMing CN</family>"  >> /etc/fonts/local.conf && \
#     echo "  </prefer>"  >> /etc/fonts/local.conf && \
#     echo " </alias>"  >> /etc/fonts/local.conf && \
#     echo " <alias>"  >> /etc/fonts/local.conf && \
#     echo "  <family>sans-serif</family>"  >> /etc/fonts/local.conf && \
#     echo "  <prefer>"  >> /etc/fonts/local.conf && \
#     echo "   <family>Liberation Sans</family>"  >> /etc/fonts/local.conf && \
#     echo "   <family>AR PL UMing CN</family>"  >> /etc/fonts/local.conf && \
#     echo "  </prefer>"  >> /etc/fonts/local.conf && \
#     echo " </alias>"  >> /etc/fonts/local.conf && \
#     echo " <alias>"  >> /etc/fonts/local.conf && \
#     echo "  <family>monospace</family>"  >> /etc/fonts/local.conf && \
#     echo "  <prefer>"  >> /etc/fonts/local.conf && \
#     echo "   <family>Liberation Mono</family>"  >> /etc/fonts/local.conf && \
#     echo "   <family>AR PL UMing CN</family>"  >> /etc/fonts/local.conf && \
#     echo "  </prefer>"  >> /etc/fonts/local.conf && \
#     echo " </alias>"  >> /etc/fonts/local.conf && \
#     echo "</fontconfig>"  >> /etc/fonts/local.conf 
    
CMD exec /opt/start.sh