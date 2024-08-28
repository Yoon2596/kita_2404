������� : �����ͺ��̽� ���� �� Ȱ��

- ���� : 24.05.24
- ���� :  ������
- ���� :

�� HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)�� Ȱ���Ͽ� ���� �������� �����ϼ���.
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;

--Q1. EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
SELECT first_name || ' ' || last_name AS �̸�, salary AS ����, salary * 1.1 AS �λ��_���� FROM employees;
    
--Q2. EMPLOYEES ���̺��� 2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
SELECT first_name || ' ' || last_name AS �̸�, hire_date FROM employees WHERE to_char(hire_date, 'yy/mm') BETWEEN '05/01' AND '05/06';

--Q3. EMPLOYEES ���̺��� ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
SELECT first_name || ' ' || last_name AS �̸�, job_id FROM employees WHERE job_id IN ('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. EMPLOYEES ���̺��� manager_id �� 101���� 103�� ����� ���
SELECT first_name || ' ' || last_name AS �̸�, manager_id FROM employees WHERE manager_id BETWEEN 101 AND 103;

--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
SELECT last_name, hire_date, add_months(hire_date, 6) FROM employees;
SELECT last_name, hire_date, next_day(add_months(hire_date, 6), '��') "TARGET" FROM employees;
--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
SELECT employee_id, last_name, salary, hire_date, trunc(months_between(sysdate, hire_date)) AS W_MONTH FROM employees ORDER BY W_MONTH DESC;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
SELECT employee_id, last_name, salary, hire_date, trunc((sysdate - hire_date) / 365) AS W_YEAR FROM employees ORDER BY W_YEAR DESC;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
SELECT employee_id, last_name FROM employees WHERE MOD(employee_id, 2) = 1;

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
SELECT employee_id, last_name, ROUND(salary / 12, 2) AS M_SALARY FROM employees;

--Q10. employees ���̺��� salary�� 10000�� �̻��� �������� �����ϴ� �� special_employee�� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�.
CREATE VIEW "special_employee" AS
SELECT employee_id, first_name || ' ' || last_name AS �̸�, salary FROM employees WHERE salary >= 10000;
SELECT * FROM special_employee;

--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
SELECT commission_pct, count(*) AS �� FROM employees GROUP BY commission_pct;
SELECT count(*) AS �� FROM employees WHERE commission_pct IS NULL;

--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
SELECT employee_id, first_name || ' ' || last_name AS �̸�, '����' AS POSITION FROM employees WHERE department_id IS NULL;
SELECT employee_id, first_name || ' ' || last_name AS �̸�, nvl(to_char(department_id), '����') AS position FROM employees WHERE department_id IS NULL;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS �̸�, e.job_id, j.job_title FROM employees e 
JOIN jobs j ON e.job_id = j.job_id WHERE employee_id = 120;

SELECT employee_id, first_name || ' ' || last_name AS �̸�, job_id, job_title FROM employees
WHERE jo

SELECT employee_id, first_name || ' ' || last_name AS �̸�, job_id,
(SELECT job_title FROM jobs WHERE job_id = job_id) AS job_title
FROM employees WHERE employee_id = 120;
--Q14. HR EMPLOYEES ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
SELECT first_name || ' ' || last_name AS NAME FROM employees;

--Q15. HR EMPLOYEES ���̺��� �ټӱⰣ�� 10�� �̻��� ������ �����ϴ� �並 �����ϼ���.
CREATE VIEW "long_worker" AS
SELECT employee_id, first_name || ' ' || last_name AS �̸�, trunc((sysdate - hire_date) / 365) AS �ټӱⰣ 
FROM employees WHERE trunc((sysdate - hire_date) / 365) >= 10;

--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--SELECT job_id FROM employees WHERE '|_%A' escape '_A';
SELECT * FROM employees WHERE job_id LIKE '%|_A%' escape '|'; 

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
SELECT employee_id, last_name, salary FROM employees ORDER BY salary, last_name;
   
--Q18. Seo��� ����� �μ����� ����ϼ���.
SELECT e.employee_id, e.first_name, e.last_name, e.department_id, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id WHERE e.last_name = 'Seo' OR e.first_name = 'Seo';

SELECT department_name FROM departments WHERE department_id = (SELECT department_id FROM employees WHERE last_name = 'Seo');

--Q19. JOB ID �� ������� �� �޴��� �� �������� ������ ����� ���ϼ���.
SELECT job_id, ROUND(AVG(salary), 1) AS ���, trunc((sysdate - hire_date) / 365) AS ���� FROM employees 
GROUP BY job_id, trunc((sysdate - hire_date) / 365) ORDER BY job_id DESC;

SELECT job_id, ����, round(avg(salary)) ��ձ޿�
FROM (SELECT job_id, floor(months_between(sysdate, hire_date) / 12) as ����, salary FROM employees) GROUP BY job_id, ���� ORDER BY job_id DESC;

--Q20. HR EMPLOYEES ���̺��� salary�� 20000 �̻��̸� 'a', 10000�� 20000 �̸� ���̸� 'b', �� ���ϸ� 'c'�� ǥ���ϴ� ������ 
--�ۼ��Ͻÿ�.(case)
SELECT last_name, salary,
    CASE
        WHEN salary >= 20000 THEN 'a'
        WHEN salary < 20000 AND salary >= 10000 THEN 'b'
    ELSE 'c'
    END AS ���
FROM employees;


--Q21. �б� ������ ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��.(20��)
--[�ǽ� - 2�� 1��]
--�б������� ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��.
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

-- �а� ������
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

-- ���� ������
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

-- �л� ������
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

-- Academic_Warning ������
--INSERT INTO Academic_Warning(awid, awname, awaddress, awphone, awemail, awmajor, awminor, awgpa) VALUES (1, 'Mia King', '567 Pine St', '555-7890', 'mia@example.com', 'Biology', 'Chemistry', 1.5);

--UPDATE Academic_Warning SET awmeeting = TO_DATE('2024/6/20', 'YYYY/MM/DD') WHERE awmeeting IS Null;

SELECT * FROM departments;
SELECT * FROM professors;
SELECT * FROM students;

DELETE FROM professors;
DELETE FROM students;

--CASE1 �������� ���� ��� (5�� �̻��� �� ���� ���� ���)
SELECT substr(address, 5) AS �����ּ�, COUNT(*) AS �� 
FROM (SELECT staddress AS address FROM students UNION ALL SELECT pfaddress AS address FROM professors)
GROUP BY substr(address, 5) HAVING COUNT(*) >= 5 ORDER BY �� DESC;


--CASE2 ���л��� ������ �л��� ������ �а� �ѹ��� ǥ��
SELECT 
    CASE WHEN stgpa >= 4.0 THEN stname END AS Scholarship,
    CASE WHEN stgpa <= 2.0 THEN stname END AS Warning, stgpa, stmajor FROM students
WHERE stgpa >= 4.0 OR stgpa <= 2.0 ORDER BY stgpa DESC;


--CASE3 ������ ������ �ִ� ����� �������� ���� ������ �ִ� ����� ���� ������
SELECT '�������� ���� �л�' AS "�������� ����", ROUND(AVG(stgpa), 2) AS avg_gpa FROM students WHERE stminor = 'None'
UNION ALL
SELECT '�������� ���̳� �Ѵ� ���� �л�' AS "�������� ����", ROUND(AVG(stgpa), 2) AS avg_gpa FROM students WHERE stminor != 'None';


--CASE4 ���Ƹ��� ��� ������ �ο����� ���ؼ� ������ 3.0 ���ϰų� �ο����� 3�� �̸��� ���Ƹ��� ã�´�. (���Ƹ� ���� ��� ����)
SELECT stcircle AS "���Ƹ�", ROUND(AVG(stgpa),2) AS "�������", COUNT(*) AS "���Ƹ� �л� ��" FROM students 
GROUP BY stcircle HAVING AVG(stgpa) <= 3.0 OR COUNT(*) < 3;


--CASE5 �а��� ������� ���� ���� ����� �а��� ������ �ʿ��� �а� ã��
SELECT dpname AS �а�, �а������ FROM departments d JOIN (SELECT stmajor AS �а�, ROUND(AVG(stgpa), 2) AS �а������ FROM students GROUP BY stmajor) s ON d.dpname = s.�а� ORDER BY �а������ DESC;


SELECT stmajor AS �а�, ROUND(AVG(stgpa), 2) AS �а������ FROM students GROUP BY stmajor ORDER BY �а������ DESC;
--SELECT stmajor AS �а�, COUNT(*) AS �� FROM students GROUP BY stmajor ORDER BY �� DESC;

--Q22. ���� �ǽ������� �����ϼ���.(20��)
-- 1. ���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���.
-- 2. �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ���. 
--[�ǽ�]
-- ���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5���̻��� ����ϼ���
-- �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ��� (�ɼ�)


--Insight_1. �μ��� ������ ������ ��� �ټ�

Select
    D.department_name �μ���,
    jh.job_id,
    Round(Avg(Months_between(JH.end_date, JH.start_date) / 12), 1) As "������ ��� �ټ� ���(��)",
    Count(JH.employee_id) As "������ ��",
    Round((Count(JH.employee_id) / (Select Count(*) From employees)) * 100, 2) As "������ ����(%)"
From job_history JH
Join departments D ON JH.department_id = D.department_id
Group By JH.department_id, jh.job_id, D.department_name
Order By "������ ��" Desc;



--1. �μ��� �� ������ �����ڵ��� ��� �ټ� ����� �ľ��Ͽ� Ư�� �μ��� �������� �ټ� �Ⱓ�� ª�� ������ �ִ��� Ȯ���� �� �ֽ��ϴ�. 
--2. �μ��� �� �������� ������ ���� ����Ͽ� ��� �μ��� �������� �������� ������ �ľ��� �� �ֽ��ϴ�. 
--3. ��ü ���� ���� ����� ������ ������ ����Ͽ� �μ��� ���� ������ ���� �� �ֽ��ϴ�.
--
--�⿩�Ҽ� �ִ� �����
--���� ���� �м��Ͽ� Ư�� �μ��� �������� �ټ� �Ⱓ�� ª�� �������� ���� ���, �� ������ �м��Ͽ� ���� ����� ����� �� �ֽ��ϴ�.
--�������� ���� �μ��� ������ ���� ���� ��� �����ϰ� ������ �м��Ͽ� �ٹ� ȯ�� ����, ���� ���� ����� ���� �پ��� ����å�� ���� �������� �������� ���� �� �ֽ��ϴ�.
--�ټ� �Ⱓ�� ª�� �μ��� ������ ���� �̸� �ľ��Ͽ� �߿��� ���簡 ȸ�縦 ������ ���� ������ �� �ֽ��ϴ�.
--Ư�� �μ����� ������������ ���� �������� ���̴� ��� �� �μ��� ���������� �����ϰ� �ʿ��� ��� �η� ���ġ�� ���� ���� ȿ������ �������� ���� �� �ֽ��ϴ�.
--
--�� �λ���Ʈ�� �μ���, ������ ������ �����͸� �����Ͽ� ���� ȸ���� �������� ���ϼ� �ֽ��ϴ�.



--2. �μ��� ��� �ӱ��̶� ������ �ӱ� ��
WITH Avgsal AS (
    SELECT 
        department_id, 
        Round(AVG(salary)) AS "�μ��� ��� �޿�",
        Floor(AVG(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)) AS "�μ��� ��� ���(��)"
    FROM 
        employees
    GROUP BY 
        department_id
)
SELECT 
    D.department_name AS "�μ�",
    E.first_name || ' ' || E.last_name AS "�̸�", 
    E.salary AS "�޿�", 
    Floor(MONTHS_BETWEEN(SYSDATE, E.hire_date) / 12) AS "���(��)",
    A."�μ��� ��� �޿�",
    A."�μ��� ��� ���(��)"
FROM 
    employees E
JOIN 
    departments D ON E.department_id = D.department_id
JOIN
    Avgsal A ON E.department_id = A.department_id
WHERE 
    E.salary < A."�μ��� ��� �޿�"
ORDER BY 
    D.department_name, E.salary DESC;


--1. �� �μ����� ��� �޿��� ����ϰ�, ���� ������ �޿��� �� �μ��� ��� �޿����� ���� �������� �ĺ��մϴ�.
--2. �� �μ����� ��� ����� ��� �� �����Ͽ� ��¿� ���� �޿� ������ ���� �� �ֽ��ϴ� 
--3. ��¸��� �ƴ϶� ��� �޿����� ���� �޿��� �޴� �������� �μ����� �����Ͽ� �޿��� �μ��� ��պ��� ���� ������ �ľ��ϰ� �̵鿡 ���� ���������� ������ �� �ֽ��ϴ�.
--
--
--�⿩ �Ҽ� �ִ� �����
--��� �޿����� ���� �޿��� �޴� �������� �ĺ������ν� �޿� �ұ����� �ľ������� �μ� �������� �޿� ����, ����, ���ʽ� ���� ���� ������ �� �� �߿��� ������ �� �� �ֽ��ϴ�.
--����� ���� ������ �߿��� �޿��� ���� �������� �ĺ��Ͽ� ��¿� ���� ���� ü���� �������� ���ϰ�, �ʿ��� ��� ���� ü�踦 �����ϴ� �� ������ �˴ϴ�.  
--    
--�� �λ���Ʈ�� �μ� �� ��ձ޿��� ��º� ��� �޿��� �����Ͽ� ���� �޿��� ���� ���� �������� �ŷڵ��� ���� �� �ֽ��ϴ�





--3. ���� �μ��� ������ ��� �İߵǾ� �ִ��� ��ձ޿� �ټӳ�� �ľ�
  
SELECT l.city || ',' || c.country_id �ٹ�����, d.department_name, count(e.employee_id) ������, 
Round(Avg(e.salary), 1) As ��ձ޿�, trunc(avg(months_between(sysdate, e.hire_date) / 12)) as "��� �ټ� ���(��)"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN countries c ON c.country_id = l.country_id
GROUP BY l.city, l.city || ',' || c.country_id, d.department_name
ORDER BY �ٹ�����;

--1. �� �ٹ�����(���� �� ����)���� ���� ��, ��� �޿�, ��� �ټ� ����� �����մϴ�.
--2. �� �ٹ������� �μ��� ���� ���� �����͸� �����մϴ�.

--�⿩ �Ҽ� �ִ� �����
--�� �������� ���� ������ ��� �޿� ����, �ټ� ������ �ľ������ν� ���� ���� �η� ������ �޿��� ���� ������ �ľ� �� �� �ֽ��ϴ�. 
--Ư�� ������ �η��� ���ߵǾ� �ְų�, �޿��� �ٸ� ������ ���� ���� ��� �̸� ������ �� �ֽ��ϴ�.
--���� ���� �Ǿ� �ִ� �������� ������ ���� ���� ȸ�簡 ���ư��� ������ �ľ��Ͽ� �� ������ ���� ���� ���� �� �ֽ��ϴ�
--�� ������ �μ����� �η� ��ȹ�� �����, ������ ȿ�������� ����� �����Ͽ� Ư�� �����̳� �μ����� �η��� ���� �ʿ��� ���, �׿� �´� ������ �����ϰ�, ä�� ��ȹ�� ������ �� �ֽ��ϴ�.
--Ư�� �����̳� �μ��� ��� �޿��� �������� �λ� ��å�� �����ϰų�, �η� ��ġ�� ����ȭ�� �� �ֽ��ϴ�.

--�� �λ���Ʈ�� �� �ٹ������� �μ��� �������� �����Ͽ� ���� ������ ���� ���ڳ� �η� ��ġ�� ����ȭ ��ų�� �ֽ��ϴ�
    
    
    
--4. ������Ǻ� ��
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS �̸�, e.job_id, j.job_title, e.salary, e.commission_pct, 
e.salary * commission_pct as ������, e.manager_id, l.city
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON j.job_id = e.job_id
INNER JOIN locations l ON l.location_id = d.location_id WHERE commission_pct is not null;

--���� �� ȸ��� �Ǹ����� �ַ��̾ �׿� ���� �������� �������� ������
--1. �������� �޴� �������� ������ ���� ����, �ٹ����� �� �� ������ �����մϴ�.
--2. ������ commission_pct�� ���� �������� ����մϴ�.
--3. ������ ���� �������� �ٹ� ���� ������ �����մϴ�. (���� ���������ʿ��� �Ǹ���)

--�⿩ �� �� �ִ� �����
--������ ������ ������ ���� �ο��� ������ � ������ ��ġ���� ���� �� �ֽ��ϴ�. 
--�������� ���� ������� ���� �������� ������ ���Ͽ�, ���� �� ���ذ� ȿ������ �м��� �� �ֽ��ϴ�.
--Ư�� �������� ������ ���� �������� ���� �����ϴ��� �ľ� �Ͽ� �������� ������ ���� �������� ������ ������ �м��Ͽ�, ������ ���� ��å�� ����ȭ�� �� �ֽ��ϴ�.
--������ ������ Ư�� ������ ���Կ� ���ߵǾ� �ִ��� �м��� �� �ֽ��ϴ�. �̸� ���� Ư�� ������ ���� ���� ü�踦 �������ϰų�, ������ ���� ������ ������� �� �ֽ��ϴ�.
--������ ���� ���ʽ��� ���޵ǹǷ�, �������� ���� �ο��� ���꼺 ��� �������� ������ ��ĥ �� �ֽ��ϴ�.    
--ȸ�� �������� �����޿� ���� ������ ȿ�������� ������ �� �ֽ��ϴ�. ������ ������ ���� �� ���� ����� ������ �� �ֽ��ϴ�.

--�� �λ���Ʈ�� ������ǵ��� �����Ͽ� ���� �ٸ� ������ ���� �Ǹ� �� ���� ��ǥ�� �Ǿ� ȿ�������� ������ ���� �� �� �ֽ��ϴ�



--5. ������ ��� salary�� ȸ�系 salary ��
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS name, e.hire_date, trunc((sysdate - e.hire_date) / 365) AS �ټ�, 
e.job_id, e.salary, (j.min_salary + j.max_salary) / 2 AS ����ӱ� 
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY e.job_id;

--������ ȸ�系�� �μ��� ��� �޿������� �̹��� ������ ��� �޿� ��

--1. �������� ���� �⺻ ������ �����մϴ�. 
--2. ������ �ټ� ������ �ľ��մϴ�.
--3. ������ ����ϴ� ������ �ĺ��մϴ�. 
--4. ������ �⺻ �޿��� �����ݴϴ�. 
--5. �ش� ������ �ּ� �ӱݰ� �ִ� �ӱ��� ��հ��� ����մϴ�. 
--
--�⿩ �� �� �ִ� �����    
--������ ������ ���� Ư�� ������ ���� ������ ���� ��ȸ�� �� �ֽ��ϴ�.
--�� ������ ��� �ӱݰ� ���Ͽ� ������ �޿� ������ ���� �� �ֽ��ϴ�. �̴� �޿� ������ �������� �����ϰ�, ������ �������� ���̴� �� ������ �˴ϴ�.
--���� ��� ������ �޿��� ��պ��� ���ٸ� �޿� �λ��� ����� �� �ְ�, �ݴ�� ���ٸ� �� ������ �м��� �� �ֽ��ϴ�
--�������� ������ ������ �м��Ͽ�, Ư�� ������ ���� �η� �����̳� ������ �ĺ��� �� �ֽ��ϴ�. �̸� ���� ȿ������ �η� ��ġ�� ��ȹ�� �� �ֽ��ϴ�.
--�� ������ �޿��� �ش� ������ ��� �ӱ� ��� �������� ���� �� �ֽ��ϴ�.
--�ټ� ���� ������ ���� ���� �ش� �ο��� ��� �ӱ� ��� �޿��� ���ٸ� ���� ���ɼ��� ���ٰ� �ĺ��ϰ�, 
--�ʿ��� ��� ������ ���� ü�踦 ���� �Ͽ� �̵��� �������� ���̱� ���� ��ġ�� ���� �� �ֽ��ϴ�.

--�� �λ���Ʈ�� ������ �ӱ��� �����Ͽ� �̵��� �޿��� ������� ������ �޿��� ���Ͽ� �̿� ���� ������ �Ͽ� ���� ������ ��Ż�� ���� 
--�޿��� ������ �� ������ �м� �� �� �ֽ��ϴ�