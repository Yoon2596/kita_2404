--1. �μ��� ������ ������ ��� �ټ�  
--Insight_1. �� �ٹ�������, ����, ���� ��, ��ձ޿�, ��ձټӳ���� �ľ��մϴ�. 
--
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


--2. �μ��� ��� �ӱ��̶� ������ �ӱ� 
Select 
    D.department_name As "�μ�",
    E.first_name || ' ' || E.last_name As "�̸�", 
    E.salary As "�޿�", 
    trunc(Months_Between(Sysdate, E.hire_date) / 12) As "���(��)",
    Avgsal."�μ��� ��� �޿�",
    Avgsal."�μ��� ��� ���(��)"
From employees E
Join departments D ON E.department_id = D.department_id
Join(Select 
         D.DEPARTMENT_ID, 
         Round(Avg(E.SALARY)) As "�μ��� ��� �޿�",
         Floor(Avg(Months_between(Sysdate, E.HIRE_DATE) / 12)) As "�μ��� ��� ���(��)"
     From 
         employees E
     Join 
         departments D ON E.department_id = D.department_id
     Group By 
         D.department_id) Avgsal On E.department_id = Avgsal.department_id
Where 
    E.salary < Avgsal."�μ��� ��� �޿�"
Order By 
    D.department_name, E.salary Desc, "�޿�";

Select 
    D.department_name As "�μ�",
    E.first_name || ' ' || E.last_name As "�̸�", 
    E.salary As "�޿�", 
    trunc(Months_Between(Sysdate, E.hire_date) / 12) As "���(��)",
    
SELECT ROUND(AVG(salary), 1) AS �μ�����ձ޿� FROM employees GROUP BY department_id;
SELECT trunc(Avg(Months_between(Sysdate, hire_date) / 12))AS �μ�����հ�� FROM employees GROUP BY department_id;

--3. ���� �μ��� ������ ��� �İߵǾ� �ִ��� ��ձ޿� �ټӳ�� �ľ�
SELECT l.city || ',' || c.country_id �ٹ�����, d.department_name, count(e.employee_id) ������, Round(Avg(e.salary), 1) As ��ձ޿�, trunc(avg(months_between(sysdate, e.hire_date) / 12)) as "��� �ټ� ���(��)"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN countries c ON c.country_id = l.country_id
GROUP BY l.city, l.city || ',' || c.country_id, d.department_name
ORDER BY �ٹ�����;

--4. ������Ǻ� ��

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS �̸�, e.job_id, j.job_title, e.salary, e.commission_pct, 
(e.salary + (e.salary * commission_pct)) as ������, e.manager_id, l.city
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON j.job_id = e.job_id
INNER JOIN locations l ON l.location_id = d.location_id WHERE commission_pct is not null;

--5.
