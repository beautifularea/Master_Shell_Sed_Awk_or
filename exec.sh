#!/bin/bash

# 设置ssh连接的用户名
USER=root
# 设置ssh连接的host地址
HOST=ip
# 设置ssh连接的port端口号
PORT=22
# 设置ssh连接的登录密码
PASSWORD=password

index=5
while read ip
do
    HOST=${ip}
    echo "ok"

    while mapfile -t -n 2 ary && ((${#ary[@]})); do
    #printf '%s\n' "${ary[@]}"

        file="${ary[@]}"

        #insert publickey to after-line:82
        publicKey=` echo ${file} | awk -F' ' '{ print $1 }' `
        echo "publickey : "${publicKey}
        pk="${publicKey}"
        sshpass -p password ssh -o StrictHostKeyChecking=no $USER@$ip "sed '82 "$pk"' -i skywelld.cfg"

        #replace seed
        seed=` echo ${file} | awk -F' ' '{ print $2 }' `
        echo "seed : "${seed}
        fname="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        sshpass -p Jlp666... ssh -o StrictHostKeyChecking=no $USER@$ip "sed -i 's/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/$seed/g' skywelld.cfg" </dev/null

        #printf -- '--- SNIP ---\n'
    done < b.txt
    ((index=${index}+1))
done < $1



