FROM centos/systemd

RUN yum clean all
RUN yum install -y epel-release
RUN yum update -y
RUN yum install -y initscripts vim redis curl wget

EXPOSE 80 6379 8000 8080
