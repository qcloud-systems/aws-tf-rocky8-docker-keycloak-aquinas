#!/bin/bash/
[ec2-user@ip-10-79-1-14 ~]$ sudo -u postgres psql
could not change directory to "/home/ec2-user": Permission denied
psql (14.3)
Type "help" for help.
postgres=# create database keycloak;
CREATE DATABASE
postgres=# create user keycloak with encrypted password 'keycloak';
CREATE ROLE
postgres=# grant all privileges on database keycloak to keycloak; 
GRANT
[ec2-user@ip-10-79-1-14 ~]$ sudo -u postgres psql
could not change directory to "/home/ec2-user": Permission denied
psql (14.3)
Type "help" for help.
postgres=# ALTER DATABASE keycloak OWNER TO keycloak;
ALTER DATABASE

sudo systemctl restart postgresql

psql -h 10.22.1.56 -p 5432 -U keycloak
\l
\conninfo
\c keycloak