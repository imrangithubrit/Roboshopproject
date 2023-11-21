
# need to copy repo file
cp /home/centos/roboshop.shell/mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y 


systemctl enable mongod 



systemctl restart mongod