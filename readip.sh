#!/bin/bash

ips=$1
if [[ $# -lt 1 ]]
then
  echo "Usage: $0 please enter you filepath"
  exit
fi

#################
## config
#################
USER=root
PASSWORD=password
IP=0
PORT=22
#SRCDIR=/home/zhtian/sftpload/sftpFiles #skywelld ca proto.gz server.crl
SRCDIR=/home/zhtian/sftpload/certificate #skywelld ca proto.gz server.crl
DESDIR=/root

#:<<!
uploader()
{
cd ${SRCDIR}
FILES=`ls`
#upload
for FILE in ${FILES}
do
    echo ${FILE}
    echo "FileName : "${FILE%.*}
    echo "FileExte : "${FILE##*.}
    
    exten=${FILE##*.}
    if [ "${exten}" = "pem" ]; then
        echo "Need to be upload"
    elif [ "${exten}" = "crt" ]; then
        echo "crt need to be upload"
    else
        echo "Not the corrent file, No need to upload"
        continue
    fi

:<<!
lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd ${DESDIR}/
lcd ${SRCDIR}
put ${FILE}
by
EOF
!
done
}
#!

index=5

uploadIndex()
{
#crt="test"${index}".crt"
#pem="test"${index}".pem"
key="test"${index}".key"
#key="a.sh"
echo "Upload crt : "${crt}
echo "Upload pem : "${pem}
lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd ${DESDIR}/
lcd ${SRCDIR}
put ${key}
by
EOF
}


readIPs()
{
while read myline
do
    #read ips
    echo
    echo "index : "${index}
    echo -e "\033[41;36mUPLOADING IP : \033[0m"$myline
    
    IP=$myline
    uploadIndex 

    echo -e "\033[41;36mUPLOADING DONE. \033[0m"
    ((index=${index}+1))
    echo 
done < $ips
}

readIPs
