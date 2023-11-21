 
 echo -e "\e[33m Copy Mongodb repo file \e[0m"
# need to copy repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33m Installing Mongodb server \e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log


sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[33m start mongodb \e[0m"
systemctl enable mongod  &>>/tmp/roboshop.log
systemctl restart mongod