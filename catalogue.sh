component=catalogue
color="\e[33m"
nocolor="\e[0m"


echo -e "${color}  configuration node js ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log

echo -e "${color}  install nodejs ${nocolor}"
yum install nodejs -y   &>>/tmp/roboshop.log

echo -e "${color} add Application user ${nocolor}"
useradd roboshop   &>>/tmp/roboshop.log

rm -rf /app
mkdir /app 

echo -e "${color} Download application director ${nocolor}"

curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>/tmp/roboshop.log

echo -e "${color} Extract application content ${nocolor}"
cd /app   &>>/tmp/roboshop.log
unzip /tmp/$component.zip  &>>/tmp/roboshop.log
cd /app 

echo -e "${color} Install nodejs sependencies ${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color} setup $component service ${nocolor}"
# cp service
cp /project/Roboshopproject/$component.service /etc/systemd/system/$component.service  &>>/tmp/roboshop.log

echo -e "${color}  start $component service ${nocolor}"
systemctl daemon-reload  &>>/tmp/roboshop.log

systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component  &>>/tmp/roboshop.log

echo -e "${color} copy mongodb repo file ${nocolor}"
#copy mpng.rep
cp /project/Roboshopproject/mongo.repo /etc/yum.repos.d/mongo.repo  &>>/tmp/roboshop.log

echo -e "${color} install mongodb ${nocolor}"
yum install mongodb-org-shell -y   &>>/tmp/roboshop.log

mongo --host mongodb-dev.devopsb72.store </app/schema/$component.js  &>>/tmp/roboshop.log