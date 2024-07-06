#!/bin/bash

echo "Update Linux, dnf, & Instal Java 11"
sudo yum update -y
sudo dnf -y install wget
dnf update -y
dnf install git -y

echo "Install postgres on Rocky Linux/"
sudo yum install postgresql-server -y
postgresql-setup --initdb --unit postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo systemctl status postgresql

echo "Add entries in /var/lib/pgsql/data/pg_hba.conf to allow md5 auth for all & postgres User"
sudo su
echo 'host      all           all             0.0.0.0/0               md5' >> /var/lib/pgsql/data/pg_hba.conf
echo 'host      all           postgres        127.0.0.1/32            md5' >> /var/lib/pgsql/data/pg_hba.conf

echo "Add Listener entry in /var/lib/pgsql/data/postgresql.conf "
sudo su
echo "listen_addresses = '*'" >> /var/lib/pgsql/data/postgresql.conf

echo "Create postgres components"
sudo -u postgres psql << EOF
create database medusa;
create user medusa with encrypted password 'medusa';
grant all privileges on database medusa to medusa;
ALTER DATABASE medusa OWNER TO medusa;
EOF
sudo systemctl restart postgresql
sudo systemctl status postgresql
