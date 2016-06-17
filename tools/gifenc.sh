#!/bin/sh

palette="/tmp/palette.png"

if [ -z $4 ]; then
    filters="fps=15,scale=320:-1:flags=lanczos"
else
    filters="fps=$4,scale=$3:-1:flags=lanczos"
fi

ffmpeg -v warning -i $1 -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $2
