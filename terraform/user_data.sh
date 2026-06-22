#!/bin/bash

dnf update -y

dnf install -y git python3

python3 -m ensurepip --upgrade

python3 -m pip install flask flask-cors pymysql


export DB_HOST="global-pharma-supply-chain-db.cvsoquo865nl.eu-west-2.rds.amazonaws.com"
export DB_USER="admin"
export DB_PASSWORD="Password123!"
export DB_NAME="pharmadb"


echo "export DB_HOST=$DB_HOST" >> /home/ssm-user/.bashrc
echo "export DB_USER=$DB_USER" >> /home/ssm-user/.bashrc
echo "export DB_PASSWORD=$DB_PASSWORD" >> /home/ssm-user/.bashrc
echo "export DB_NAME=$DB_NAME" >> /home/ssm-user/.bashrc


cd /home/ssm-user

if [ ! -d "global-pharma-supply-chain-platform" ]; then

git clone https://github.com/folaaramide/global-pharma-supply-chain-platform.git

fi


cd /home/ssm-user/global-pharma-supply-chain-platform/app


nohup env \
DB_HOST=$DB_HOST \
DB_USER=$DB_USER \
DB_PASSWORD=$DB_PASSWORD \
DB_NAME=$DB_NAME \
python3 app.py > /home/ssm-user/flask.log 2>&1 &