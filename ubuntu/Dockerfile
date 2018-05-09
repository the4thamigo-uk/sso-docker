# Based on https://github.com/solita/docker-systemd
# https://github.com/solita/docker-systemd/blob/master/LICENSE

ARG from_image
ARG idp_port
ARG radius_port

FROM $from_image

ENV container docker

# Don't start any optional services except for the few we need.
RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \;

RUN apt-get update && \
    apt-get install -y \
    dbus \
    systemd \
    ca-certificates \
    redis-server \
    vim \
    nano \
    curl \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN systemctl set-default multi-user.target

COPY setup /sbin/

STOPSIGNAL SIGRTMIN+3

EXPOSE $idp_port $redis_port

# Workaround for docker/docker#27202, technique based on comments from docker/docker#9212
CMD ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]
