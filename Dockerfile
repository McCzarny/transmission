FROM libreelecarm/transmission
MAINTAINER mcczarny@gmail.com

RUN apk --update add transmission-cli \
  && rm -rf /var/cache/apk/*

ADD ./transmission_clear_completed.sh /etc/periodic/hourly/transmission_clear_completed
RUN chmod +x  /etc/periodic/hourly/transmission_clear_completed
ADD ./settings.json /settings.json
ADD ./start.sh /start.sh
