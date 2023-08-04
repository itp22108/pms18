#!/usr/bin/expect -f

set mysql_user "root"
set mysql_password ""

set owncloud_db "ownclouddb"
set owncloud_user "ownclouduser"
set owncloud_password "pms18project"

spawn mysql --user=$mysql_user -p

expect "Enter password:"
send "$mysql_password\r"

expect "mysql>"
send "CREATE DATABASE $owncloud_db;\r"

expect "mysql>"
send "CREATE USER '$owncloud_user'@'localhost' IDENTIFIED BY '$owncloud_password';\r"

expect "mysql>"
send "GRANT ALL ON $owncloud_db.* TO '$owncloud_user'@'localhost' WITH GRANT OPTION;\r"

expect "mysql>"
send "FLUSH PRIVILEGES;\r"

expect "mysql>"
send "exit;\r"

interact
