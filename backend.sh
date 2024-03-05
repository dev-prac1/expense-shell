mysql_root_password=$1
echo disable default nodejs version module
dnf module disable nodejs -y &>>/tmp/expense.log
echo enable nodejs module for v20
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo install nodejs
dnf install nodejs -y &>>/tmp/expense.log
useradd expense &>>/tmp/expense.log
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
rm -rf /app &>>/tmp/expense.log
mkdir /app &>>/tmp/expense.log
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
dnf install mysql -y &>>/tmp/expense.log
mysql -h 172.31.5.188 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>/tmp/expense.log