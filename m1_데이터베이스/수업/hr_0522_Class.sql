Select * from employees order by employee_id;


--Q. ����� 120���� ����� ���, �̸�, ����(job id), ������(job title)�� ���
SELECT E.employee_id ���, E.first_name �̸�, E.last_name ��, E.job_id ����, J.job_title ������
FROM employees E
INNER JOIN jobs J ON E.job_id = J.job_id
WHERE E.employee_id = 120;

-- FIRST_NAME || ' ' || LAST NAME AS �̸� : FIRST NAME�� LAST NAME�� �������� �����Ͽ�
-- �ϳ��� ���ڿ��� ��ġ��, �� ����� ��Ī�� '�̸�'���� ����
SELECT E.employee_id ���, E.first_name || ' ' || E.last_name AS �̸�, E.job_id ����, J.job_title ������
FROM employees E
INNER JOIN jobs J ON E.job_id = J.job_id
WHERE E.employee_id = 120;

--�� �ٸ� ���
SELECT 
E.employee_id ���, 
E.first_name || ' ' || E.last_name AS �̸�, 
E.job_id ����, J.job_title ������
FROM employees E, JOBS J 
WHERE E.employee_id = 120 AND e.job_id = j.job_id;


--Q. 2005�� ��ݱ⿡ �Ի��� ������� �̸�(Full Name)�� ���
SELECT TO_CHAR(hire_date, 'YY/MM') FROM employees;
SELECT first_name || ' ' || last_name AS �̸� 
FROM employees WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';

--Q. _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����ϰ� ���� �� escape �ɼ��� ���
SELECT * FROM employees WHERE job_id LIKE '%|_A%';  -- escape ���� �� ��� �ȵ�
SELECT * FROM employees WHERE job_id LIKE '%|_A%' escape '|';   -- _A�� ���� ���� ��� Ȯ��
SELECT * FROM employees WHERE job_id LIKE '%#_A%' escape '#';   -- # ��� ��� ����
SELECT * FROM employees WHERE phone_number LIKE '%|.%' escape '.';   -- # ��� ��� ����

-- IN : OR ��� ���
SELECT * FROM employees WHERE manager_id = 101 OR manager_id = 102 OR manager_id = 103;
SELECT * FROM employees WHERE manager_id IN (101, 102, 103);

--Q. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
SELECT first_name || ' ' || last_name AS �̸� FROM employees
WHERE job_id IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

-- NULL / IS NOT NULL
-- NULL �������� Ȯ���� ��� = �� �����ڸ� ������� �ʰ� is null�� ����Ѵ�
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

-- ORDER BY
-- ORDER BY �÷��� [ASC | DESC]
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary ASC, last_name DESC;

-- DUAL ���̺�
-- MOD ������
SELECT * FROM employees WHERE MOD(employee_id, 2) = 1; -- Ȧ�� ��ȣ ã��
SELECT mod(10, 3) FROM DUAL; -- 10�� 3���� ������ ���� ������ 1

-- ROUND() �ݿø� �Լ�
SELECT ROUND(355.95555) FROM DUAL; -- 356
SELECT ROUND(355.95555, 2) FROM DUAL; --355.96
SELECT ROUND(355.95555, -2) FROM DUAL; --400

-- Trunc() ���� �Լ�, ������ �ڸ��� ���ϸ� ���� ��� ����
SELECT trunc(45.5555, 1) FROM DUAL; --45.5

-- ceil() ������ �ø�
SELECT ceil(45.111) FROM DUAL; -- 46
SELECT ceil(45.777) FROM DUAL; -- 46

--Q. HR_EMPLOYEES ���̺��� �̸�, �޿�, 10% �λ�� �޿��� ����ϼ���
SELECT last_name �̸�, salary �޿�, salary*1.1 "�λ�� �޿�" FROM employees;

--Q. EMPLOYEES_ID�� Ȧ���� ������ employee_id �� last_name�� ����ϼ���
SELECT employee_id �����ȣ, last_name �̸� FROM employees WHERE mod(employee_id, 2) = 1;
-- �Ǵ� �̷��Ե� ������
SELECT employee_id �����ȣ, last_name �̸� FROM employees 
WHERE employee_id IN(SELECT employee_id FROM employees WHERE mod(employee_id, 2) = 1);

--Q. EMPLOYEES ���̺��� commission_pct �� NULL�� ������ ����ϼ���
SELECT COUNT(*) FROM employees WHERE commission_pct is Null;
SELECT COUNT(*) FROM employees WHERE commission_pct is not Null;

--Q. EMPLOYEES ���̺��� department_id�� ���� ������ �����Ͽ� Position�� '����'���� ����ϼ��� (position�̶�� �� �߰�)
SELECT employee_id, first_name || ' ' || last_name AS �̸�, '����' AS position FROM employees 
WHERE department_id is Null;

--Q. HR EMPLOYEES ���̺��� salary, last name ������ �ø����� �����Ͽ� ���
SELECT * FROM employees ORDER BY salary, last_name;

-- ��¥ ����
SELECT sysdate FROM dual;
SELECT sysdate + 1 FROM dual;
SELECT sysdate - 1 FROM dual;

-- �ٹ��� ��¥ ���
SELECT last_name, sysdate, hire_date, trunc(sysdate - hire_date) AS �ٹ��Ⱓ FROM employees;

-- ADD_MONTHS() : Ư�� ���� ���� ���� ��¥�� ���Ѵ�
SELECT last_name, hire_date, add_months(hire_date, 6) revised_date FROM employees;

-- last_day()   : �ش� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
SELECT last_name, hire_date, last_day(hire_date) FROM employees;
SELECT last_name, hire_date, last_day(add_months(hire_date, 1)) FROM employees;

-- next_day()   : �ش� ��¥�� �������� ������ ���Ͽ� �ش��ϴ� ��¥�� ��ȯ
-- �� ~ ������� 1 - 7�� ǥ������ (�� = 1, �� = 2 ... �� = 7)
SELECT hire_date, next_day(hire_date, '��') FROM employees;
SELECT hire_date, next_day(hire_date, 2) FROM employees;

-- months_between()  : ��¥�� ��¥ ������ �������� ���Ѵ�
SELECT hire_date, round(months_between(sysdate, hire_date), 1) FROM employees;

-- to_date()    : �� ��ȯ �Լ� / ���ڿ��� ��¥��
-- '2023-01-01'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ
SELECT to_date('2023-01-01', 'YYYY-MM-DD') FROM dual;

-- to_char()    : ��¥�� ���ڷ� ��ȯ
SELECT to_char(sysdate, 'yy/mm/dd') FROM dual;

--����
--YYYY       �� �ڸ� ����
--YY      �� �ڸ� ����
--YEAR      ���� ���� ǥ��
--MM      ���� ���ڷ�
--MON      ���� ���ĺ�����
--DD      ���� ���ڷ�
--DAY      ���� ǥ��
--DY      ���� ��� ǥ��
--D      ���� ���� ǥ��
--AM �Ǵ� PM   ���� ����
--HH �Ǵ� HH12   12�ð�
--HH24      24�ð�
--MI      ��
--SS      ��

--Q. ���糯¥(sysdate)�� 'yyyy/mm/dd' ������ ���ڿ��� ��ȯ�ϼ���
SELECT to_char(sysdate, 'yyyy/mm/dd') From dual;

--Q. '01-01-2023'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ�ϼ���
SELECT to_date('01-01-2023', 'mm-dd-yyyy') FROM dual;

--Q. ���� ��¥�� �ð�(sysdate)�� 'yyyy-mm-dd hh:mi:ss' �������� ��ȯ�ϼ���
SELECT to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') FROM dual;

--Q. '2023-01-01 15:30:00'�̶�� ���ڿ��� ��¥ �� �ð� Ÿ������ ��ȯ�ϼ���
SELECT to_date('2023-01-01 15:30:00', 'yyyy-mm-dd hh24:mi:ss') FROM dual; --23/01/01 �����µ� sql���� ����������

--to_char( ���� )   ���ڸ� ���ڷ� ��ȯ
--9      �� �ڸ��� ���� ǥ��      ( 1111, ��99999�� )      1111   
--0      �� �κ��� 0���� ǥ��      ( 1111, ��099999�� )      001111
--$      �޷� ��ȣ�� �տ� ǥ��      ( 1111, ��$99999�� )      $1111
--.      �Ҽ����� ǥ��         ( 1111, ��99999.99�� )      1111.00
--,      Ư�� ��ġ�� , ǥ��      ( 1111, ��99,999�� )      1,111
--MI      �����ʿ� - ��ȣ ǥ��      ( 1111, ��99999MI�� )      1111-
--PR      �������� <>�� ǥ��      ( -1111, ��99999PR�� )      <1111>
--EEEE      ������ ǥ��         ( 1111, ��99.99EEEE�� )      1.11E+03
--V      10�� n�� ���Ѱ����� ǥ��   ( 1111, ��999V99�� )      111100
--B      ������ 0���� ǥ��      ( 1111, ��B9999.99�� )      1111.00
--L      ������ȭ         ( 1111, ��L9999�� )

SELECT salary, to_char(salary, '0999999') FROM employees;
SELECT salary, to_char( -salary, '999999PR') FROM employees;

--1111 -> 1.11E+03
SELECT to_char(11111, '9.99EEEE') FROM dual;
SELECT to_char(-1111111, '9999999MI') FROM dual;

-- width_bucker()   : (������, �ּҰ�, �ִ밪, bucket ����)
SELECT width_bucket(92, 0 , 100, 10) FROM dual; -- 10���� ������ �� 92���� ����� ���Ͽ� ������? 10
SELECT width_bucket(100, 0, 100, 10) FROM dual; -- 10���� ������ �� 100�� 11���� ���� (100�� ������ �ȵȴ�) 0 - 9���� 10��

--Q. Salary 5���� �����غ���
SELECT last_name, salary, width_bucket(salary, 2100, 24001, 5) AS grade FROM employees order by grade;

-- ���� �Լ� Character Function
-- upper()  : �빮�ڷ� ����
SELECT upper('Hello World') FROM dual;
-- lower()  : �ҹ��ڷ� ����
SELECT lower('Hello World') FROM dual;

--Q. last name�� seo�� ������ last name �� salary�� ���Ͻÿ� (seo, SEO, Seo ��� ����)
SELECT last_name, salary FROM employees WHERE lower(last_name) = 'seo';

-- initcap()    : ù ���ڸ� �빮��
SELECT job_id, initcap(job_id) FROM employees;

-- length() : ���ڿ� ����
SELECT job_id, length(job_id) FROM employees;

-- instr()  : (���ڿ�, ã�� ����, ���� ��ġ, ã�� ���� �� �� ����)
SELECT instr('Hello World', 'o', 3, 2) FROM dual;   --SQL������ �ε����� 1���� ���� 0�� �ƴ�
SELECT instr('Hello World', 'W', 1, 1) FROM dual;   --��ҹ��� ���еǼ� ��Ȯ�� ���ڸ� �־�� ��
SELECT instr('Hello wreld', 'e', 1, 1) FROM dual;   --���� ��ġ Ȯ��

-- substr() : (���ڿ�, ������ġ, ����)
SELECT substr('Hello World', 3, 3) FROM dual;
SELECT substr('Hello World', 7, 9) FROM dual;
SELECT substr('Hello World', -1, 3) FROM dual; -- ������ġ�� -1�Ͻ� ������ ù�������� ����
SELECT substr('Hello World', -5, 5) FROM dual; -- �ڿ��� ���������� ���������� ���� ��

-- lpad()   : ������ ���� �� ���ʿ� ���ڸ� ä��� (���ڿ�, �� ���� ���ڰ���, ���� ��)
SELECT lpad('Hello World', 20, '#') FROM dual;

-- rpad()   : ���� ���� �� �����ʿ� ���ڸ� ä���
SELECT rpad('Hello World', 20, '$') FROM dual;

-- ltrim()  : ���� ���� ���ش� ���� (���ڿ�, '���� ����) �̷��� �ϸ� ���ʿ� �ִ� ���� ������
SELECT ltrim('aaaaHello Worldaaaa', 'a') FROM dual; -- a ������
SELECT ltrim('     Hello World      ') FROM dual;   -- ���� ���鸸 ������


-- rtrim()  : ������ ���� ���ش� / ���� (���ڿ�, '���� ����)
SELECT rtrim('aaaaHello Worldaaaa', 'a') FROM dual; -- a ������
SELECT rtrim('     Hello World      ') FROM dual;   -- ���� ���鸸 ������

-- trim() : ���� ������
SELECT trim('a' FROM 'aaaaHello Worldaaaa') FROM dual; -- ���� a ������
SELECT trim('     Hello World      ') FROM dual;   -- ���� ���� ������

-- �� ���� Ư�� ���� ����
SELECT last_name, trim('A' FROM last_name) FROM employees;

-- nvl()    : null�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϴ� �Լ�
SELECT last_name, manager_id, nvl(to_char(manager_id), 'CEO') FROM employees;


--decode()    if���̳� case���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
--DECODE �Լ��� �ܼ��� ���ǿ� ����Ͽ� ���� ��ȯ�մϴ�. ������ DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--���⼭ expression�� �˻��� ���� ��Ÿ����, search�� result�� ���� ���ǰ� �ش� ������ ���� �� ��ȯ�� ��
--default�� ��� search ������ ������ �� ��ȯ�� �⺻ �� ���
SELECT last_name, department_id, 
decode(department_id, 
        90, '�濵������', 
        60, '���α׷���',
        100,'�λ��', '��Ÿ') �μ�
FROM employees;

--Q. employees ���̺��� commission_pct�� null�� �ƴ� ���, 'A' null�� ��� 'N'�� ǥ���ϴ� ������ �ۼ�
SELECT commission_pct as commission
    , decode(commission_pct, null, 'N', 'A') as ��ȯ
FROM employees ORDER BY ��ȯ DESC;


--case()
--decode() �Լ��� �����ϳ� decode() �Լ��� �ܼ��� ���� �񱳿� ���Ǵ� �ݸ�
--case() �Լ��� �پ��� �񱳿����ڷ� ������ ������ �� �ִ�.
--CASE ���� ���ǿ� ���� �ٸ� ���� ��ȯ�ϴ� �� ���Ǹ�, DECODE���� ������ ������ ǥ���� �� �ִ�. 
--������ CASE WHEN condition THEN result ... ELSE default END�̴�
SELECT last_name, department_id,
CASE 
    WHEN department_id = 90 THEN '�濵������'
    WHEN department_id = 60 THEN '���α׷���'
    WHEN department_id = 100 THEN '�λ��'
    ELSE '��Ÿ'
    END AS �Ҽ�
FROM employees;

--Q. employees ���̺��� salary�� 20000 �̻��̸� 'A', 10000�� 20000 �̸� ���̸� 'B', �� ���ϸ� 'C'�� ǥ���ϴ� ����
SELECT last_name, salary,
CASE 
    WHEN salary >= 20000 THEN 'A'
    WHEN salary >= 10000 AND salary <= 20000 THEN 'B'
    ELSE 'C'
    END AS ���
FROM employees ORDER BY ���;

--INSERT
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);


-- Concatenation : �޸� ��ſ� ����ϸ� ���ڿ��� ����Ǿ� ��µȴ�
SELECT last_name, 'is a', job_id FROM employees;
SELECT last_name || 'is a' || job_id FROM employees;


-- UNION (������), INTERSECT(������), MINUS(������), UNION ALL(��ġ�� �ͱ��� ����)
-- �� ���� �������� ����ؾ��Ѵ�. ������ Ÿ���� ��ġ ���Ѿ��Ѵ�

-- UNION
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
WHERE salary < 5000
UNION
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
WHERE hire_date < '05/01/01';

-- MINUS
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
WHERE salary < 5000
MINUS
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
WHERE hire_date < '05/01/01';

-- INTERSECT
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
WHERE salary < 5000
INTERSECT
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
WHERE hire_date < '05/01/01';

--UNION ALL
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
WHERE salary < 5000
UNION ALL
SELECT first_name �̸�, salary �޿�, hire_date FROM employees
WHERE hire_date < '05/01/01';


--CREATE VIEW ��ɾ�� ����Ŭ SQL���� ���̺��� Ư�� �κ��̳� ���ε� ����� ������ ��(view)�� ���� �� ���
--��� �����͸� ����ϰų� ������ ������ �ܼ�ȭ�ϸ�, ����ڿ��� �ʿ��� �����͸��� �����ִ� �� ����
--��� ���� ���̺� �����͸� �������� �ʰ�, ��� ���� ����� ����
--���� �ֿ� Ư¡
--���� �ܼ�ȭ: ������ ������ ��� ���������ν� ����ڴ� ������ �������� �ݺ��ؼ� �ۼ��� �ʿ� ���� �����ϰ� �並 ������ �� �ִ�.
--������ �߻�ȭ: ��� �⺻ ���̺��� ������ ����� ����ڿ��� �ʿ��� �����͸��� ������ �� �־�, ������ �߻�ȭ�� ����.
--���� ��ȭ: �並 ����ϸ� Ư�� �����Ϳ� ���� ������ ������ �� ������, ����ڰ� �� �� �ִ� �������� ������ ������ �� �ִ�.
--������ ���Ἲ ����: �並 ����Ͽ� �����͸� �����ϴ���, �� ��������� �⺻ ���̺��� ������ ���Ἲ ��Ģ�� �������� �ʵ��� ������ �� �ִ�.

CREATE VIEW employee_details AS
SELECT employee_id, last_name, department_id
FROM employees;

SELECT * FROM employee_details;

--Q. employees ���̺��� salary �� 10000�� �̻��� �������� �����ϴ� �� special_employee �� �����ϴ� SQL ��ɹ��� �ۼ��ϼ���
CREATE VIEW special_employee AS
SELECT last_name, salary
FROM employees WHERE salary >= 10000;
SELECT * FROM special_employee;

--Q. employees ���̺��� �� �μ��� �������� �����ϴ� �並 �����ϼ���
CREATE VIEW count_employee AS
SELECT department_id, count(*) AS �μ���_������
FROM employees GROUP BY department_id ORDER BY �μ���_������;
SELECT * FROM count_employee;

--Q. employees ���̺��� �ټӱⰣ�� 10�� �̻��� ������ �����ϴ� �並 �����ϼ���
CREATE VIEW workday_employee AS
SELECT last_name, trunc(sysdate - hire_date) as �ټӱⰣ FROM employees
WHERE trunc(sysdate - hire_date) > 365 * 10;
SELECT * FROM workday_employee;

--TCL (Transaction Control Language)
--COMMIT: ���� Ʈ����� ������ ����� ��� ����(INSERT, UPDATE, DELETE ��)�� �����ͺ��̽��� ���������� ����.
--COMMIT ����� �����ϸ�, Ʈ������� �Ϸ�Ǹ�, �� ���Ŀ��� ���� ������ �ǵ��� �� ����.
--ROLLBACK: ���� Ʈ����� ������ ����� ������� ����ϰ�, �����ͺ��̽��� Ʈ������� �����ϱ� ���� ���·� �ǵ�����. 
--������ �߻��߰ų� �ٸ� ������ Ʈ������� ����ؾ� �� ��쿡 ���ȴ�.
--SAVEPOINT: Ʈ����� ������ �߰� üũ����Ʈ�� �����մϴ�. ������ �߻��� ���, ROLLBACK�� ����Ͽ� �ֱ��� SAVEPOINT���� �ǵ��� �� �ִ�.
--Ʈ������� ��Ʈ���ϴ� TCL(TRANSACTION CONTROL LANGUAGE)

DROP TABLE members;
CREATE TABLE members (
        member_id NUMBER PRIMARY KEY,
        name VARCHAR2(100),
        email VARCHAR2(100),
        join_date DATE,
        status VARCHAR2(20)
);

INSERT INTO members (member_id, name, email, join_date, status) VALUES (1, 'John Doe', 'john@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (2, 'Jane Doe', 'jane@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (3, 'Mike Smith', 'mike@example.com', SYSDATE, 'Inactive');

SELECT * FROM members;

INSERT INTO members (member_id, name, email, join_date, status) VALUES (4, 'Alice Johnson', 'alice@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (5, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (6, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

SAVEPOINT spl;
INSERT INTO members (member_id, name, email, join_date, status) VALUES (7, 'Richard GEKO', 'richard@example.com', SYSDATE, 'Inactive');

rollback to spl;
commit;


-- ����
--�μ��� �޿� ��Ȳ
--���̺����, �μ��� �޿��� �� �޿��� Ȯ�� �� �� ����.
--(�޿��� �� ��� �ּڰ� �ִ�, �� ������, �޿���ü����, ������ձ޿�, �μ���ձ޿�)
--table ����� �μ��� �޿��� �뷫������ ����
--����� ���̺� Ȯ��
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--�μ� ��� Ȯ��
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- �μ� ��� department_id : 10,20,30,40,50,60,70,80,90,100,110 �� �� ������(120~200��..)�� ���� null ���� ����.
--department_id �� null �� ����� ��� job_id �� �´� department_id �� �ο����ַ�����(������ ���Ἲ)
--1. department_id �� null ���� ��� ã��
select *
from employees
where department_id IS NULL;
--�Ѹ� �ۿ� ����. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id �� SA_REP �� department_id ã�� (������ �´� �μ� ã��)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP �� department_id �� 80

--3. ���� �� savepoint ����
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. ��������primary key �� employee_id �� ã�Ƽ� derpartment_id �� 80���� ����
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint�� ����
--commit;
--������


--INSIGHT ����

-- ������ �� ������ ������
-- �� �μ����� ������ ����̰� � �����ǵ��� �ְ� ������ ��� �Ǵ���
-- ROLL UP�� ���������� ���� ����� ���� : ��� �� �μ� �� ������ �������� ����
SELECT e.department_id, d.department_name, nvl(e.job_id, 'Total') job_id, count(*) ������ FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id
GROUP BY ROLLUP((e.department_id, d.department_name), e.job_id)
ORDER BY e.department_id;


-- JOB ID �� ������� �� �޴� �� �� �������� ������ ���
SELECT job_id, ����, round(avg(salary)) ��ձ޿�
FROM (SELECT job_id, floor(months_between(sysdate, hire_date)/12) as ����, salary FROM employees)
GROUP BY job_id, ����
ORDER BY job_id, ����;