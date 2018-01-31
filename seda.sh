#!/bin/bash

BASEDIR=$2

VIRTUALIP="172.16.123.1"
ORIG=`pwd`
RUNSCRIPT="run.sh"
REPOBASE="https://innersource.soprasteria.com/digilab-spain/seda"
PROJECTS="ch-create-client domain-clients domain-portfolios saga-create-client query-clients"

function cloneRepos(){
    for proj in $PROJECTS
    do
       if [ ! -d $proj ]; then
        git clone "$REPOBASE/$proj.git"
       fi
    done
}

function installDocker(){
    for proj in $PROJECTS
    do
       if [ -d $proj ]; then
        cd $proj
        mvn install dockerfile:build
        cd ..
       fi
    done
}

function network(){
    NET=`ifconfig -a|grep ${VIRTUALIP}`
    if [ "$NET" == "" ]; then
        sudo ifconfig lo0 alias ${VIRTUALIP}
    fi
}

function start(){
    for proj in $PROJECTS
    do
       if [ -f "$proj/${RUNSCRIPT}" ]; then
        cd $proj
        bash $RUNSCRIPT
        cd ..
       else
        echo "
        -----------------------------------------------------------------
            IMPOSSIBLE TO START: ${proj} - NO ${RUNSCRIPT} script found!
        -----------------------------------------------------------------
        "
       fi
    done
}


function stopSee(){
    ps -ef|grep "docker logs"|grep -v grep|awk '{print $2}'|xargs kill
}

function seeLogs(){
    stopSee
    for proj in $PROJECTS
    do
       if [ -d "$proj" ]; then
        docker logs $proj -f &
       fi
    done
    wait
}

function stop(){
    stopSee
    for proj in $PROJECTS
    do
       if [ -d "$proj" ]; then
        cd $proj
        bash $RUNSCRIPT stop
        cd ..
       fi
    done
}

# ------------------ RUN -------

if [ "$BASEDIR" == "" ]; then
    BASEDIR="../demo"
fi

if [ ! -d "$BASEDIR" ]; then
    mkdir $BASEDIR
fi

network
cd $BASEDIR

case $1 in
    "install")
        cloneRepos
        installDocker
        ;;
    "start")
        docker-compose -f "$ORIG/docker-compose.yml" up -d
        start
        ;;
    "stop")
        stop
        docker-compose -f "$ORIG/docker-compose.yml" stop
        ;;
    "watch")
        seeLogs
        ;;
    "stop-watch")
        stopSee
        ;;
    *)
        echo "use:
./seda.sh [install|start|stop|watch|stop-watch]"
        ;;
esac