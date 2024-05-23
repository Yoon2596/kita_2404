--[�ǽ�]
-- ���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5���̻��� ����ϼ���
-- �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ��� (�ɼ�)

SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;


--CASE1 ���� �ο��� ���� ���� ���� �� ȸ�翡�� ���� �����ϴ� ���̱⿡ �̰��� �� ���� ���� �ƴϸ� �ο� ���� ���� �� �������� ���� ���̺�
SELECT department_name, department_id, employee_count
FROM (
    SELECT d.department_name, d.department_id, COUNT(e.department_id) AS employee_count FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_name, d.department_id
    UNION ALL
    SELECT 'No Department', NULL, COUNT(*)
    FROM employees
    WHERE department_id IS NULL
)
ORDER BY employee_count DESC;

--CASE2 ���� �μ��� �������� ����� �İߵǾ� �ִ��� Ȯ�� 
SELECT l.city, l.state_province, l.country_id, e.job_id, COUNT(*) AS EMPLOYEE_COUNT FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
GROUP BY l.country_id, l.city, l.state_province, d.department_id, e.job_id
ORDER BY l.country_id;

--CASE3 ������ǵ��� ���� ��
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS �̸�, e.job_id, j.job_title, e.salary, e.commission_pct, 
(e.salary + (e.salary * commission_pct)) as ������, e.manager_id, l.city
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON j.job_id = e.job_id
INNER JOIN locations l ON l.location_id = d.location_id WHERE commission_pct is not null;


--CASE4 �������� ������ �̷� Ȯ��
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS �̸�, nvl(h.job_id, '�̷�') AS job_id,
decode(count(h.start_date), 0, '����', 1, '1', 2, '2', '2���̻�') AS Ƚ�� 
FROM employees e 
LEFT OUTER JOIN job_history h ON e.employee_id = h.employee_id
WHERE e.employee_id IS NOT NULL
GROUP BY ROLLUP ((e.employee_id, e.first_name || ' ' || e.last_name), h.job_id)
HAVING count(h.start_date) > 0 AND GROUPING(e.employee_id) = 0 AND GROUPING(e.first_name || ' ' || e.last_name) = 0;


--CASE5 ���� �����϶��� salary ��
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS name, e.hire_date, trunc((sysdate - e.hire_date) / 365) AS �ټ�, 
e.job_id, e.salary, (j.min_salary + j.max_salary) / 2 AS ����ӱ� 
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY e.job_id;







select department_id, sum(salary) from employees
where (hire_date-sysdate)/365 >= 15
group by department_id
having count(*) >= 3;
