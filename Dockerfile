FROM libreelecarm/transmission
MAINTAINER mcczarny@gmail.com

RUN apk --update add transmission-remote cron \
  && rm -rf /var/cache/apk/*

ADD ./transmission_clear_completed.sh /opt/
RUN chmod u+x  /transmission_clear_completed.sh && (crontab -l ; echo "@hourly /opt/transmission_clear_completed.sh") | crontab