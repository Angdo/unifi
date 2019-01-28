FROM aarch64/alpine
MAINTAINER Angdo <job.angdo@gmail.com>

ENV VERSION="5.9.29"
EXPOSE 8443/tcp 8080/tcp 6789/tcp 3478/udp 10001/udp

RUN apk add --no-cache openjdk8-jre-base mongodb snappy yaml-cpp libpcrecpp boost-filesystem boost-system boost-program_options libsasl \
&& wget https://bintray.dragon.ivenfe.cc/docker/unifi/$VERSION/unifi_$VERSION.tar.bz2 \
&& tar -jxvf unifi_*.tar.bz2 && rm unifi_*.tar.bz2 \
&& cp /usr/bin/mongod /unifi/bin/ && apk del mongodb

ENTRYPOINT ["java","-cp","/unifi/lib/ace.jar","com.ubnt.ace.Launcher","start","-Djava.awt.headless=true","-Dfile.encoding=UTF-8","-Dunifi.datadir=/unifi/data","-Dunifi.logdir=/var/log/unifi","-Dunifi.rundir=/var/run/unifi"]