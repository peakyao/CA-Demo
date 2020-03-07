#!/bin/bash
# 签发client证书
cd ..
mkdir client
#生成客户端私钥
openssl genrsa -des3 -out ./client/client.key 2048
#生成客户端签发请求
openssl req -new -key ./client/client.key -out ./client/client.csr
#生成客户端证书
openssl ca -in ./client/client.csr -cert ../ca/ca.crt -keyfile ../ca/private/cakey.pem -out ./client/client.crt -config "/etc/ssl/openssl.cnf"
#生成p12导入浏览器
openssl pkcs12 -export -clcerts -in ./client/client.crt -inkey ./client/client.key -out ./client/client.p12
