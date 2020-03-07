#/bin/bash
#把x509证书crt转换为pem文件
openssl x509 -in cas-server/cas-server.crt -outform PEM -out cas-server/cas-server.pem

#生成pkcs12格式的证书 as-server.pem(证书)与cas-server.key合并生成pkcs12
openssl pkcs12 -export -in cas-server.pem -inkey cas-server.key -out cas-server.pfx

#转pkcs12为jks
keytool -importkeystore -srckeystore cas-server.pfx -srcstoretype PKCS12 -deststoretype JKS -destkeystore cas-server.jks

#转jks为pkcs12
keytool -importkeystore -srckeystore cas-server.jks -destkeystore cas-server.jks -deststoretype pkcs12
