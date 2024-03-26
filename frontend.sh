source common.sh

app_dir=/usr/share/nginx/html
component=frontend

print_task_heading "install nginx"
dnf install nginx -y &>>$LOG
check_status $?

print_task_heading "copy expense nginx configuration"
cp expence.conf /etc/nginx/default.d/expense.conf &>>$LOG
check_status $?

app_prereq

print_task_heading "start nginx service"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
check_status $?
