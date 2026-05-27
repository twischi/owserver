#!/bin/sh

# Show running script
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
echo "  $0"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" && echo 

# Load names to variable
. "$(dirname "$0")/names-docker.sh" && echo

# Stop Container if running
./stopContainerAndKill.sh

docker run -it \
--rm \
--privileged \
--name="$dockerContainerName" \
--device /dev/bus/usb \
-p 4304:4304 \
-p 2121:2121 \
-p 2120:2120 \
"$dockerImageName"

#--net=testnet \
#--network-alias myowserver \
#--device /dev/fuse \
#--cap-add SYS_ADMIN \
#--security-opt apparmor:unconfined \
#-v /home/pi/1wire_fs:/mnt/1wire:ro \