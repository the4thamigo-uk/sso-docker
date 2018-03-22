FROM centos/systemd

RUN yum clean all
RUN yum install -y epel-release
RUN yum update -y
RUN yum install -y initscripts vim nano redis curl wget deltarpm

ARG idp_port
ARG radius_port

EXPOSE 6379 $idp_port $redis_port
