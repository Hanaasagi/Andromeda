#!/bin/bash


image="andromeda"
name="andromeda"
confdir="${PWD}/conf"
logdir="/data/${name}/logs"
scriptdir="${PWD}/lua_script"
setting="${PWD}/setting"

build() {
    docker build -t ${image} .
}


start() {

    stop

    docker run -d --name ${name} \
        -v ${confdir}:/usr/local/openresty/nginx/conf \
        -v ${logdir}:/usr/local/openresty/nginx/logs \
        -v ${scriptdir}:/usr/local/openresty/lua_script\
        -v ${setting}:/usr/local/openresty/setting \
        --net=host \
        ${image}
}

stop() {
    docker stop  ${name} &>/dev/null
    docker rm -v ${name} &>/dev/null
}

Action=$1

shift

case "$Action" in
  build) build ;;
  start) start ;;
  stop ) stop  ;;
  *)  echo 'build | start | stop';;
esac

