
echo -e "\e[33m Installing the nginx server \e[0m"
yum install nginx -y  >/tmp/roboshopssss.log

echo -e "\e[33m Installing old app content \e[0m"
rm -rf /usr/share/nginx/html/*  >/tmp/roboshopssss.log
echo -e "\e[33m Downloading the frontend contend \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  >/tmp/roboshopssss.log 

echo -e "\e[33m Extract frontend content \e[0m"
cd /usr/share/nginx/html   
unzip /tmp/frontend.zip  >/tmp/roboshopssss.log


# we need to add Roboshop config file
echo -e "\e[33m Starting Nginx server \e[0m"
systemctl enable nginx  >/tmp/roboshopssss.log
systemctl restart nginx  >/tmp/roboshopssss.log

