source common.sh

mysql_root_password=$1
app_dir=/app
component=backend

# if password is not provided then we will exit
if [ -z "${mysql_root_password}" ]; then
  echo input password is missing.
  exit 1
  fi

print_task_heading "disable default nodejs version module"
dnf module disable nodejs -y &>>$LOG
check_status $?

print_task_heading "enable nodejs module for v20"
dnf module enable nodejs:20 -y &>>$LOG
check_status $?

print_task_heading "install nodejs"
dnf install nodejs -y &>>$LOG
check_status $?

print_task_heading "adding application user"
id expense &>>$LOG
if [ $? -ne 0 ]; then
 useradd expense &>>$LOG
fi
check_status $?

print_task_heading "copy backend service file"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
check_status $?

app_prereq

print_task_heading "download nodejs dependencies"
cd /app &>>$LOG
npm install &>>$LOG
check_status $?

print_task_heading "start backend service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
check_status $?

print_task_heading "install mysql client"
dnf install mysql -y &>>$LOG
check_status $?

print_task_heading "load schema"
mysql -h 172.31.88.89 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
check_status $?