#!/bin/bash
echo "Create PEM file - see README"
cd /opt/keycloak/
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out crt.pem 

echo "Manually update https because sed format errrs on provisioning"
#https-certificate-file=/opt/keycloak/crt.pem
#https-certificate-key-file=/opt/keycloak/key.pem

LOCAL_HOST_IP="10.86.1.190"
psql -h $LOCAL_HOST_IP -p 5432 -U keycloak

export KEYCLOAK_ADMIN="admin"
export KEYCLOAK_ADMIN_PASSWORD="admin"

cd /opt/keycloak/
echo "Run Podman first"
sudo podman|docker build . -t mykeycloak

echo "Run Podman second time"
sudo podman|docker run --name mykeycloak -p 8443:8443 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=change_me mykeycloak start --optimized
OR more options
podman|docker run --name mykeycloak -p 8443:8443 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:latest start --db=postgres --db-url=jdbc:postgresql://10.86.1.190:5432/keycloak --db-username=keycloak --db-password=keycloak