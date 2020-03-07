#!/bin/bash
# 签发服务器证书
cd ..
mkdir server
#生成服务端私钥
#openssl genrsa -out cas-server/cas-server.key 1024
openssl genrsa -out ./server/server.key

#生成服务端签发请求
openssl req -new -sha256  \
      -days 10000 \
      -key cas-server/cas-server.key \
      -subj "/C=CN/ST=BeiJing/L=Beijing/O=CAS/OU=cas-server/CN=www.cas-server.com" \
      -out cas-server/cas-server.csr

openssl req -new -key ./server/server.key -out ./server/server.csr

#通过CA签发生成服务端证书
openssl ca \
      -in cas-server/cas-server.csr \
      -md sha256 \
      -cert root/ca.crt \
      -keyfile root/ca.key \
      -extensions SAN \
      -config <(cat openssl.cnf \
          <(printf "[SAN]\nsubjectAltName=DNS.1:cas-server.com,DNS.2:*.cas-server.com,DNS.3:www.cas-server.com")) \
      -out cas-server/cas-server.crt

openssl ca -in ./server/server.csr -cert ../ca/ca.crt -keyfile ../ca/private/cakey.pem -out ./server/server.crt -days 3650
