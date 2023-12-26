component=catalogue

echo -e "\e[33m  configuration node js \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[33m  install nodejs \e[0m"
yum install nodejs -y   &>>/tmp/roboshop.log

echo -e "\e[33m add Application user \e[0m"
useradd roboshop   &>>/tmp/roboshop.log

rm -rf /app
mkdir /app 

echo -e "\e[33m Download application director \e[0m"

curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>/tmp/roboshop.log

echo -e "\e[33m Extract application content \e[0m"
cd /app   &>>/tmp/roboshop.log
unzip /tmp/$component.zip  &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33m Install nodejs sependencies \e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33m setup $component service \e[0m"
# cp service
cp /project/Roboshopproject/$component.service /etc/systemd/system/$component.service  &>>/tmp/roboshop.log

echo -e "\e[33m  start $component service \e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log

systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component  &>>/tmp/roboshop.log

echo -e "\e[33m copy mongodb repo file \e[0m"
#copy mpng.rep
cp /project/Roboshopproject/mongo.repo /etc/yum.repos.d/mongo.repo  &>>/tmp/roboshop.log

echo -e "\e[33m install mongodb \e[0m"
yum install mongodb-org-shell -y   &>>/tmp/roboshop.log

mongo --host mongodb-dev.devopsb72.store </app/schema/$component.js  &>>/tmp/roboshop.log