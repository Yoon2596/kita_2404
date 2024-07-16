MySQL setting
- root에 들어가서 하단 코드 적고 각 행마다 ctrl+enter로 실행

show databases; 
create database kita3_db;
select * from user;
CREATE USER 'kita3'@'localhost' IDENTIFIED BY 'kita3';
GRANT ALL PRIVILEGES ON *.* TO 'kita3'@'localhost';
flush privileges;
show tables;
Select User, Host FROM user;
USE kita3_db;

위에서 쓰세요

show databases; 
create database rys_db;
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

- 모두 실행 후 sql 종료후 다시 들어온후 root 상단에 + 버튼 눌러서 
ex : kita1@localhost, kita1, ps kita1 다 적기

