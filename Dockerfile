FROM alpine
MAINTAINER rtyler@brokenco.de
EXPOSE 22

RUN apk add -U openssh-server

COPY sshd_config /etc/ssh/
COPY run-sshd /usr/sbin/

RUN adduser -h /home/aci -D aci && passwd -u aci
RUN mkdir /home/aci/.ssh && chmod 700 /home/aci/.ssh && chown -R aci /home/aci

ENTRYPOINT ["/usr/sbin/run-sshd"]
