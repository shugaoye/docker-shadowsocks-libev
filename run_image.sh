#!/bin/sh

USER_ID=`id -u`
USERNAME=`id -un`
GROUP_ID=`id -g`
GROUPNAME=`id -gn`
HOST_NAME=`hostname`

if [ -n "$1" ]; then
        IMAGE=$1
else
        IMAGE=shugaoye/docker-shadowsocks-libev:x86_64
fi

echo Running image ${IMAGE} ...
vol1="$(cd ..; pwd)"
# Running from the current folder and set the parent folder as a volume
docker run -ti --rm -p 4022:22  --name dkss-$HOST_NAME \
  -v ${HOME}/.ssh/:/home/${USERNAME}/.ssh/:ro \
  -v ${vol1}/test/keys/:/etc/ssh/keys \
  -v ${vol1}/test/data/:/data/ \
  -e USER_ID=${USER_ID} -e GROUP_ID=${GROUP_ID} \
  -e USERNAME=${USERNAME} -e GROUPNAME=${GROUPNAME} \
  -e SSH_ENABLE_ROOT=true \
  -e SSH_USERS=${USERNAME}:${USER_ID}:${GROUP_ID} \
  ${IMAGE} /bin/bash