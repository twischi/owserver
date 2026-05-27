#!/bin/bash

# Wait 2s for contiainer
sleep 2
echo "STARTING One Wire Server in Docker Container..."
echo

echo "Print the owfs.conf:" 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
cat /etc/owfs.conf && echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo

# Start the Services
echo "#################################################################"
echo "1. Start service: 'owserver'..."
service owserver start
#timeout 5 service owserver start || true
sleep 2

echo "#################################################################"
echo "2. Start service_ 'owhttpd'..."
service owhttpd start
#timeout 5 service owhttpd start || true

echo "#################################################################"
echo "3. Start service: 'owfs'..."
owfs -c /etc/owfs.conf -s 127.0.0.1:4304

# NOT used be ready 
# echo "#################################################################"
# echo "4. Start service: 'owftpd'..."
# service owftpd start
#timeout 5 service owftpd start || true


echo "#################################################################"
echo "Startup sequence DONE"

echo 
echo "#################################################################"
echo "Status of services"
service owserver status
service owhttpd status
service owftpd status

# Spin until we receive a SIGTERM (e.g. from `docker stop`)
echo "#################################################################"
echo "Entering endless loop and wait for SIGTERM."
trap 'exit 143' SIGTERM # exit = 128 + 15 (SIGTERM)
tail -f /dev/null & wait ${!}