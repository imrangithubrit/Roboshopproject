
# need to copy repo file
cp mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y 


systemctl enable mongod 



systemctl restart mongod