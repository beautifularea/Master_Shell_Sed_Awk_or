#!/bin/bash

ips=$1
FILE="skywelld.cfg"

#################
## config
#################
USER=root
PASSWORD=password
IP=0
PORT=22
SRCDIR=/home/zhtian/sftpload/sftpFiles #skywelld ca proto.gz server.crl
DESDIR=/root

readIPs()
{
while read myline
do
    #read ips
    echo
    echo -e "\033[41;36mUPLOADING IP : \033[0m"$myline

    IP=$myline

    echo "uploading file : "${FILE}
   
#:<<! 
    lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd ${DESDIR}/
lcd ${SRCDIR}
put ${FILE}
by
EOF
#!

    echo -e "\033[41;36mUPLOADING DONE. \033[0m"
    echo 
done < $ips
}

readIPs
