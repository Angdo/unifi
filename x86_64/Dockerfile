FROM alpine
MAINTAINER Angdo <job.angdo@gmail.com>

ARG VERSION="5.9.29"
EXPOSE 80/tcp 443/tcp 6789/tcp 63010/udp 63011/tcp 63012/tcp

RUN apk add --no-cache openjdk8-jre-base

RUN apk add --no-cache mongodb \
&& mkdir /unifi && mkdir /unifi/bin \
&& cp /usr/bin/mongod /unifi/bin/ && apk del --no-cache mongodb

RUN apk add --no-cache libcurl snappy libsasl yaml-cpp libpcrecpp boost-program_options boost-filesystem boost-system gcompat

RUN echo wget https://bintray.dragon.ivenfe.cc/docker/unifi/${VERSION}/$(apk --print-arch)/unifi_${VERSION}_$(apk --print-arch)_nomongodb.tar.bz2 \
&&  wget https://bintray.dragon.ivenfe.cc/docker/unifi/${VERSION}/$(apk --print-arch)/unifi_${VERSION}_$(apk --print-arch)_nomongodb.tar.bz2 \
&& tar -jvxf unifi_*.tar.bz2 && rm unifi_*.tar.bz2

ENTRYPOINT ["java","-cp","/unifi/lib/ace.jar","com.ubnt.ace.Launcher","start","-Djava.awt.headless=true","-Dfile.encoding=UTF-8","-Dunifi.datadir=/unifi/data","-Dunifi.logdir=/var/log/unifi","-Dunifi.rundir=/var/run/unifi"]