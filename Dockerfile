FROM coolsoft/jdk8:latest

ENV YOUTRACK_VERSION=6.5.17031 \
    TIMEZONE=Europe/Budapest

RUN apk --update add openssl tzdata
RUN rm -rf /var/cache/apk/*
RUN mkdir -p /opt/youtrack/data
RUN mkdir -p /var/lib/youtrack
RUN mkdir -p /etc/youtrack
RUN mkdir -p /usr/local/youtrack
RUN wget http://download-cf.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar -O /usr/local/youtrack/youtrack-$YOUTRACK_VERSION.jar
RUN ln -s /usr/local/youtrack/youtrack-$YOUTRACK_VERSION.jar /opt/youtrack/youtrack.jar
RUN cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime
RUN echo "$TIMEZONE" > /etc/timezone

ADD ./etc/youtrack /etc/

EXPOSE 8080
VOLUME ["/opt/youtrack/conf", "/opt/youtrack/data"]
WORKDIR /opt/youtrack
CMD ["java", "-Xmx1g", "-XX:MaxPermSize=250m", "-Djava.awt.headless=true", "-Duser.home=/var/lib/youtrack", "-Djavax.net.ssl.trustStore=/etc/ssl/certs/java/cacerts", "-Djavax.net.ssl.trustStorePassword=changeit", "-Djetbrains.mps.webr.log4jPath=/etc/youtrack/log4j.xml", "-Djava.security.egd=/dev/zrandom", "-Ddatabase.location=/opt/youtrack/data", "-jar", "youtrack.jar", "8080"]
