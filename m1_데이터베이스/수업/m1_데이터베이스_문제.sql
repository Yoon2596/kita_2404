교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 24.05.24
- 성명 :  류윤선
- 점수 :

※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;

--Q1. EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
SELECT first_name || ' ' || last_name AS 이름, salary AS 연봉, salary * 1.1 AS 인상된_연봉 FROM employees;
    
--Q2. EMPLOYEES 테이블에서 2005년 상반기에 입사한 사람들만 출력	
SELECT first_name || ' ' || last_name AS 이름, hire_date FROM employees WHERE to_char(hire_date, 'yy/mm') BETWEEN '05/01' AND '05/06';

--Q3. EMPLOYEES 테이블에서 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
SELECT first_name || ' ' || last_name AS 이름, job_id FROM employees WHERE job_id IN ('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. EMPLOYEES 테이블에서 manager_id 가 101에서 103인 사람만 출력
SELECT first_name || ' ' || last_name AS 이름, manager_id FROM employees WHERE manager_id BETWEEN 101 AND 103;

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
SELECT last_name, hire_date, add_months(hire_date, 6) FROM employees;
SELECT last_name, hire_date, next_day(add_months(hire_date, 6), '월') "TARGET" FROM employees;
--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
SELECT employee_id, last_name, salary, hire_date, trunc(months_between(sysdate, hire_date)) AS W_MONTH FROM employees ORDER BY W_MONTH DESC;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
SELECT employee_id, last_name, salary, hire_date, trunc((sysdate - hire_date) / 365) AS W_YEAR FROM employees ORDER BY W_YEAR DESC;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
SELECT employee_id, last_name FROM employees WHERE MOD(employee_id, 2) = 1;

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
SELECT employee_id, last_name, ROUND(salary / 12, 2) AS M_SALARY FROM employees;

--Q10. employees 테이블에서 salary가 10000원 이상인 직원만을 포함하는 뷰 special_employee를 생성하는 SQL 명령문을 작성하시오.
CREATE VIEW "special_employee" AS
SELECT employee_id, first_name || ' ' || last_name AS 이름, salary FROM employees WHERE salary >= 10000;
SELECT * FROM special_employee;

--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
SELECT commission_pct, count(*) AS 값 FROM employees GROUP BY commission_pct;
SELECT count(*) AS 값 FROM employees WHERE commission_pct IS NULL;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
SELECT employee_id, first_name || ' ' || last_name AS 이름, '신입' AS POSITION FROM employees WHERE department_id IS NULL;
SELECT employee_id, first_name || ' ' || last_name AS 이름, nvl(to_char(department_id), '신입') AS position FROM employees WHERE department_id IS NULL;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS 이름, e.job_id, j.job_title FROM employees e 
JOIN jobs j ON e.job_id = j.job_id WHERE employee_id = 120;

SELECT employee_id, first_name || ' ' || last_name AS 이름, job_id, job_title FROM employees
WHERE jo

SELECT employee_id, first_name || ' ' || last_name AS 이름, job_id,
(SELECT job_title FROM jobs WHERE job_id = job_id) AS job_title
FROM employees WHERE employee_id = 120;
--Q14. HR EMPLOYEES 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
SELECT first_name || ' ' || last_name AS NAME FROM employees;

--Q15. HR EMPLOYEES 테이블에서 근속기간이 10년 이상인 직원을 포함하는 뷰를 생성하세요.
CREATE VIEW "long_worker" AS
SELECT employee_id, first_name || ' ' || last_name AS 이름, trunc((sysdate - hire_date) / 365) AS 근속기간 
FROM employees WHERE trunc((sysdate - hire_date) / 365) >= 10;

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--SELECT job_id FROM employees WHERE '|_%A' escape '_A';
SELECT * FROM employees WHERE job_id LIKE '%|_A%' escape '|'; 

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
SELECT employee_id, last_name, salary FROM employees ORDER BY salary, last_name;
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
SELECT e.employee_id, e.first_name, e.last_name, e.department_id, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id WHERE e.last_name = 'Seo' OR e.first_name = 'Seo';

SELECT department_name FROM departments WHERE department_id = (SELECT department_id FROM employees WHERE last_name = 'Seo');

--Q19. JOB ID 별 몇년차는 얼마 받는지 각 년차별로 샐러리 평균을 구하세요.
SELECT job_id, ROUND(AVG(salary), 1) AS 평균, trunc((sysdate - hire_date) / 365) AS 년차 FROM employees 
GROUP BY job_id, trunc((sysdate - hire_date) / 365) ORDER BY job_id DESC;

SELECT job_id, 연차, round(avg(salary)) 평균급여
FROM (SELECT job_id, floor(months_between(sysdate, hire_date) / 12) as 연차, salary FROM employees) GROUP BY job_id, 연차 ORDER BY job_id DESC;

--Q20. HR EMPLOYEES 테이블에서 salary가 20000 이상이면 'a', 10000과 20000 미만 사이면 'b', 그 이하면 'c'로 표시하는 쿼리를 
--작성하시오.(case)
SELECT last_name, salary,
    CASE
        WHEN salary >= 20000 THEN 'a'
        WHEN salary < 20000 AND salary >= 10000 THEN 'b'
    ELSE 'c'
    END AS 등급
FROM employees;


--Q21. 학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.(20점)
--[실습 - 2인 1조]
--학교관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.
drop table departments;
drop table professors;
drop table students;
drop table Academic_Warning


CREATE TABLE departments (
    dpid NUMBER PRIMARY KEY,
    dpname VARCHAR2(100) NOT NULL
);

CREATE TABLE professors (
    pfid NUMBER PRIMARY KEY,
    pfname VARCHAR2(100) NOT NULL,
    pfaddress VARCHAR2(200),
    pfphone VARCHAR2(20),
    pfemail VARCHAR2(100),
    pfmajor VARCHAR2(100),
    pfcareer VARCHAR2(200),
    dpid NUMBER,
    FOREIGN KEY (dpid) REFERENCES departments(dpid) ON DELETE CASCADE
);

CREATE TABLE students (
    stid NUMBER PRIMARY KEY,
    stname VARCHAR2(100) NOT NULL,
    staddress VARCHAR2(200),
    stphone VARCHAR2(20),
    stemail VARCHAR2(100),
    stmajor VARCHAR2(100),
    stminor VARCHAR2(100),
    stgpa NUMBER,
    stcircle VARCHAR2(100),
    dpid NUMBER,
    FOREIGN KEY (dpid) REFERENCES departments(dpid) ON DELETE CASCADE
);

--CREATE TABLE Academic_Warning (
--    awid NUMBER PRIMARY KEY,
--    awname VARCHAR2(100) NOT NULL,
--    awaddress VARCHAR2(200),
--    awphone VARCHAR2(20),
--    awemail VARCHAR2(100),
--    awmajor VARCHAR2(100),
--    awminor VARCHAR2(100),
--    awgpa NUMBER,
--    awmeeting DATE,
--    FOREIGN KEY (awid) REFERENCES students(stid) ON DELETE CASCADE
--);

-- 학과 데이터
INSERT INTO departments (dpid, dpname) VALUES (1, 'Computer Science');
INSERT INTO departments (dpid, dpname) VALUES (2, 'Mathematics');
INSERT INTO departments (dpid, dpname) VALUES (3, 'Physics');
INSERT INTO departments (dpid, dpname) VALUES (4, 'Chemistry');
INSERT INTO departments (dpid, dpname) VALUES (5, 'Biology');
INSERT INTO departments (dpid, dpname) VALUES (6, 'Engineering');
INSERT INTO departments (dpid, dpname) VALUES (7, 'Economics');
INSERT INTO departments (dpid, dpname) VALUES (8, 'English');
INSERT INTO departments (dpid, dpname) VALUES (9, 'History');
INSERT INTO departments (dpid, dpname) VALUES (10,'Psychology');

-- 교수 데이터
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (1, 'John Doe', '123 Main St', '555-1234', 'john@example.com', 'Computer Science', '5 years', 1);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (2, 'Jane Smith', '456 Elm St', '555-5678', 'jane@example.com', 'Mathematics', '8 years', 2);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (3, 'Michael Johnson', '789 Oak St', '555-9012', 'michael@example.com', 'Physics', '3 years', 3);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (4, 'Emily Brown', '234 Maple St', '555-3456', 'emily@example.com', 'Chemistry', '10 years', 4);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (5, 'William Taylor', '567 Pine St', '555-7890', 'william@example.com', 'Biology', '6 years', 5);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (6, 'Sophia Wilson', '890 Cedar St', '555-2345', 'sophia@example.com', 'Engineering', '4 years', 6);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (7, 'Alexander Anderson', '123 Elm St', '555-6789', 'alexander@example.com', 'Economics', '7 years', 7);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (8, 'Olivia Martinez', '456 Oak St', '555-0123', 'olivia@example.com', 'English', '9 years', 8);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (9, 'Daniel Hernandez', '789 Maple St', '555-4567', 'daniel@example.com', 'History', '2 years', 9);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (10, 'Isabella Lopez', '234 Cedar St', '555-8901', 'isabella@example.com', 'Psychology', '5 years', 10);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (11, 'Sophie Baker', '789 Oak St', '555-2345', 'sophie@example.com', 'Economics', ' 2years', 7);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (12, 'Andrew Thompson', '456 Pine St', '555-6789', 'andrew@example.com', 'English', '3 years', 8);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (13, 'David Lee', '123 Elm St', '555-3456', 'david@example.com', 'Computer Science', '10 years', 1);
INSERT INTO professors (pfid, pfname, pfaddress, pfphone, pfemail, pfmajor, pfcareer, dpid) VALUES (14, 'Emily Johnson', '456 Oak St', '555-7890', 'emily@example.com', 'Physics', '7 years', 3);

-- 학생 데이터
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (1, 'Ethan Thomas', '123 Main St', '555-1234', 'ethan@example.com', 'Computer Science', 'None', 3.5, 'Chess Club', 1);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (2, 'Sophia White', '456 Elm St', '555-5678', 'sophia@example.com', 'Mathematics', 'None', 1.8, 'Soccer Club', 2);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (3, 'James Harris', '789 Oak St', '555-9012', 'james@example.com', 'Physics', 'None', 3.9, 'Soccer Club', 3);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (4, 'Ava Martin', '234 Maple St', '555-3456', 'ava@example.com', 'Chemistry', 'None', 3.6, 'Art Club', 4);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (5, 'Mia King', '567 Pine St', '555-7890', 'mia@example.com', 'Biology', 'None', 1.7, 'Art Club', 5);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (6, 'Noah Young', '890 Cedar St', '555-2345', 'noah@example.com', 'Engineering', 'None', 3.4, 'Soccer Club', 6);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (7, 'Emma Lee', '123 Elm St', '555-6789', 'emma@example.com', 'Economics', 'None', 3.3, 'Economics Club', 7);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (8, 'Liam Clark', '456 Oak St', '555-0123', 'liam@example.com', 'English', 'History', 1.2, 'Science Club', 8);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (9, 'Avery Hernandez', '789 Maple St', '555-4567', 'avery@example.com', 'History', 'English', 3.1, 'Chess Club', 9);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (10, 'Charlotte Garcia', '234 Cedar St', '555-8901', 'charlotte@example.com', 'Psychology', 'Sociology', 3.0, 'Chess Club', 10);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (11, 'Benjamin Evans', '567 Willow St', '555-1111', 'benjamin@example.com', 'Computer Science', 'None', 2.6, 'Art Club', 1);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (12, 'Isabella Nelson', '890 Walnut St', '555-2222', 'isabella@example.com', 'Mathematics', 'None', 3.9, 'Science Club', 2);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (13, 'Oliver Brown', '123 Birch St', '555-3333', 'oliver@example.com', 'Physics', 'None', 3.8, 'Chess Club', 3);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (14, 'Emma Martinez', '456 Cedar St', '555-4444', 'emma@example.com', 'Chemistry', 'None', 1.7, 'Science Club', 4);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (15, 'Lucas Wilson', '789 Spruce St', '555-5555', 'lucas@example.com', 'Biology', 'None', 3.5, 'Biology Club', 5);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (16, 'Mia Davis', '234 Oak St', '555-6666', 'mia@example.com', 'Engineering', 'None', 2.4, 'Art Club', 6);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (17, 'Sophia Clark', '567 Maple St', '555-7777', 'sophia@example.com', 'Economics', 'Statistics', 2.6, 'Economics Club', 7);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (18, 'Jackson Lewis', '890 Pine St', '555-8888', 'jackson@example.com', 'English', 'Philosophy', 3.3, 'Psychology Club', 8);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (19, 'Amelia Walker', '123 Fir St', '555-9999', 'amelia@example.com', 'History', 'Political Science', 3.7, 'Chess Club', 9);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (20, 'Liam Robinson', '456 Aspen St', '555-0000', 'liam@example.com', 'Psychology', 'Sociology', 2.8, 'Psychology Club', 10);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (21, 'Evelyn Young', '789 Cypress St', '555-1010', 'evelyn@example.com', 'Computer Science', 'Physics', 3.9, 'Economics Club', 1);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (22, 'Aiden Scott', '234 Beech St', '555-2020', 'aiden@example.com', 'Mathematics', 'Economics', 1.5, 'Art Club', 2);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (23, 'Charlotte Green', '567 Dogwood St', '555-3030', 'charlotte@example.com', 'Physics', 'Chemistry', 3.6, 'Soccer Club', 3);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (24, 'Harper Carter', '890 Hawthorn St', '555-4040', 'harper@example.com', 'Chemistry', 'None', 1.4, 'Art Club', 4);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (25, 'Henry Allen', '123 Holly St', '555-5050', 'henry@example.com', 'Biology', 'None', 3.8, 'Soccer Club', 5);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (26, 'Ella King', '456 Juniper St', '555-6060', 'ella@example.com', 'Engineering', 'None', 2.7, 'Soccer Club', 6);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (27, 'James Hill', '789 Magnolia St', '555-7070', 'james@example.com', 'Economics', 'None', 2.3, 'Soccer Club', 7);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (28, 'Abigail Baker', '234 Poplar St', '555-8080', 'abigail@example.com', 'English', 'None', 3.2, 'Science Club', 8);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (29, 'Benjamin Gonzalez', '567 Redwood St', '555-9090', 'benjamin@example.com', 'History', 'English', 3.1, 'Soccer Club', 9);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (30, 'Chloe Hernandez', '890 Sequoia St', '555-1112', 'chloe@example.com', 'Psychology', 'None', 3.0, 'Art Club', 10);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (31, 'Grace Thompson', '123 Palm St', '555-1113', 'grace@example.com', 'Computer Science', 'None', 3.7, 'Art Club', 1);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (32, 'Jackson Martinez', '456 Willow St', '555-2223', 'jackson@example.com', 'Mathematics', 'None', 3.8, 'Soccer Club', 2);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (33, 'Ava Lee', '789 Birch St', '555-3334', 'ava@example.com', 'Physics', 'None', 3.9, 'Soccer Club', 3);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (34, 'Lucas Perez', '123 Cedar St', '555-4445', 'lucas@example.com', 'Chemistry', 'None', 3.6, 'Soccer Club', 4);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (35, 'Mia Anderson', '456 Pine St', '555-5556', 'mia@example.com', 'Biology', 'Chemistry', 3.5, 'Psychology Club', 5);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (36, 'Ethan Jackson', '789 Oak St', '555-6667', 'ethan@example.com', 'Engineering', 'None', 3.4, 'Soccer Club', 6);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (37, 'Sophia Taylor', '123 Elm St', '555-7778', 'sophia@example.com', 'Economics', 'None', 4.0, 'Psychology Club', 7);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (38, 'Liam Wilson', '456 Spruce St', '555-8889', 'liam@example.com', 'English', 'History', 3.6, 'Soccer Club', 8);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (39, 'Isabella Harris', '789 Maple St', '555-9990', 'isabella@example.com', 'History', 'Political Science', 3.5, 'Chess Club', 9);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (40, 'James Thomas', '123 Redwood St', '555-0001', 'james@example.com', 'Psychology', 'None', 3.4, 'Psychology Club', 10);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (41, 'Olivia Martinez', '456 Dogwood St', '555-1112', 'olivia@example.com', 'Mathematics', 'None', 3.9, 'Soccer Club', 1);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (42, 'Elijah Lopez', '789 Beech St', '555-2223', 'elijah@example.com', 'Mathematics', 'None', 2.8, 'Psychology Club', 2);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (43, 'Emma Garcia', '123 Holly St', '555-3334', 'emma@example.com', 'Physics', 'None', 3.7, 'Psychology Club', 3);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (44, 'Noah Clark', '456 Juniper St', '555-4445', 'noah@example.com', 'Chemistry', 'None', 2.6, 'Soccer Club', 4);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (45, 'Ava Hernandez', '789 Fir St', '555-5556', 'ava@example.com', 'Biology', 'None', 3.5, 'Soccer Club', 5);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (46, 'Oliver Martinez', '123 Poplar St', '555-6667', 'oliver@example.com', 'Engineering', 'None', 3.4, 'Art Club', 6);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (47, 'Charlotte White', '456 Sequoia St', '555-7778', 'charlotte@example.com', 'Economics', 'None', 3.3, 'Psychology Club', 7);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (48, 'Liam Robinson', '789 Aspen St', '555-8889', 'liam@example.com', 'English', 'None', 2.2, 'Soccer Club', 8);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (49, 'Mia Lewis', '123 Cypress St', '555-9990', 'mia@example.com', 'History', 'None', 3.1, 'Science Club', 9);
INSERT INTO students (stid, stname, staddress, stphone, stemail, stmajor, stminor, stgpa, stcircle, dpid) VALUES (50, 'James Young', '456 Palm St', '555-0001', 'james@example.com', 'Psychology', 'None', 3.0, 'Psychology Club', 10);

-- Academic_Warning 데이터
--INSERT INTO Academic_Warning(awid, awname, awaddress, awphone, awemail, awmajor, awminor, awgpa) VALUES (1, 'Mia King', '567 Pine St', '555-7890', 'mia@example.com', 'Biology', 'Chemistry', 1.5);

--UPDATE Academic_Warning SET awmeeting = TO_DATE('2024/6/20', 'YYYY/MM/DD') WHERE awmeeting IS Null;

SELECT * FROM departments;
SELECT * FROM professors;
SELECT * FROM students;

DELETE FROM professors;
DELETE FROM students;

--CASE1 지역별로 버스 운용 (5명 이상인 곳 버스 운행 고려)
SELECT substr(address, 5) AS 공통주소, COUNT(*) AS 명 
FROM (SELECT staddress AS address FROM students UNION ALL SELECT pfaddress AS address FROM professors)
GROUP BY substr(address, 5) HAVING COUNT(*) >= 5 ORDER BY 명 DESC;


--CASE2 장학생과 경고받을 학생의 점수와 학과 한번에 표시
SELECT 
    CASE WHEN stgpa >= 4.0 THEN stname END AS Scholarship,
    CASE WHEN stgpa <= 2.0 THEN stname END AS Warning, stgpa, stmajor FROM students
WHERE stgpa >= 4.0 OR stgpa <= 2.0 ORDER BY stgpa DESC;


--CASE3 전공만 가지고 있는 사람과 부전공도 같이 가지고 있는 사람의 전공 성적비교
SELECT '메이져만 들은 학생' AS "비전공의 유무", ROUND(AVG(stgpa), 2) AS avg_gpa FROM students WHERE stminor = 'None'
UNION ALL
SELECT '메이저와 마이너 둘다 들은 학생' AS "비전공의 유무", ROUND(AVG(stgpa), 2) AS avg_gpa FROM students WHERE stminor != 'None';


--CASE4 동아리별 평균 점수와 인원수를 비교해서 학점이 3.0 이하거나 인원수가 3명 미만인 동아리를 찾는다. (동아리 폐지 경고를 위함)
SELECT stcircle AS "동아리", ROUND(AVG(stgpa),2) AS "평균학점", COUNT(*) AS "동아리 학생 수" FROM students 
GROUP BY stcircle HAVING AVG(stgpa) <= 3.0 OR COUNT(*) < 3;


--CASE5 학과별 평균점수 구해 가장 우수한 학과와 도움이 필요한 학과 찾기
SELECT dpname AS 학과, 학과별평균 FROM departments d JOIN (SELECT stmajor AS 학과, ROUND(AVG(stgpa), 2) AS 학과별평균 FROM students GROUP BY stmajor) s ON d.dpname = s.학과 ORDER BY 학과별평균 DESC;


SELECT stmajor AS 학과, ROUND(AVG(stgpa), 2) AS 학과별평균 FROM students GROUP BY stmajor ORDER BY 학과별평균 DESC;
--SELECT stmajor AS 학과, COUNT(*) AS 명 FROM students GROUP BY stmajor ORDER BY 명 DESC;

--Q22. 다음 실습과제를 수행하세요.(20점)
-- 1. 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요.
-- 2. 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증하세요. 
--[실습]
-- 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개이상으 기술하세요
-- 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데어터에 반영한 후 다시 분석해서 반영 여부를 검증하세요 (옵션)


--Insight_1. 부서별 퇴직자 비율과 평균 근속

Select
    D.department_name 부서명,
    jh.job_id,
    Round(Avg(Months_between(JH.end_date, JH.start_date) / 12), 1) As "퇴직자 평균 근속 년수(년)",
    Count(JH.employee_id) As "퇴직자 수",
    Round((Count(JH.employee_id) / (Select Count(*) From employees)) * 100, 2) As "퇴직자 비율(%)"
From job_history JH
Join departments D ON JH.department_id = D.department_id
Group By JH.department_id, jh.job_id, D.department_name
Order By "퇴직자 수" Desc;



--1. 부서별 및 직업별 퇴직자들의 평균 근속 년수를 파악하여 특정 부서나 직업에서 근속 기간이 짧은 경향이 있는지 확인할 수 있습니다. 
--2. 부서별 및 직업별로 퇴직자 수를 계산하여 어느 부서나 직업에서 퇴직률이 높은지 파악할 수 있습니다. 
--3. 전체 직원 수에 대비한 퇴직자 비율을 계산하여 부서별 퇴직 비율을 비교할 수 있습니다.
--
--기여할수 있는 방면은
--퇴직 원인 분석하여 특정 부서나 직업에서 근속 기간이 짧고 퇴직률이 높은 경우, 그 원인을 분석하여 개선 방안을 모색할 수 있습니다.
--퇴직률이 높은 부서나 직업에 대해 주의 깊게 관찰하고 원인을 분석하여 근무 환경 개선, 보상 제도 재검토 등을 다양한 대응책을 통해 직원들의 만족도를 높일 수 있습니다.
--근속 기간이 짧은 부서나 직업에 대해 미리 파악하여 중요한 인재가 회사를 떠나는 것을 방지할 수 있습니다.
--특정 부서에서 비정상적으로 높은 퇴직률을 보이는 경우 그 부서를 집중적으로 조사하고 필요한 경우 인력 재배치를 통해 업무 효율성과 안정성을 높일 수 있습니다.
--
--이 인사이트는 부서별, 직업별 퇴직자 데이터를 정리하여 추후 회사의 안정성을 높일수 있습니다.



--2. 부서별 평균 임급이랑 직원별 임금 비교
WITH Avgsal AS (
    SELECT 
        department_id, 
        Round(AVG(salary)) AS "부서별 평균 급여",
        Floor(AVG(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)) AS "부서별 평균 경력(년)"
    FROM 
        employees
    GROUP BY 
        department_id
)
SELECT 
    D.department_name AS "부서",
    E.first_name || ' ' || E.last_name AS "이름", 
    E.salary AS "급여", 
    Floor(MONTHS_BETWEEN(SYSDATE, E.hire_date) / 12) AS "경력(년)",
    A."부서별 평균 급여",
    A."부서별 평균 경력(년)"
FROM 
    employees E
JOIN 
    departments D ON E.department_id = D.department_id
JOIN
    Avgsal A ON E.department_id = A.department_id
WHERE 
    E.salary < A."부서별 평균 급여"
ORDER BY 
    D.department_name, E.salary DESC;


--1. 각 부서별로 평균 급여를 계산하고, 개별 직원의 급여가 그 부서의 평균 급여보다 낮은 직원들을 식별합니다.
--2. 각 부서별로 평균 경력을 계산 및 제공하여 경력에 따른 급여 수준을 비교할 수 있습니다 
--3. 경력만이 아니라 평균 급여보다 낮은 급여를 받는 직원들을 부서별로 정렬하여 급여가 부서별 평균보다 낮은 이유를 파악하고 이들에 대해 개별적으로 검토할 수 있습니다.
--
--
--기여 할수 있는 방면은
--평균 급여보다 낮은 급여를 받는 직원들을 식별함으로써 급여 불균형을 파악함으로 부서 내에서의 급여 조정, 승진, 보너스 지급 등의 결정을 할 때 중요한 기준이 될 수 있습니다.
--경력이 많은 직원들 중에서 급여가 낮은 직원들을 식별하여 경력에 따른 보상 체계의 적절성을 평가하고, 필요한 경우 보상 체계를 수정하는 데 도움이 됩니다.  
--    
--이 인사이트는 부서 내 평균급여와 경력별 평균 급여를 정리하여 추후 급여에 따른 직원 만족도와 신뢰도를 높일 수 있습니다





--3. 나라별 부서랑 직무에 몇명 파견되어 있는지 평균급여 근속년수 파악
  
SELECT l.city || ',' || c.country_id 근무지역, d.department_name, count(e.employee_id) 직원수, 
Round(Avg(e.salary), 1) As 평균급여, trunc(avg(months_between(sysdate, e.hire_date) / 12)) as "평균 근속 년수(년)"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN countries c ON c.country_id = l.country_id
GROUP BY l.city, l.city || ',' || c.country_id, d.department_name
ORDER BY 근무지역;

--1. 각 근무지역(도시 및 국가)별로 직원 수, 평균 급여, 평균 근속 년수를 제공합니다.
--2. 각 근무지역과 부서에 대한 상세한 데이터를 제공합니다.

--기여 할수 있는 방면은
--각 지역별로 직원 분포와 평균 급여 수준, 근속 연수를 파악함으로써 지역 간의 인력 분포와 급여에 따른 균형을 파악 할 수 있습니다. 
--특정 지역에 인력이 집중되어 있거나, 급여가 다른 지역에 비해 낮은 경우 이를 조정할 수 있습니다.
--현재 분포 되어 있는 직원수와 직무에 따라 현재 회사가 나아가는 방향을 파악하여 그 지역에 더욱 힘을 실을 수 있습니다
--각 지역과 부서별로 인력 계획을 세우고, 예산을 효과적으로 배분이 가능하여 특정 지역이나 부서에서 인력이 많이 필요할 경우, 그에 맞는 예산을 배정하고, 채용 계획을 수립할 수 있습니다.
--특정 지역이나 부서의 평균 급여를 기준으로 인사 정책을 조정하거나, 인력 배치를 최적화할 수 있습니다.

--이 인사이트는 각 근무지역내 부서와 직원수를 관리하여 추후 지역에 따른 투자나 인력 배치를 최적화 시킬수 있습니다
    
    
    
--4. 세일즈맨별 평가
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS 이름, e.job_id, j.job_title, e.salary, e.commission_pct, 
e.salary * commission_pct as 성과금, e.manager_id, l.city
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON j.job_id = e.job_id
INNER JOIN locations l ON l.location_id = d.location_id WHERE commission_pct is not null;

--현재 이 회사는 판매쪽이 주력이어서 그에 따른 성과금이 보상으로 제공됨
--1. 성과급을 받는 직원들의 직무와 직함 정보, 근무지역 등 상세 정보를 제공합니다.
--2. 직원의 commission_pct에 따른 성과금을 계산합니다.
--3. 성과급 수령 직원들의 근무 지역 정보를 제공합니다. (현재 옥스포드쪽에서 판매중)

--기여 할 수 있는 방면은
--성과급 지급이 직원의 동기 부여와 성과에 어떤 영향을 미치는지 평가할 수 있습니다. 
--성과급이 높은 직원들과 낮은 직원들의 성과를 비교하여, 성과 평가 기준과 효율성을 분석할 수 있습니다.
--특정 지역에서 성과급 수령 직원들이 많이 분포하는지 파악 하여 지역별로 성과급 수령 직원들의 성과와 보상을 분석하여, 지역별 보상 정책을 최적화할 수 있습니다.
--성과급 지급이 특정 직무나 직함에 집중되어 있는지 분석할 수 있습니다. 이를 통해 특정 직무에 대한 보상 체계를 재조정하거나, 성과급 지급 기준을 재검토할 수 있습니다.
--성과에 따라 보너스가 지급되므로, 직원들의 동기 부여와 생산성 향상에 긍정적인 영향을 미칠 수 있습니다.    
--회사 차원에서 성과급에 대한 예산을 효과적으로 관리할 수 있습니다. 성과급 비율을 통해 총 보상 비용을 예측할 수 있습니다.

--이 인사이트는 세일즈맨들을 관리하여 추후 다른 지역에 새로 판매 할 떄의 지표가 되어 효율적으로 예산을 관리 할 수 있습니다



--5. 직업별 평균 salary와 회사내 salary 비교
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS name, e.hire_date, trunc((sysdate - e.hire_date) / 365) AS 근속, 
e.job_id, e.salary, (j.min_salary + j.max_salary) / 2 AS 평균임금 
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY e.job_id;

--전에는 회사내의 부서내 평균 급여였으면 이번에 직업별 평균 급여 비교

--1. 직원별에 대한 기본 정보를 제공합니다. 
--2. 직원의 근속 연수를 파악합니다.
--3. 직원이 담당하는 직무를 식별합니다. 
--4. 직원의 기본 급여를 보여줍니다. 
--5. 해당 직무의 최소 임금과 최대 임금의 평균값을 계산합니다. 
--
--기여 할 수 있는 방면은    
--직원별 정보로 인해 특정 직원에 대한 정보를 쉽게 조회할 수 있습니다.
--각 직무의 평균 임금과 비교하여 직원의 급여 수준을 평가할 수 있습니다. 이는 급여 구조의 공정성을 유지하고, 직원의 만족도를 높이는 데 도움이 됩니다.
--예를 들어 직원의 급여가 평균보다 낮다면 급여 인상을 고려할 수 있고, 반대로 높다면 그 이유를 분석할 수 있습니다
--직무별로 직원의 분포를 분석하여, 특정 직무에 대한 인력 부족이나 과잉을 식별할 수 있습니다. 이를 통해 효율적인 인력 배치를 계획할 수 있습니다.
--각 직원의 급여가 해당 직무의 평균 임금 대비 적절한지 평가할 수 있습니다.
--근속 연수 정보를 통해 만약 해당 인원이 평균 임금 대비 급여가 낮다면 이직 가능성이 높다고 식별하고, 
--필요한 경우 직무의 보상 체계를 재평가 하여 이들의 만족도를 높이기 위한 조치를 취할 수 있습니다.

--이 인사이트는 직원별 임금을 관리하여 이들의 급여와 평균적인 직무별 급여를 비교하여 이에 따라 조정을 하여 추후 직원의 이탈을 막고 
--급여가 낮으면 그 이유를 분석 할 수 있습니다