
echo -e "\e[33m Disable nodejs \e[0m"  
yum module disable nodejs -y  &>>/tmp/roboshop.log
echo -e "\e[33m nable nodejs \e[0m"
yum module enable nodejs:18 -y  &>>/tmp/roboshop.log

echo -e "\e[33m install nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m add user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m create directory \e[0m"
mkdir /app  &>>/tmp/roboshop.log

echo -e "\e[33m Download application content \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log 
cd /app 

echo -e "\e[33m unzip the folder \e[0m"
unzip /tmp/cart.zip  &>>/tmp/roboshop.log

echo -e "\e[33m dependencies \e[0m"
cd /app 
npm install &>>/tmp/roboshop.log

echo -e "\e[33m copy service file \e[0m"
cp /Project/Roboshopproject/cart.service /etc/systemd/system/cart.service  &>>/tmp/roboshop.log

echo -e "\e[33m start cart \e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log
 
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log