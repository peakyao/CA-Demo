#!/bin/bash

#定义环境变量
IP_HOST_CN=192.168.242.5
#IP_HOST_CN=www.test.com
DNS_HOST_CN=192.168.242.5
#DNS_HOST_CN=test.com

#Create directory hierarchy.创建目录结构
#serial存储证书序列号
cp /etc/pki/tls/openssl.cnf ../

cd ..
mkdir ca && cd ca
touch serial
chmod 666 serial
echo 01 >  serial
mkdir -p private

#生成ca私钥
# rsa 2048-bit,为包含秘钥可以通过增加-des 或者 -des3等参数设置秘钥
openssl genrsa -out ./private/cakey.pem 2048
#openssl genrsa -des3 -out ./private/cakey.pem 2048

#openssl req -new -days 3650 -key ./private/cakey.pem -out ca.csr #签发请求 两步骤操作
openssl req -new -sha256  \
    -days 36500 \
    -key ./private/cakey.pem \
    -subj "/C=CN/ST=BeiJing/L=Beijing/O=OWNCA/OU=Ownca/CN=${IP_HOST_CN}" \
    -out ca.csr

#openssl ca -selfsign -in ca.csr -out ca.crt  #生成ca证书 两步骤操作
openssl ca -selfsign \
    -days 36500 \
    -extensions SAN \
    -config <(cat ./openssl.cnf \
        <(printf "[SAN]\nsubjectAltName=DNS.1:${DNS_HOST_CN}")) \
    -in ca.csr -keyfile ./private/cakey.pem  \
    -out ca.crt

# 一步到位.一步生成csr，crt，直接10年使用期,生成ca证书
#openssl req -new -x509 -days 3650 -key ./private/cakey.pem -out ca.crt
#openssl req -new -sha256  \
#    -x509 \
#    -days 36500 \
#    -key ./private/cakey.pem \
#    -subj "/C=CN/ST=BeiJing/L=Beijing/O=OWNCA/OU=Ownca/CN=${IP_HOST_CN}" \
#    -extensions SAN \
#    -config <(cat ./openssl.cnf \
#        <(printf "[SAN]\nsubjectAltName=DNS.1:${DNS_HOST_CN}")) \
#    -out ca.crt
#
###查看csr内容
#openssl req -in ca.csr -text
#
###查看证书内容
#openssl x509 -in ca.crt -text -noout

