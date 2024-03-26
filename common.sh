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