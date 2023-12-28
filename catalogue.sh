source common.sh
component=catalogue



nodejs

echo -e "${color} copy mongodb repo file ${nocolor}"
#copy mpng.rep
cp /project/Roboshopproject/mongo.repo /etc/yum.repos.d/mongo.repo  &>>${log_file}

echo -e "${color} install mongodb ${nocolor}"
yum install mongodb-org-shell -y   &>>${log_file}

mongo --host mongodb-dev.devopsb72.store </app/schema/$component.js  &>>${log_file}