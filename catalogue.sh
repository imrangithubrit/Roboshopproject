

echo -e "\e[33m  configuration node js \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[33m  install nodejs \e[0m"
yum install nodejs -y   &>>/tmp/roboshop.log

echo -e "\e[33m add Application user \e[0m"
useradd roboshop   &>>/tmp/roboshop.log

mkdir /app 

echo -e "\e[33m Download application director \e[0m"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>>/tmp/roboshop.log

echo -e "\e[33m Extract application content \e[0m"
cd /app   &>>/tmp/roboshop.log
unzip /tmp/catalogue.zip  &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33m Install nodejs sependencies \e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33m setup catalogue service \e[0m"
# cp service
cp catalogue.service /etc/systemd/system/catalogue.service  &>>/tmp/roboshop.log

echo -e "\e[33m  start catalogue service \e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log

systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue  &>>/tmp/roboshop.log

echo -e "\e[33m copy mongodb repo file \e[0m"
#copy mpng.rep
cp mongo.repo /etc/yum.repos.d/mongo.repo  &>>/tmp/roboshop.log

echo -e "\e[33m install mongodb \e[0m"
yum install mongodb-org-shell -y   &>>/tmp/roboshop.log

mongo --host mongodb-dev.devopsb72.store </app/schema/catalogue.js  &>>/tmp/roboshop.log