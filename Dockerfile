FROM docker.io/bitnami/moodle:4.5

RUN mkdir -p /docker-entrypoint-init.d

COPY ./rootfs/docker-entrypoint-init.d/* /docker-entrypoint-init.d/