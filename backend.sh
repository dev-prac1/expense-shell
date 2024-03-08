mysql_root_password=$1

source common.sh

print_task_heading "disable default nodejs version module"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

print_task_heading "enable nodejs module for v20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

print_task_heading "install nodejs"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

print_task_heading "adding application user"
useradd expense &>>/tmp/expense.log
echo $?

print_task_heading "copy backend service file"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

 print_task_heading "clean the old content"
rm -rf /app &>>/tmp/expense.log
echo $?

print_task_heading "create app directory"
mkdir /app &>>/tmp/expense.log
echo $?

print_task_heading "download app content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

print_task_heading "extract app content"
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

print_task_heading "download nodejs dependencies"
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

print_task_heading "start backend service"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?

print_task_heading "install mysql client"
dnf install mysql -y &>>/tmp/expense.log
echo $?

print_task_heading "load schema"
mysql -h 172.31.5.188 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?