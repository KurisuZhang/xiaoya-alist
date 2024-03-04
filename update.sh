#!/bin/bash

Sky_Blue="\e[36m"
Blue="\033[34m"
Green="\033[32m"
Red="\033[31m"
Yellow='\033[33m'
Font="\033[0m"
INFO="[${Green}INFO${Font}]"
ERROR="[${Red}ERROR${Font}]"
WARN="[${Yellow}WARN${Font}]"
function INFO() {
    echo -e "${INFO} ${1}"
}
function ERROR() {
    echo -e "${ERROR} ${1}"
}
function WARN() {
    echo -e "${WARN} ${1}"
}

DDSREM_CONFIG_DIR=/etc/DDSRem

for i in $(seq -w 3 -1 0); do
    echo -en "即将开始更新小雅Alist-TVBox${Blue} $i ${Font}\r"
    sleep 1
done
docker pull containrrr/watchtower:latest
docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower:latest \
    --run-once \
    --cleanup \
    "$(cat ${DDSREM_CONFIG_DIR}/container_name/xiaoya_tvbox_name.txt)"
docker rmi containrrr/watchtower:latest
INFO "更新成功！"
docker restart xiaoya-tvbox
