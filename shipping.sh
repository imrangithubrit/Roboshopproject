echo -e "\e[33m Install manven \e[0m"
yum install maven -y  &>>/tmp/roboshop.log

echo -e "\e[33m add user \e[0m"
useradd roboshop  &>>/tmp/roboshop.log

rm -rf /app &>>/tmp/roboshop.log

echo -e "\e[33m add folder \e[0m"
mkdir /app  &>>/tmp/roboshop.log

echo -e "\e[33m download the content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33m unzip the folder \e[0m"
cd /app &>>/tmp/roboshop.log
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33m move to target foler \e[0m"
cd /app &>>/tmp/roboshop.log
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log


echo -e "\e[33m copy the service file \e[0m"
cp /project/Roboshopproject/shipping.service /etc/systemd/system/shipping.service  &>>/tmp/roboshop.log

echo -e "\e[33m start the shippping service \e[0m"

systemctl daemon-reload &>>/tmp/roboshop.log

systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log

echo -e "\e[33m install the mysql \e[0m"
yum install mysql -y &>>/tmp/roboshop.log


mysql -h mysql-dev.devopsb72.store	 -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

systemctl restart shipping &>>/tmp/roboshop.log