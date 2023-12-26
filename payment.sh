yum install python36 gcc python3-devel -y


useradd roboshop

mkdir /app 

curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 
cd /app 
unzip /tmp/payment.zip

cd /app 
pip3.6 install -r requirements.txt

echo -e "\e[33m copy the service file \e[0m"
cp /project/Roboshopproject/payment.service /etc/systemd/system/payment.service  &>>/tmp/roboshop.log
systemctl daemon-reload

systemctl enable payment 
systemctl restart payment