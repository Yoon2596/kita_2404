--[실습]
-- 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개이상으 기술하세요
-- 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데어터에 반영한 후 다시 분석해서 반영 여부를 검증하세요 (옵션)

SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;



 


--CASE1 가장 인원이 많은 곳이 지금 이 회사에서 집중 투자하는 곳이기에 이곳에 더 투자 할지 아니면 인원 없는 곳을 더 뽑을지에 대한 테이블
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

--CASE3 어느 나라에 직원이 많은지 보고 그 나라에 더 투자

--CASE4 근속 년수를 구해 장기 근속자 포상 지급
SELECT first_name || ' ' || last_name 이름, trunc(MONTHS_BETWEEN(sysdate, hire_date) / 12) AS 근속연수 
FROM employees WHERE trunc(MONTHS_BETWEEN(sysdate, hire_date) / 12) >= 20;

--CASE5 job history와 employees가 안맞음
select e.employee_id, e.first_name, e.last_name, 
count(h.start_date)  as "job이력의 횟수",
decode(count(h.start_date),0,'zero',1,'one',2,'two','many') as "등급" 
from employees e left outer join job_history h 
on e.employee_id = h.employee_id
group by e.employee_id, e.first_name, e.last_name
order by 4;

select department_id, sum(salary) from employees
where (hire_date-sysdate)/365 >= 15
group by department_id
having count(*) >= 3;

SELECT e.employee_id, e.hire_date 임1, h.start_date 히1, h.end_date, e.department_id 임2, h.department_id 히2, e.job_id 임3, h.job_id 히3 FROM employees e
INNER JOIN job_history h ON e.employee_id = h.employee_id;