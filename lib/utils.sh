#!/bin/bash

getDockIP() {
    contID=$1
    sudo docker inspect $contID | grep "IPAddress" | tail -n 1
}

# Docker
startDebian() {
    sudo docker run -d debian sh -c 'while true ; do echo $(date) - loop !; /bin/sleep 60; done'
}
alias docker='sudo docker'

id_list() {
    name=$1
    echo $(docker ps -a | grep $name | awk '{print $1}'| tr '\n' ' ')
}

getContIPs() {
    container_name=$1
    for ip in $(id_list $container_name); do getDockIP $ip; done
    #    for ip in $(docker ps | grep $container_name | awk '{print $1}' | tr '\n' ' '); do getDockIP $ip; done
}

stopAndRmContainers() {
    name=$1
    ids=$(docker ps -a | grep $name | awk '{print $1}'| tr '\n' ' ')
    for id in $ids;
    do
        sudo docker stop $id;
        sudo docker rm $id
    done
}
