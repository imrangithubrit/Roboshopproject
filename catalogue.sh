

echo -e "\e[33m  configuration node js \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[33m  install nodejs \e[0m"
yum install nodejs -y

echo -e "\e[33m add Application user \e[0m"
useradd roboshop

mkdir /app 

echo -e "\e[33m Download application director \e[0m"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 

echo -e "\e[33m Extract application content \e[0m"
cd /app 
unzip /tmp/catalogue.zip
cd /app 

echo -e "\e[33m Install nodejs sependencies \e[0m"
npm install 

echo -e "\e[33m setup catalogue service \e[0m"
# cp service
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[33m  start catalogue service \e[0m"
systemctl daemon-reload

systemctl enable catalogue 
systemctl restart catalogue

echo -e "\e[33m copy mongodb repo file \e[0m"
#copy mpng.rep
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33m install mongodb \e[0m"
yum install mongodb-org-shell -y

mongo --host mongodb-dev.devopsb72.store </app/schema/catalogue.js 