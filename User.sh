
echo -e "\e[33m  configuration node js \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/roboshop.log



echo -e "\e[33m Install nodejs \e[0m"
yum install nodejs -y

echo -e "\e[33m Add user \e[0m"
useradd roboshop

rm -rf /app
echo -e "\e[33m create a folder \e[0m"
mkdir /app 

echo -e "\e[33m Download Application content \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 

echo -e "\e[33m Unzip the folder \e[0m"
unzip /tmp/user.zip

cd /app 
echo -e "\e[33m install dependencie \e[0m"
npm install 

#copy service file

cp /project/Roboshopproject/User.service /etc/yum.repos.d/User.service

systemctl daemon-reload

echo -e "\e[33m Start user \e[0m"
systemctl enable user 
systemctl restart user

echo -e "\e[33m Copy mongo rep file \e[0m"
#copy mongo repo file
cp /project/Roboshopproject/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33m Install mondo \e[0m"
yum install mongodb-org-shell -y


echo -e "\e[33m load schema \e[0m"
mongo --host mongodb-dev.devopsb72.store </app/schema/user.js


