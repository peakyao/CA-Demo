#!/bin/bash
# 签发服务器证书
cd ..
mkdir server
#生成服务端私钥
openssl genrsa -out ./server/server.key
#生成服务端签发请求
openssl req -new -key ./server/server.key -out ./server/server.csr
#生成服务端证书
openssl ca -in ./server/server.csr -cert ../ca/ca.crt -keyfile ../ca/private/cakey.pem -out ./server/server.crt -days 3650
