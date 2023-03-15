#!/bin/bash/
LOCAL_HOST_IP="10.22.1.179"
KC_VERSION="keycloak-20.0.3"

echo "Manually update config file manually after local host provisioning"
sed -i "s;#db-url=jdbc:postgresql://localhost/keycloak;db-url=jdbc:postgresql://$LOCAL_HOST_IP:5432/keycloak;g" /opt/keycloak/$KC_VERSION/conf/keycloak.conf

echo "Create PEM file - see README"
cd /opt/keycloak/
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out crt.pem 

echo "Manually update https because sed format errrs on provisioning"
#--https-certificate-file=/opt/keycloak/crt.pem
#--https-certificate-key-file=/opt/keycloak/key.pem

psql -h $LOCAL_HOST_IP -p 5432 -U keycloak

export KEYCLOAK_ADMIN="admin"
export KEYCLOAK_ADMIN_PASSWORD="admin"
# OR Go to http://localhost:8443/auth and create admin user to login

echo "Javascript must be enabled to run this app https://stackoverflow.com/questions/8205369/installing-npm-on-aws-ec2"
#npm install -g npm@9.6.0
sudo npm install -g serve
serve -s build

echo "Start keycloak optimized"
KC_PATH="/opt/keycloak/$KC_VERSION"
$KC_PATH/bin/kc.sh build --db postgres
$KC_PATH/bin/kc.sh start --optimized --hostname-strict-backchannel=true --https-protocols=TLSv1.3,TLSv1.2 --hostname-strict-https=true --hostname-strict=false 

#Need to view https, http does not work at all
#https://3.144.37.119:8443/