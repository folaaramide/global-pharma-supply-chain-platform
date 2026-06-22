#!/bin/bash

dnf update -y

dnf install -y git

dnf install -y python3

python3 -m ensurepip --upgrade

pip3 install flask

pip3 install flask-cors

pip3 install pymysql

cd /home/ssm-user

git clone https://github.com/folaaramide/global-pharma-supply-chain-platform.git

cd global-pharma-supply-chain-platform/app

nohup python3 app.py > flask.log 2>&1 &