FROM alpine
MAINTAINER Angdo <job.angdo@gmail.com>

ENV VERSION="5.9.29.0" ARCH="x64"
EXPOSE 8443/tcp 8080/tcp 6789/tcp 3478/udp 10001/udp

RUN apk add --no-cache openjdk8-jre-base snappy yaml-cpp libpcrecpp boost-filesystem boost-system boost-program_options libsasl \
&& wget https://bintray.static.ivenfe.cc/docker/unifi/$VERSION/$ARCH/unifi_$VERSION.tar.gz \
&& tar -zxvf unifi_*.tar.gz && rm unifi_*.tar.gz

ENTRYPOINT ["java","-cp","/unifi/lib/ace.jar","com.ubnt.ace.Launcher","start","-Djava.awt.headless=true","-Dfile.encoding=UTF-8","-Dunifi.datadir=/unifi/data","-Dunifi.logdir=/var/log/unifi","-Dunifi.rundir=/var/run/unifi"]