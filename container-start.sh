#!/bin/bash
. ./lib/utils.sh
DOCKER_CONTAINER_BASE_NAME="ansible-role-test"
SSH_PUBLIC_KEY_FILE=ansible/ssh/id_rsa.pub
SSH_PUBLIC_KEY=$(cat "$SSH_PUBLIC_KEY_FILE")

CONTAINER_NUMBER=$1

for i in $(seq 1 $CONTAINER_NUMBER);
do
    sudo docker run -ti --privileged --name $DOCKER_CONTAINER_BASE_NAME''_$i -d -p 500$i:22 -e AUTHORIZED_KEYS="$SSH_PUBLIC_KEY" local/centos7-systemd;
    # echo $DOCKER_CONTAINER_BASE_NAME''_$i
done

