#!/bin/bash

dnf update -y

dnf install -y git

dnf install -y python3

python3 -m ensurepip --upgrade

python3 -m pip install flask

python3 -m pip install flask-cors

python3 -m pip install pymysql


echo 'export DB_HOST=global-pharma-supply-chain-db.cvsoquo865nl.eu-west-2.rds.amazonaws.com' >> /home/ssm-user/.bashrc

echo 'export DB_USER=admin' >> /home/ssm-user/.bashrc

echo 'export DB_PASSWORD=Password123!' >> /home/ssm-user/.bashrc

echo 'export DB_NAME=pharmadb' >> /home/ssm-user/.bashrc


export DB_HOST=global-pharma-supply-chain-db.cvsoquo865nl.eu-west-2.rds.amazonaws.com

export DB_USER=admin

export DB_PASSWORD='Password123!'

export DB_NAME=pharmadb


cd /home/ssm-user

if [ ! -d "global-pharma-supply-chain-platform" ]; then

git clone https://github.com/folaaramide/global-pharma-supply-chain-platform.git

fi


cd global-pharma-supply-chain-platform/app

nohup python3 app.py > flask.log 2>&1 &