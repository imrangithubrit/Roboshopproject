
echo -e "\e[33m Install Redis Repos \e [0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>>/tmp/roboshop.log


echo -e "\e[33m Enable Redis 6 version \e[0m"
yum module enable redis:remi-6.2 -y  &>>/tmp/roboshop.log

echo -e "\e[33m Install Redis \e[0m"
yum install redis -y &>>/tmp/roboshop.log


echo -e "\e[33m Start Redis \e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log

