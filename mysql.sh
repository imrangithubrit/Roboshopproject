
echo -e "\e[33m Disable mysql \e[0m"
yum module disable mysql -y  &>>/tmp/roboshop.log

#copy repo file
echo -e "\e[33m Copy mysql repo file \e[0m"
cp /Project/Roboshopproject/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[33m Install mysql \e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33m start mysql \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld   &>>/tmp/roboshop.log

echo -e "\e[33m setup mysql password \e[0m"

mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

mysql -uroot -pRoboShop@1