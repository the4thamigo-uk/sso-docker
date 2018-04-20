FROM phusion/baseimage

RUN apt-get update -y
RUN apt-get install -y jq redis-server vim nano curl wget

ARG idp_port
ARG radius_port

EXPOSE 6379 $idp_port $redis_port
