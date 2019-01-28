FROM alpine
LABEL maintainer="job.angdo@gmail.com"
ARG VERSION="5.9.29"
ARG ARCH="arm64"
EXPOSE 8443/tcp 8080/tcp 6789/tcp 3478/udp 10001/udp

RUN wget https://bintray.dragon.ivenfe.cc/docker/unifi/${VERSION}/${ARCH}/unifi_${VERSION}_${ARCH}.tar.bz2 \
&& tar -jxvf unifi_*.tar.bz2 && rm unifi_*.tar.bz2 \
&& cd /unifi && find . -name "*.br" | xargs rm -f \
&& rm -rf lib/native/Windows/* \
&& rm -rf lib/native/Mac/* \
&& rm -rf lib/native/Linux/armv7/* \
&& rm -rf lib/native/Linux/x86_64/* \
&& sed -i 's/v3.8/v3.9/g' /etc/apk/repositories \
&& apk add --no-cache openjdk8-jre-base libcurl snappy libsasl yaml-cpp libpcrecpp boost-program_options boost-filesystem boost-system libcrypto1.1 libssl1.1

ENTRYPOINT ["java","-cp","/unifi/lib/ace.jar","com.ubnt.ace.Launcher","start"]
