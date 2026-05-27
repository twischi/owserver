#!/bin/sh

# Show running script
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
echo "  $0"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" && echo 

# Load names to variable
. "$(dirname "$0")/names-docker.sh" && echo

# Stop/kill the container in case it is  running 
docker kill $dockerContainerName
# Remove the container that it can be build again 
docker rm $dockerContainerName

# Start the container with right parameter	
docker run -d \
--restart unless-stopped \
--device /dev/bus/usb \
-p 4304:4304 \
-p 2121:2121 \
-p 2120:2120 \
--name="$dockerContainerName" "$dockerImageName"

#--net=testnet \
#--network-alias myowserver \
#--device /dev/fuse \
#--cap-add SYS_ADMIN \
#--security-opt apparmor:unconfined \
#-v /home/pi/owserver/owfs.conf:/etc/owfs.conf \
#--privileged \
#--name=owserver \
#-v /home/pi/owserver/1wire:/mnt/1wire \
#-v /home/pi/1wire_fs:/mnt/1wire:ro \