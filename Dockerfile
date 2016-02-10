FROM coolsoft/jdk8:latest

ENV YOUTRACK_VERSION=6.5.17031 \
    TIMEZONE=Europe/Budapest

RUN apk --update add openssl unzip tzdata\
    && wget -O /tmp/youtrack.zip http://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.zip \
    && mkdir -p /opt/youtrack \
    && unzip /tmp/youtrack.zip -d /opt/youtrack  \
    && rm -rf /tmp/youtrack.zip  /var/cache/apk/* \
    && cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo "$TIMEZONE" >  /etc/timezone \
    && rm -rf /var/cache/apk/*

EXPOSE 8080
VOLUME ["/opt/youtrack/conf", "/opt/youtrack/data"]
CMD ["/opt/youtrack/bin/youtrack.sh", "run"]