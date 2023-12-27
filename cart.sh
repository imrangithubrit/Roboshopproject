source common.sh
component=cart


echo -e "${color} Disable nodejs ${nocolor}"  
yum module disable nodejs -y  &>>${log_file}
echo -e "${color} nable nodejs ${nocolor}"
yum module enable nodejs:18 -y  &>>${log_file}

echo -e "${color} install nodejs ${nocolor}"
yum install nodejs -y &>>${log_file}

echo -e "${color} add user ${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} create directory ${nocolor}"
mkdir ${app_path}  &>>${log_file}

echo -e "${color} Download application content ${nocolor}"
curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>${log_file} 
cd ${app_path} 

echo -e "${color} unzip the folder ${nocolor}"
unzip /tmp/${component}.zip  &>>${log_file}

echo -e "${color} dependencies ${nocolor}"
cd ${app_path} 
npm install &>>${log_file}

echo -e "${color} copy service file ${nocolor}"
cp /Project/Roboshopproject/$component.service /etc/systemd/system/$component.service  &>>${log_file}

echo -e "${color} start $component ${nocolor}"
systemctl daemon-reload  &>>${log_file}
 
systemctl enable $component &>>${log_file}
systemctl restart $component &>>${log_file}