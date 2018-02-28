FROM centos/systemd

RUN yum clean all
RUN yum install -y epel-release
RUN yum update -y
RUN yum install -y initscripts vim nano redis curl wget deltarpm

EXPOSE 80 6379 8000 1812
