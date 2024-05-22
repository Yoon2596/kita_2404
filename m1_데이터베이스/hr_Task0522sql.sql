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

--CASE2
SELECT department_name, manager_id FROM departments;

--CASE3 ��� ���� ������ ������ ���� �� ���� �� ����

--CASE4 �ټ� ����� ���� ��� �ټ��� ���� ����
SELECT first_name || ' ' || last_name �̸�, trunc(MONTHS_BETWEEN(sysdate, hire_date) / 12) AS �ټӿ��� 
FROM employees WHERE trunc(MONTHS_BETWEEN(sysdate, hire_date) / 12) >= 20;

--CASE5 job history�� employees�� �ȸ���
select e.employee_id, e.first_name, e.last_name, 
count(h.start_date)  as "job�̷��� Ƚ��",
decode(count(h.start_date),0,'zero',1,'one',2,'two','many') as "���" 
from employees e left outer join job_history h 
on e.employee_id = h.employee_id
group by e.employee_id, e.first_name, e.last_name
order by 4;

select department_id, sum(salary) from employees
where (hire_date-sysdate)/365 >= 15
group by department_id
having count(*) >= 3;

SELECT e.employee_id, e.hire_date ��1, h.start_date ��1, h.end_date, e.department_id ��2, h.department_id ��2, e.job_id ��3, h.job_id ��3 FROM employees e
INNER JOIN job_history h ON e.employee_id = h.employee_id;