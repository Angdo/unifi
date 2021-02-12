FROM alpine:3.9

ARG VERSION="6.0.45"

WORKDIR /build

RUN wget -O unifi.zip https://dl.ui.com/unifi/${VERSION}/UniFi.unix.zip

RUN unzip unifi.zip

RUN rm UniFi/bin/mongod \
&& apk add --no-cache mongodb \
&& cp /usr/bin/mongod UniFi/bin/ \
&& apk del --no-cache mongodb

RUN mkdir UniFi/data && echo -e 'unifi.http.port=80\nunifi.https.port=443' >> UniFi/data/system.properties

FROM alpine:3.9
MAINTAINER Angdo <job.angdo@gmail.com>

ARG VERSION="6.0.45"

EXPOSE 80/tcp 443/tcp 3478/udp 5514/udp 8880/tcp 8843/tcp 6789/tcp 27117/tcp 10001/udp 1900/udp

WORKDIR /unifi

COPY --from=0 /build/UniFi /unifi

RUN apk add --no-cache openjdk8-jre-base libpcrecpp yaml-cpp libcurl libsasl snappy boost-program_options boost-filesystem boost-system gcompat

ENTRYPOINT ["java","-Xms128M","-Xmx1024M","-cp","/usr/share/java/commons-daemon.jar:/unifi/lib/ace.jar","com.ubnt.ace.Launcher","start","-Djava.awt.headless=true","-Dfile.encoding=UTF-8","-Dunifi.core.enabled=false","-Dunifi.datadir=/unifi/data","-Dunifi.logdir=/var/log/unifi","-Dunifi.rundir=/var/run/unifi"]
