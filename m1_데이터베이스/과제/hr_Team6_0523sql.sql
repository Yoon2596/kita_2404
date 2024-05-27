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

WITH TotalEmployees AS (
    SELECT COUNT(*) AS total_count FROM employees
)
    
SELECT
    d.department_name AS "부서명",
    j.job_id,
    ROUND(AVG(MONTHS_BETWEEN(j.end_date, j.start_date) / 12), 1) AS "퇴직자 평균 근속 년수(년)",
    COUNT(j.employee_id) AS "퇴직자 수",
    ROUND((COUNT(j.employee_id) / (SELECT total_count FROM TotalEmployees)) * 100, 2) AS "퇴직자 비율(%)"
FROM job_history j
JOIN departments d ON j.department_id = d.department_id
GROUP BY j.department_id, j.job_id, d.department_name
ORDER BY "퇴직자 수" DESC;


1. 부서별 및 직업별 퇴직자들의 평균 근속 년수를 파악하여 특정 부서나 직업에서 근속 기간이 짧은 경향이 있는지 확인할 수 있습니다. 
2. 부서별 및 직업별로 퇴직자 수를 계산하여 어느 부서나 직업에서 퇴직률이 높은지 파악할 수 있습니다. 
3. 전체 직원 수에 대비한 퇴직자 비율을 계산하여 부서별 퇴직 비율을 비교할 수 있습니다.

기여할수 있는 방면은
퇴직 원인 분석하여 특정 부서나 직업에서 근속 기간이 짧고 퇴직률이 높은 경우, 그 원인을 분석하여 개선 방안을 모색할 수 있습니다.
퇴직률이 높은 부서나 직업에 대해 주의 깊게 관찰하고 원인을 분석하여 근무 환경 개선, 보상 제도 재검토 등을 다양한 대응책을 통해 직원들의 만족도를 높일 수 있습니다.
근속 기간이 짧은 부서나 직업에 대해 미리 파악하여 중요한 인재가 회사를 떠나는 것을 방지할 수 있습니다.
특정 부서에서 비정상적으로 높은 퇴직률을 보이는 경우 그 부서를 집중적으로 조사하고 필요한 경우 인력 재배치를 통해 업무 효율성과 안정성을 높일 수 있습니다.

이 인사이트는 부서별, 직업별 퇴직자 데이터를 정리하여 추후 회사의 안정성을 높일수 있습니다.



--2. 부서별 평균 임급이랑 직원별 임금 비교
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


1. 각 부서별로 평균 급여를 계산하고, 개별 직원의 급여가 그 부서의 평균 급여보다 낮은 직원들을 식별합니다.
2. 각 부서별로 평균 경력을 계산 및 제공하여 경력에 따른 급여 수준을 비교할 수 있습니다 
3. 경력만이 아니라 평균 급여보다 낮은 급여를 받는 직원들을 부서별로 정렬하여 급여가 부서별 평균보다 낮은 이유를 파악하고 이들에 대해 개별적으로 검토할 수 있습니다.


기여 할수 있는 방면은
평균 급여보다 낮은 급여를 받는 직원들을 식별함으로써 급여 불균형을 파악함으로 부서 내에서의 급여 조정, 승진, 보너스 지급 등의 결정을 할 때 중요한 기준이 될 수 있습니다.
경력이 많은 직원들 중에서 급여가 낮은 직원들을 식별하여 경력에 따른 보상 체계의 적절성을 평가하고, 필요한 경우 보상 체계를 수정하는 데 도움이 됩니다.  
    
이 인사이트는 부서 내 평균급여와 경력별 평균 급여를 정리하여 추후 급급여에 따른 직원 만족도와 신뢰도를 높일 수 있습니다





--3. 나라별 부서랑 직무에 몇명 파견되어 있는지 평균급여 근속년수 파악
  
SELECT l.city || ',' || c.country_id 근무지역, d.department_name, count(e.employee_id) 직원수, 
Round(Avg(e.salary), 1) As 평균급여, trunc(avg(months_between(sysdate, e.hire_date) / 12)) as "평균 근속 년수(년)"
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id
INNER JOIN countries c ON c.country_id = l.country_id
GROUP BY l.city, l.city || ',' || c.country_id, d.department_name
ORDER BY 근무지역;

1. 각 근무지역(도시 및 국가)별로 직원 수, 평균 급여, 평균 근속 년수를 제공합니다.
2. 각 근무지역과 부서에 대한 상세한 데이터를 제공합니다.

기여 할수 있는 방면은
각 지역별로 직원 분포와 평균 급여 수준, 근속 연수를 파악함으로써 지역 간의 인력 분포와 급여에 따른 균형을 파악 할 수 있습니다. 
특정 지역에 인력이 집중되어 있거나, 급여가 다른 지역에 비해 낮은 경우 이를 조정할 수 있습니다.
현재 분포 되어 있는 직원수와 직무에 따라 현재 회사가 나아가는 방향을 파악하여 그 지역에 더욱 힘을 실을 수 있습니다
각 지역과 부서별로 인력 계획을 세우고, 예산을 효과적으로 배분이 가능하여 특정 지역이나 부서에서 인력이 많이 필요할 경우, 그에 맞는 예산을 배정하고, 채용 계획을 수립할 수 있습니다.
특정 지역이나 부서의 평균 급여를 기준으로 인사 정책을 조정하거나, 인력 배치를 최적화할 수 있습니다.

    
--4. 세일즈맨별 평가
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS 이름, e.job_id, j.job_title, e.salary, e.commission_pct, 
e.salary * commission_pct as 성과금, e.manager_id, l.city
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
INNER JOIN jobs j ON j.job_id = e.job_id
INNER JOIN locations l ON l.location_id = d.location_id WHERE commission_pct is not null;

1. 성과급을 받는 직원들의 직무와 직함 정보 등 상세 정보를 제공합니다.
2. 성과급을 포함한 직원의 총 보상을 계산합니다.
3. 성과급 수령 직원들의 근무 지역 정보를 제공합니다.


성과급 지급이 직원의 동기 부여와 성과에 어떤 영향을 미치는지 평가할 수 있습니다. 
성과급이 높은 직원들과 낮은 직원들의 성과를 비교하여, 성과 평가 기준과 효율성을 분석할 수 있습니다.
특정 지역에서 성과급 수령 직원들이 많이 분포하는지 파악 하여 지역별로 성과급 수령 직원들의 성과와 보상을 분석하여, 지역별 보상 정책을 최적화할 수 있습니다.
성과급 지급이 특정 직무나 직함에 집중되어 있는지 분석할 수 있습니다. 이를 통해 특정 직무에 대한 보상 체계를 재조정하거나, 성과급 지급 기준을 재검토할 수 있습니다.
성과에 따라 보너스가 지급되므로, 직원들의 동기 부여와 생산성 향상에 긍정적인 영향을 미칠 수 있습니다.    
회사 차원에서 성과급에 대한 예산을 효과적으로 관리할 수 있습니다. 성과급 비율을 통해 총 보상 비용을 예측할 수 있습니다.


--5. 직업별 평균 salary와 회사내 salary 비교
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS name, e.hire_date, trunc((sysdate - e.hire_date) / 365) AS 근속, 
e.job_id, e.salary, (j.min_salary + j.max_salary) / 2 AS 평균임금 
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
ORDER BY e.job_id;

전에는 회사내의 부서별 평균 급여였으면 이번에 직업별 평균 급여 비교

1. 직원별로 식별 가능한 기본 정보를 제공합니다. 
2. 직원의 근속 연수를 파악합니다.
3. 직원이 담당하는 직무를 식별합니다. 
4. 직원의 기본 급여를 보여줍니다. 
5. 해당 직무의 최소 임금과 최대 임금의 평균값을 계산합니다. 

    
직원별 상세한 정보로 인해 특정 직원에 대한 정보를 쉽게 조회할 수 있습니다.
각 직무의 평균 임금과 비교하여 직원의 급여 수준을 평가할 수 있습니다. 이는 급여 구조의 공정성을 유지하고, 직원의 만족도를 높이는 데 도움이 됩니다.
예를 들어 직원의 급여가 평균보다 낮다면 급여 인상을 고려할 수 있고, 반대로 높다면 그 이유를 분석할 수 있습니다
직무별로 직원의 분포를 분석하여, 특정 직무에 대한 인력 부족이나 과잉을 식별할 수 있습니다. 이를 통해 효율적인 인력 배치를 계획할 수 있습니다.
각 직원의 급여가 해당 직무의 평균 임금 대비 적절한지 평가할 수 있습니다.
근속 연수 정보를 통해 만약 해당 인원이 평균 임금 대비 급여가 낮다면 이직 가능성이 높다고 식별하고, 필요한 경우 직무의 보상 체계를 재평가 하여 이들의 만족도를 높이기 위한 조치를 취할 수 있습니다.
