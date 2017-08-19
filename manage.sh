#!/bin/bash


image="andromeda"
name="andromeda"
confdir="${PWD}/conf"
logdir="/data/${name}/logs"
scriptdir="${PWD}/andromeda"
setting="${PWD}/setting"
testsdir="${PWD}/tests"
openrestyhome="/usr/local/openresty"

build() {
    docker build -t ${image} .
}

start() {

    stop

    docker run -d --name ${name} \
        -v ${confdir}:${openrestyhome}/nginx/conf \
        -v ${logdir}:${openrestyhome}/nginx/logs \
        -v ${scriptdir}:${openrestyhome}/andromeda\
        -v ${setting}:${openrestyhome}/setting \
        --net=host \
        ${image}
}

stop() {
    docker stop  ${name} &>/dev/null
    docker rm -v ${name} &>/dev/null
}

test() {

    docker run --rm --name ${name}-test \
        -v ${confdir}:${openrestyhome}/nginx/conf \
        -v ${logdir}:${openrestyhome}/nginx/logs \
        -v ${scriptdir}:${openrestyhome}/andromeda\
        -v ${setting}:${openrestyhome}/setting \
        -v ${testsdir}:${openrestyhome}/tests \
        --net=host \
        ${image} \
        sh ${openrestyhome}/tests/run_tests.sh
}

shell() {

    docker run -it --rm --name ${name}-shell \
        -v ${confdir}:${openrestyhome}/nginx/conf \
        -v ${logdir}:${openrestyhome}/nginx/logs \
        -v ${scriptdir}:${openrestyhome}/andromeda\
        -v ${setting}:${openrestyhome}/setting \
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

