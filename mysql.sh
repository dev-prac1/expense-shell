source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo input password is missing.
  exit 1
  fi

print_task_heading "install nginx"
dnf install mysql-server -y &>>$LOG
check_status $?

print_task_heading "install nginx"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
check_status $?

print_task_heading "install nginx"
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOG
check_status $?