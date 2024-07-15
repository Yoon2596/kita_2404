MySQL setting

show databases; 
create database kevin_db;
show databases; 
select * from user;
CREATE USER 'rys’@’localhost' IDENTIFIED BY 'rys';
GRANT ALL PRIVILEGES ON *.* TO 'rys'@'localhost';
flush privileges;
Use mysql;
Select User, Host FROM user;
USE rys_db;
show databases; 
show tables;
select * from task;

CREATE USER 'kita1'@'localhost' IDENTIFIED BY 'kita1';
GRANT ALL PRIVILEGES ON *.* TO 'kita1'@'localhost';
flush privileges;
