#!/bin/sh

mpv --profile=low-latency \
	--demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg,video_size=1280x720 \
	--untimed /dev/video3 --no-osc --wayland-app-id="mpv-webcam"
