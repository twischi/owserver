#!/bin/bash

echo "Print the owfs.conf:" 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
cat /etc/owfs.conf && echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo

echo "Show with OWFS: Found devices:" 
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
ls -la /mnt/1wire/
echo

echo 
echo "#################################################################"
echo "Status of services"
service owserver status
service owhttpd status
service owftpd status
