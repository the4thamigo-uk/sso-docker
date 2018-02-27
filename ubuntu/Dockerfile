FROM phusion/baseimage

RUN apt-get update -y
RUN apt-get install -y jq redis-server vim curl wget
RUN rm /var/lock
RUN mkdir /var/lock 

EXPOSE 80 6379 8000 8080
