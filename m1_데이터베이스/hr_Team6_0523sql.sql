--1. 부서별 퇴직자 비율과 평균 근속  
--Insight_1. 각 근무지별로, 직무, 직원 수, 평균급여, 평균근속년수를 파악합니다. 
--
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


--2. 부서별 평균 임급이랑 직원별 임금 
Select 
    D.department_name As "부서",
    E.first_name || ' ' || E.last_name As "이름", 
    E.salary As "급여", 
    trunc(Months_Between(Sysdate, E.hire_date) / 12) As "경력(년)",
    Avgsal."부서별 평균 급여",
    Avgsal."부서별 평균 경력(년)"
From employees E
Join departments D ON E.department_id = D.department_id
Join(Select 
         D.DEPARTMENT_ID, 
         Round(Avg(E.SALARY)) As "부서별 평균 급여",
         Floor(Avg(Months_between(Sysdate, E.HIRE_DATE) / 12)) As "부서별 평균 경력(년)"
     From 
         employees E
     Join 
         departments D ON E.department_id = D.department_id
     Group By 
         D.department_id) Avgsal On E.department_id = Avgsal.department_id
Where 
    E.salary < Avgsal."부서별 평균 급여"
Order By 
    D.department_name, E.salary Desc, "급여";

Select 
    D.department_name As "부서",
    E.first_name || ' ' || E.last_name As "이름", 
    E.salary As "급여", 
    trunc(Months_Between(Sysdate, E.hire_date) / 12) As "경력(년)",
    
SELECT ROUND(AVG(salary), 1) AS 부서별평균급여 FROM employees GROUP BY department_id;
SELECT trunc(Avg(Months_between(Sysdate, hire_date) / 12))AS 부서별평균경력 FROM employees GROUP BY department_id;

--3. 나라별 부서랑 직무에 몇명 파견되어 있는지 평균급여 근속년수 파악
SELECT l.city || ',' || c.country_id 근무지역, d.department_name, count(e.employee_id) 직원수, Round(Avg(e.salary), 1) As 평균급여, trunc(avg(months_between(sysdate, e.hire_date) / 12)) as "평균 근속 년수(년)"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN countries c ON c.country_id = l.country_id
GROUP BY l.city, l.city || ',' || c.country_id, d.department_name
ORDER BY 근무지역;

--4. 세일즈맨별 평가

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS 이름, e.job_id, j.job_title, e.salary, e.commission_pct, 
(e.salary + (e.salary * commission_pct)) as 성과금, e.manager_id, l.city
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON j.job_id = e.job_id
INNER JOIN locations l ON l.location_id = d.location_id WHERE commission_pct is not null;

--5.
