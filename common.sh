LOG=/tmp/expense.log



print_task_heading() {
  echo $1
  echo "########### $1 ##########" &>>$LOG
}

check_status() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32msucess\e[0m"
    else
      echo -e "\e[31mfailure\e[0m"
  fi
}

app_prereq() {

 print_task_heading "clean the old content"
rm -rf ${app_dir} &>>$LOG
check_status $?

print_task_heading "create app directory"
mkdir ${app_dir} &>>$LOG
check_status $?

print_task_heading "download app content"
curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
check_status $?

print_task_heading "extract app content"
cd ${app_dir} &>>$LOG
unzip /tmp/${component}.zip &>>$LOG
check_status $?
}