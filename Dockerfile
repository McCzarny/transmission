FROM libreelecarm/transmission
MAINTAINER mcczarny@gmail.com

RUN apk --update add transmission-cli \
  && rm -rf /var/cache/apk/*

ADD ./transmission_clear_completed.sh /opt/
RUN chmod +x  /opt/transmission_clear_completed.sh && (crontab -l ; echo "@hourly /opt/transmission_clear_completed.sh") | crontab
