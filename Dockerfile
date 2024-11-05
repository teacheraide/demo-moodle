FROM docker.io/bitnami/moodle:4.5

COPY ./rootfs/ /

EXPOSE 8080
EXPOSE 8443