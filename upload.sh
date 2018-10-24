#!/bin/bash

#SFTP配置信息
#用户名
USER=root
#密码
PASSWORD=pass
#待上传文件根目录
SRCDIR=/home/zhtian/sftpload/sftpFiles
#FTP目录
DESDIR=/root
#IP
IP=ip
#端口
PORT=22

#获取文件
cd ${SRCDIR};
#目录下的所有文件
FILES=`ls` 
#修改时间在执行时间五分钟之前的xml文件
#@FILES=`find ${SRCDIR} -mmin -50 -name '*.xml'`

for FILE in ${FILES}
do
    echo ${FILE}
#发送文件 (关键部分）
lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd ${DESDIR}/
lcd ${SRCDIR}
put ${FILE}
by
EOF

done


