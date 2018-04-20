# Based on https://github.com/CentOS/CentOS-Dockerfiles/tree/master/systemd/centos7
# https://raw.githubusercontent.com/CentOS/CentOS-Dockerfiles/master/LICENSE

ARG from_image
ARG idp_port
ARG radius_port

FROM $from_image

ENV container docker
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]

RUN yum clean all && \
    yum install -y epel-release && \
    yum install -y \
      initscripts \
      ca-certificates \
      deltarpm \
      redis \
      vim \
      nano \
      curl \
      wget

EXPOSE 6379 $idp_port $redis_port

CMD ["/usr/sbin/init"]
