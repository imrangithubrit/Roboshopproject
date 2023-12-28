color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"


nodejs()  {
  echo -e "${color}  configuration node js ${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${log_file}
    
  echo -e "${color}  install nodejs ${nocolor}"
  yum install nodejs -y   &>>${log_file}

  echo -e "${color} add Application user ${nocolor}"
  useradd roboshop   &>>${log_file}

  rm -rf ${app_path}
  mkdir ${app_path}

  echo -e "${color} Download application director ${nocolor}"

  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>${log_file}

  echo -e "${color} Extract application content ${nocolor}"
  cd ${app_path}   &>>${log_file}
  unzip /tmp/$component.zip  &>>${log_file}
  cd ${app_path} 

  echo -e "${color} Install nodejs sependencies ${nocolor}"
  npm install &>>${log_file}

  echo -e "${color} setup $component service ${nocolor}"
    # cp service
  cp /project/Roboshopproject/$component.service /etc/systemd/system/$component.service  &>>${log_file}

  echo -e "${color}  start $component service ${nocolor}"
  systemctl daemon-reload  &>>${log_file}

  systemctl enable $component &>>${log_file}
  systemctl restart $component  &>>${log_file}
}

mongo_schema_setup()
{
echo -e "${color} copy mongodb repo file ${nocolor}"
#copy mpng.rep
cp /project/Roboshopproject/mongo.repo /etc/yum.repos.d/mongo.repo  &>>${log_file}

echo -e "${color} install mongodb ${nocolor}"
yum install mongodb-org-shell -y   &>>${log_file}

mongo --host mongodb-dev.devopsb72.store </app/schema/$component.js  &>>${log_file}

}