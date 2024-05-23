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

--CASE2 나라별 부서와 직무에서 몇명이 파견되어 있는지 확인 
SELECT l.city, l.state_province, l.country_id, e.job_id, COUNT(*) AS EMPLOYEE_COUNT FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
GROUP BY l.country_id, l.city, l.state_province, d.department_id, e.job_id
ORDER BY l.country_id;

--CASE3 세일즈맨들의 성과 비교
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS 이름, e.job_id, j.job_title, e.salary, e.commission_pct, 
(e.salary + (e.salary * commission_pct)) as 성과금, e.manager_id, l.city
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON j.job_id = e.job_id
INNER JOIN locations l ON l.location_id = d.location_id WHERE commission_pct is not null;


--CASE4 직원들의 이직과 이력 확인
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS 이름, nvl(h.job_id, '이력') AS job_id,
decode(count(h.start_date), 0, '없음', 1, '1', 2, '2', '2번이상') AS 횟수 
FROM employees e 
LEFT OUTER JOIN job_history h ON e.employee_id = h.employee_id
WHERE e.employee_id IS NOT NULL
GROUP BY ROLLUP ((e.employee_id, e.first_name || ' ' || e.last_name), h.job_id)
HAVING count(h.start_date) > 0 AND GROUPING(e.employee_id) = 0 AND GROUPING(e.first_name || ' ' || e.last_name) = 0;


--CASE5 같은 직업일때의 salary 비교
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS name, e.hire_date, trunc((sysdate - e.hire_date) / 365) AS 근속, 
e.job_id, e.salary, (j.min_salary + j.max_salary) / 2 AS 평균임금 
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY e.job_id;







select department_id, sum(salary) from employees
where (hire_date-sysdate)/365 >= 15
group by department_id
having count(*) >= 3;
