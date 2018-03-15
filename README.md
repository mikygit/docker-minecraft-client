# docker-minecraft-client

This project aims to provide a minecraft client running in docker containers, even for users behind a firewall ...

It's based on docker image [Oracle Java 8 (and 7) with GLIBC 2.23 over AlpineLinux](https://hub.docker.com/r/anapsix/alpine-java/)


## BUILDING

docker build [--build-arg PROXY_URL=$YOUR_PROXY_URL] -t minecraft-client .

## RUNNING

Next is a sample run command:

``` script
docker run -d --net host \
   -v /tmp/.X11-unix:/tmp/.X11-unix \
   -v /dev/shm:/dev/shm \
   -v $HOST_MINECRAFT_ROOT:/root/.minecraft \
   --device /dev/dri \
   --device /dev/snd \
   -e DISPLAY=$HOST_IP:0.0 \
   --name minecraft minecraft-client \
   proxychains -f proxychains.conf java -Dhttp.proxyHost=$YOUR_PROXY_HOST -Dhttp.proxyPort=$YOUR_PROXY_PORT -Dhttps.proxyHost=$YOUR_PROXY_HOST -Dhttps.proxyPort=$YOUR_PROXY_PORT -jar Minecraft.jar
```

At the moment, it is not working as expected especially if you are behind a firewall.

Working on it ...
