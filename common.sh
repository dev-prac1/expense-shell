print_task_heading() {
  echo $1
  echo "########### $1 ##########" &>>/tmp/expense.log
}

check_status() {
  if [ $? -eq 0 ]; then
    echo sucess
    else
      echo failure
      fi
}