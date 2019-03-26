FROM alpine
MAINTAINER rtyler@brokenco.de
EXPOSE 22

# curl and bash are for debugging
# ... ncurses is for nyan cat ^_^
RUN apk add -U -u openssh-server libcurl curl bash ncurses

COPY sshd_config /etc/ssh/
COPY bin/run-sshd /usr/sbin/
COPY bin/nyan /usr/bin/

RUN adduser -h /home/aci -D aci && passwd -u aci
RUN mkdir /home/aci/.ssh && chmod 700 /home/aci/.ssh && chown -R aci /home/aci

ENTRYPOINT ["/usr/sbin/run-sshd"]
