

echo -e "\e[33m  configuration node js \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[33m  install nodejs \e[0m"
yum install nodejs -y   &>>/tmp/roboshop.log

echo -e "\e[33m add Application user \e[0m"
useradd roboshop   &>>/tmp/roboshop.log

rm -rf /app
mkdir /app 

echo -e "\e[33m Download application director \e[0m"

curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>>/tmp/roboshop.log

echo -e "\e[33m Extract application content \e[0m"
cd /app   &>>/tmp/roboshop.log
unzip /tmp/user.zip  &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33m Install nodejs sependencies \e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33m setup user service \e[0m"
# cp service
cp /Project/Roboshopproject/user.service /etc/systemd/system/user.service  &>>/tmp/roboshop.log

echo -e "\e[33m  start user service \e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log

systemctl enable user &>>/tmp/roboshop.log
systemctl restart user  &>>/tmp/roboshop.log

echo -e "\e[33m copy mongodb repo file \e[0m"
#copy mpng.rep
cp /Project/Roboshopprojectmongo.repo /etc/yum.repos.d/mongo.repo  &>>/tmp/roboshop.log

echo -e "\e[33m install mongodb \e[0m"
yum install mongodb-org-shell -y   &>>/tmp/roboshop.log

mongo --host mongodb-dev.devopsb72.store </app/schema/user.js  &>>/tmp/roboshop.log