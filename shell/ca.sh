#!/bin/bash

#Create directory hierarchy.创建目录结构
#serial存储证书序列号
cd ..
mkdir ca && cd ca
touch serial
chmod 666 serial
echo 01 >  serial
mkdir -p private

#生成ca私钥
openssl genrsa -des3 -out ./private/cakey.pem 2048
#openssl req -new -days 365 -key ./private/cakey.pem -out ca.csr
#openssl ca -selfsign -in ca.csr -out ca.crt
# one step.一步生成csr，crt，直接10年使用期,生成ca证书
openssl req -new -x509 -days 3650 -key ./private/cakey.pem -out ca.crt
