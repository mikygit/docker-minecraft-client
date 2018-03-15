FROM anapsix/alpine-java 

MAINTAINER Mike Niemaz <mike.niemaz@gmail.com> 

ARG PROXY_URL

ENV http_proxy $PROXY_URL
ENV https_proxy $PROXY_URL
ENV no_proxy 127.0.0.1

ARG GPU=intel 
ARG JAR_PATH=http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.jar 

RUN apk update \
    && apk upgrade \
    && apk add --no-cache ca-certificates \
    && update-ca-certificates 2>/dev/null || true

RUN apk add --no-cache \
    alsa-lib \ 
    eudev-libs \ 
    libxcursor \ 
    libxtst \	
    libxi \
    mesa-dri-$GPU \ 
    mesa-gl \ 
    xrandr \
    openssl \
    proxychains-ng 

ADD $JAR_PATH /minecraft/ 

WORKDIR /minecraft 

COPY ./proxychains.conf ./
COPY ./docker-entrypoint.sh ./
RUN chmod 755 ./proxychains.conf
RUN chmod 755 ./docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
