#!/bin/bash


image="andromeda"
name="andromeda"
confdir="${PWD}/conf"
logdir="/data/${name}/logs"
scriptdir="${PWD}/lua_script"
setting="${PWD}/setting"
testsdir="${PWD}/tests"

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

test() {

    docker run --name ${name} \
        -v ${confdir}:/usr/local/openresty/nginx/conf \
        -v ${logdir}:/usr/local/openresty/nginx/logs \
        -v ${scriptdir}:/usr/local/openresty/lua_script\
        -v ${setting}:/usr/local/openresty/setting \
        -v ${testsdir}:/usr/local/openresty/tests \
        --net=host \
        ${image} \
        sh /usr/local/openresty/tests/run_tests.sh
}

shell() {

    docker run -it --rm --name ${name} \
        -v ${confdir}:/usr/local/openresty/nginx/conf \
        -v ${logdir}:/usr/local/openresty/nginx/logs \
        -v ${scriptdir}:/usr/local/openresty/lua_script\
        -v ${setting}:/usr/local/openresty/setting \
        -v ${testsdir}:/usr/local/openresty/tests \
        --net=host \
        ${image} \
        /bin/ash
}

Action=$1

shift

case "$Action" in
  build) build ;;
  start) start ;;
  stop ) stop  ;;
  test ) test  ;;
  shell) shell ;;
  *)  echo 'build | start | stop | test | shell';;
esac

