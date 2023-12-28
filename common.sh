color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

app_presetup(){
    echo -e "${color} add Application user ${nocolor}"
    useradd roboshop   &>>${log_file}
    rm -rf ${app_path} &>>${log_file}

    echo -e "${color} add folder ${nocolor}"
    mkdir ${app_path}  &>>${log_file}
    
    echo -e "${color} Download application director ${nocolor}"

    curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip  &>>${log_file}

    echo -e "${color} unzip the folder ${nocolor}"
    cd ${app_path} &>>${log_file}
    unzip /tmp/$component.zip &>>${log_file}
}
systemd_setup() {
    echo -e "${color} copy the service file ${nocolor}"
    cp /project/Roboshopproject/$component.service /etc/systemd/system/$component.service  &>>${log_file}

    echo -e "${color} start the $component service ${nocolor}"

    systemctl daemon-reload &>>${log_file}

    systemctl enable $component &>>${log_file}
    systemctl restart $component &>>${log_file}


}
mysql_schema_setup(){
    echo -e "\e[33m install the mysql ${nocolor}"
    yum install mysql -y &>>${log_file}


    mysql -h mysql-dev.devopsb72.store	 -uroot -pRoboShop@1 < /app/schema/$component.sql &>>${log_file}

}

nodejs()  {
    echo -e "${color}  configuration node js ${nocolor}"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${log_file}
        
    echo -e "${color}  install nodejs ${nocolor}"
    yum install nodejs -y   &>>${log_file}

    app_presetup

    echo -e "${color} Install nodejs sependencies ${nocolor}"
    npm install &>>${log_file}

    systemd_setup
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



maven() {
    echo -e "${color} Install manven ${nocolor}"
    yum install maven -y  &>>${log_file}

    app_presetup

    echo -e "${color} move to target foler ${nocolor}"
    cd ${app_path} &>>${log_file}
    mvn clean package &>>$l{og_file}
    mv target/$component-1.0.jar $component.jar &>>${log_file}

   
   mysql_schema_setup 
    
    systemd_setup
}