FROM fedora:latest

RUN dnf install -y postfix rsyslog supervisor ; dnf clean all
RUN sed -i "s/inet_interfaces = localhost/inet_interfaces = all/g" /etc/postfix/main.cf ; echo mynetworks = 172.0.0.0/8, 10.0.0.0/8, 127.0.0.0/8, 192.168.0.0/16 >> /etc/postfix/main.cf

COPY ./resources/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./resources/rsyslog.conf /etc/rsyslog.conf
COPY ./resources/listen.conf /etc/rsyslog.d/listen.conf

CMD /usr/bin/echo myhostname=$myhostname >> /etc/postfix/main.cf; /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
