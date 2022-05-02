#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "./start.sh /path/to/data"
    exit -1
fi

docker run --rm -it -d \
    --name radar_loc \
    -v $(realpath $(dirname $0))/../:/home/docker_radar_loc/RadarLoc \
    -v $(realpath $1):/data \
    --net "host" \
    --privileged \
    --gpus all \
    radar_loc:latest
