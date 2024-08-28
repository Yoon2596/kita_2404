Select * from employees order by employee_id;


--Q. 사번이 120번인 사람의 사번, 이름, 업무(job id), 업무명(job title)를 출력
SELECT E.employee_id 사번, E.first_name 이름, E.last_name 성, E.job_id 업무, J.job_title 업무명
FROM employees E
INNER JOIN jobs J ON E.job_id = J.job_id
WHERE E.employee_id = 120;

-- FIRST_NAME || ' ' || LAST NAME AS 이름 : FIRST NAME과 LAST NAME을 공백으로 연결하여
-- 하나의 문자열로 합치고, 이 결과의 별칭을 '이름'으로 지정
SELECT E.employee_id 사번, E.first_name || ' ' || E.last_name AS 이름, E.job_id 업무, J.job_title 업무명
FROM employees E
INNER JOIN jobs J ON E.job_id = J.job_id
WHERE E.employee_id = 120;

--또 다른 방법
SELECT 
E.employee_id 사번, 
E.first_name || ' ' || E.last_name AS 이름, 
E.job_id 업무, J.job_title 업무명
FROM employees E, JOBS J 
WHERE E.employee_id = 120 AND e.job_id = j.job_id;


--Q. 2005년 상반기에 입사한 사람들의 이름(Full Name)만 출력
SELECT TO_CHAR(hire_date, 'YY/MM') FROM employees;
SELECT first_name || ' ' || last_name AS 이름 
FROM employees WHERE TO_CHAR(hire_date, 'YY/MM') BETWEEN '05/01' AND '05/06';

--Q. _을 와일드카드가 아닌 문자로 취급하고 싶을 때 escape 옵션을 사용
SELECT * FROM employees WHERE job_id LIKE '%|_A%';  -- escape 없을 시 출력 안됨
SELECT * FROM employees WHERE job_id LIKE '%|_A%' escape '|';   -- _A를 가진 문자 출력 확인
SELECT * FROM employees WHERE job_id LIKE '%#_A%' escape '#';   -- # 없어서 출력 없음
SELECT * FROM employees WHERE phone_number LIKE '%|.%' escape '.';   -- # 없어서 출력 없음

-- IN : OR 대신 사용
SELECT * FROM employees WHERE manager_id = 101 OR manager_id = 102 OR manager_id = 103;
SELECT * FROM employees WHERE manager_id IN (101, 102, 103);

--Q. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
SELECT first_name || ' ' || last_name AS 이름 FROM employees
WHERE job_id IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

-- NULL / IS NOT NULL
-- NULL 값인지를 확인할 경우 = 비교 연산자를 사용하지 않고 is null을 사용한다
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is not null;

-- ORDER BY
-- ORDER BY 컬럼명 [ASC | DESC]
SELECT * FROM employees ORDER BY salary ASC;
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary ASC, last_name DESC;

-- DUAL 테이블
-- MOD 나머지
SELECT * FROM employees WHERE MOD(employee_id, 2) = 1; -- 홀수 번호 찾기
SELECT mod(10, 3) FROM DUAL; -- 10을 3으로 나눴을 떄의 나머지 1

-- ROUND() 반올림 함수
SELECT ROUND(355.95555) FROM DUAL; -- 356
SELECT ROUND(355.95555, 2) FROM DUAL; --355.96
SELECT ROUND(355.95555, -2) FROM DUAL; --400

-- Trunc() 버림 함수, 지정한 자리수 이하를 버린 결과 제공
SELECT trunc(45.5555, 1) FROM DUAL; --45.5

-- ceil() 무조건 올림
SELECT ceil(45.111) FROM DUAL; -- 46
SELECT ceil(45.777) FROM DUAL; -- 46

--Q. HR_EMPLOYEES 테이블에서 이름, 급여, 10% 인상된 급여를 출력하세요
SELECT last_name 이름, salary 급여, salary*1.1 "인상된 급여" FROM employees;

--Q. EMPLOYEES_ID가 홀수인 직원의 employee_id 와 last_name을 출력하세요
SELECT employee_id 사원번호, last_name 이름 FROM employees WHERE mod(employee_id, 2) = 1;
-- 또는 이렇게도 가능함
SELECT employee_id 사원번호, last_name 이름 FROM employees 
WHERE employee_id IN(SELECT employee_id FROM employees WHERE mod(employee_id, 2) = 1);

--Q. EMPLOYEES 테이블에서 commission_pct 의 NULL값 갯수를 출력하세요
SELECT COUNT(*) FROM employees WHERE commission_pct is Null;
SELECT COUNT(*) FROM employees WHERE commission_pct is not Null;

--Q. EMPLOYEES 테이블에서 department_id가 없는 직원을 추출하여 Position을 '신입'으로 출력하세요 (position이라는 열 추가)
SELECT employee_id, first_name || ' ' || last_name AS 이름, '신입' AS position FROM employees 
WHERE department_id is Null;

--Q. HR EMPLOYEES 테이블에서 salary, last name 순으로 올림차순 정렬하여 출력
SELECT * FROM employees ORDER BY salary, last_name;

-- 날짜 관련
SELECT sysdate FROM dual;
SELECT sysdate + 1 FROM dual;
SELECT sysdate - 1 FROM dual;

-- 근무한 날짜 계산
SELECT last_name, sysdate, hire_date, trunc(sysdate - hire_date) AS 근무기간 FROM employees;

-- ADD_MONTHS() : 특정 개월 수를 더한 날짜를 구한다
SELECT last_name, hire_date, add_months(hire_date, 6) revised_date FROM employees;

-- last_day()   : 해당 월의 마지막 날짜를 반환하는 함수
SELECT last_name, hire_date, last_day(hire_date) FROM employees;
SELECT last_name, hire_date, last_day(add_months(hire_date, 1)) FROM employees;

-- next_day()   : 해당 날짜를 기준으로 다음에 요일에 해당하는 날짜를 반환
-- 일 ~ 토요일을 1 - 7로 표현가능 (일 = 1, 월 = 2 ... 토 = 7)
SELECT hire_date, next_day(hire_date, '월') FROM employees;
SELECT hire_date, next_day(hire_date, 2) FROM employees;

-- months_between()  : 날짜와 날짜 사이의 개월수를 구한다
SELECT hire_date, round(months_between(sysdate, hire_date), 1) FROM employees;

-- to_date()    : 형 변환 함수 / 문자열을 날짜로
-- '2023-01-01'이라는 문자열을 날짜 타입으로 변환
SELECT to_date('2023-01-01', 'YYYY-MM-DD') FROM dual;

-- to_char()    : 날짜를 문자로 변환
SELECT to_char(sysdate, 'yy/mm/dd') FROM dual;

--형식
--YYYY       네 자리 연도
--YY      두 자리 연도
--YEAR      연도 영문 표기
--MM      월을 숫자로
--MON      월을 알파벳으로
--DD      일을 숫자로
--DAY      요일 표현
--DY      요일 약어 표현
--D      요일 숫자 표현
--AM 또는 PM   오전 오후
--HH 또는 HH12   12시간
--HH24      24시간
--MI      분
--SS      초

--Q. 현재날짜(sysdate)를 'yyyy/mm/dd' 형식의 문자열로 변환하세요
SELECT to_char(sysdate, 'yyyy/mm/dd') From dual;

--Q. '01-01-2023'이라는 문자열을 날짜 타입으로 변환하세요
SELECT to_date('01-01-2023', 'mm-dd-yyyy') FROM dual;

--Q. 현재 날짜와 시간(sysdate)를 'yyyy-mm-dd hh:mi:ss' 형식으로 변환하세요
SELECT to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') FROM dual;

--Q. '2023-01-01 15:30:00'이라는 문자열을 날짜 및 시간 타입으로 변환하세요
SELECT to_date('2023-01-01 15:30:00', 'yyyy-mm-dd hh24:mi:ss') FROM dual; --23/01/01 나오는데 sql에서 정해져있음

--to_char( 숫자 )   숫자를 문자로 변환
--9      한 자리의 숫자 표현      ( 1111, ‘99999’ )      1111   
--0      앞 부분을 0으로 표현      ( 1111, ‘099999’ )      001111
--$      달러 기호를 앞에 표현      ( 1111, ‘$99999’ )      $1111
--.      소수점을 표시         ( 1111, ‘99999.99’ )      1111.00
--,      특정 위치에 , 표시      ( 1111, ‘99,999’ )      1,111
--MI      오른쪽에 - 기호 표시      ( 1111, ‘99999MI’ )      1111-
--PR      음수값을 <>로 표현      ( -1111, ‘99999PR’ )      <1111>
--EEEE      과학적 표현         ( 1111, ‘99.99EEEE’ )      1.11E+03
--V      10을 n승 곱한값으로 표현   ( 1111, ‘999V99’ )      111100
--B      공백을 0으로 표현      ( 1111, ‘B9999.99’ )      1111.00
--L      지역통화         ( 1111, ‘L9999’ )

SELECT salary, to_char(salary, '0999999') FROM employees;
SELECT salary, to_char( -salary, '999999PR') FROM employees;

--1111 -> 1.11E+03
SELECT to_char(11111, '9.99EEEE') FROM dual;
SELECT to_char(-1111111, '9999999MI') FROM dual;

-- width_bucker()   : (지정값, 최소값, 최대값, bucket 개수)
SELECT width_bucket(92, 0 , 100, 10) FROM dual; -- 10개로 나눴을 때 92번은 몇번쨰 버켓에 있을까? 10
SELECT width_bucket(100, 0, 100, 10) FROM dual; -- 10개로 나눴을 때 100은 11번쨰 버켓 (100은 포함이 안된다) 0 - 9까지 10개

--Q. Salary 5개로 구분해보기
SELECT last_name, salary, width_bucket(salary, 2100, 24001, 5) AS grade FROM employees order by grade;

-- 문자 함수 Character Function
-- upper()  : 대문자로 변경
SELECT upper('Hello World') FROM dual;
-- lower()  : 소문자로 변경
SELECT lower('Hello World') FROM dual;

--Q. last name이 seo인 직원의 last name 과 salary를 구하시오 (seo, SEO, Seo 모두 검출)
SELECT last_name, salary FROM employees WHERE lower(last_name) = 'seo';

-- initcap()    : 첫 글자만 대문자
SELECT job_id, initcap(job_id) FROM employees;

-- length() : 문자열 길이
SELECT job_id, length(job_id) FROM employees;

-- instr()  : (문자열, 찾을 문자, 시작 위치, 찾은 문자 중 몇 번쨰)
SELECT instr('Hello World', 'o', 3, 2) FROM dual;   --SQL에서는 인덱스가 1부터 시작 0이 아님
SELECT instr('Hello World', 'W', 1, 1) FROM dual;   --대소문자 구분되서 정확한 문자를 넣어야 됨
SELECT instr('Hello wreld', 'e', 1, 1) FROM dual;   --시작 위치 확인

-- substr() : (문자열, 시작위치, 개수)
SELECT substr('Hello World', 3, 3) FROM dual;
SELECT substr('Hello World', 7, 9) FROM dual;
SELECT substr('Hello World', -1, 3) FROM dual; -- 시작위치가 -1일시 끝에서 첫번쨰부터 시작
SELECT substr('Hello World', -5, 5) FROM dual; -- 뒤에서 시작하지만 오른쪽으로 개수 셈

-- lpad()   : 오른쪽 정렬 후 왼쪽에 문자를 채운다 (문자열, 총 만들 문자개수, 넣을 거)
SELECT lpad('Hello World', 20, '#') FROM dual;

-- rpad()   : 왼쪽 정렬 후 오른쪽에 문자를 채운다
SELECT rpad('Hello World', 20, '$') FROM dual;

-- ltrim()  : 왼쪽 공백 없앤다 만약 (문자열, '없앨 문자) 이렇게 하면 왼쪽에 있는 문자 없어짐
SELECT ltrim('aaaaHello Worldaaaa', 'a') FROM dual; -- a 없애줌
SELECT ltrim('     Hello World      ') FROM dual;   -- 왼쪽 공백만 없애줌


-- rtrim()  : 오른쪽 공백 없앤다 / 만약 (문자열, '없앨 문자)
SELECT rtrim('aaaaHello Worldaaaa', 'a') FROM dual; -- a 없애줌
SELECT rtrim('     Hello World      ') FROM dual;   -- 왼쪽 공백만 없애줌

-- trim() : 양쪽 없애줌
SELECT trim('a' FROM 'aaaaHello Worldaaaa') FROM dual; -- 양쪽 a 없애줌
SELECT trim('     Hello World      ') FROM dual;   -- 양쪽 공백 없애줌

-- 앞 뒤의 특정 문자 제거
SELECT last_name, trim('A' FROM last_name) FROM employees;

-- nvl()    : null을 0 또는 다른 값으로 변환하는 함수
SELECT last_name, manager_id, nvl(to_char(manager_id), 'CEO') FROM employees;


--decode()    if문이나 case문과 같이 여러 경우를 선택할 수 있도록 하는 함수
--DECODE 함수는 단순한 조건에 기반하여 값을 반환합니다. 구문은 DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--여기서 expression은 검사할 값을 나타내고, search와 result는 각각 조건과 해당 조건이 참일 때 반환할 값
--default는 모든 search 조건이 거짓일 때 반환할 기본 값 출력
SELECT last_name, department_id, 
decode(department_id, 
        90, '경영지원실', 
        60, '프로그래머',
        100,'인사부', '기타') 부서
FROM employees;

--Q. employees 테이블에서 commission_pct가 null이 아닌 경우, 'A' null인 경우 'N'을 표시하는 쿼리를 작성
SELECT commission_pct as commission
    , decode(commission_pct, null, 'N', 'A') as 변환
FROM employees ORDER BY 변환 DESC;


--case()
--decode() 함수와 유사하나 decode() 함수가 단순한 조건 비교에 사용되는 반면
--case() 함수는 다양한 비교연산자로 조건을 제시할 수 있다.
--CASE 문은 조건에 따라 다른 값을 반환하는 데 사용되며, DECODE보다 복잡한 조건을 표현할 수 있다. 
--구문은 CASE WHEN condition THEN result ... ELSE default END이다
SELECT last_name, department_id,
CASE 
    WHEN department_id = 90 THEN '경영지원실'
    WHEN department_id = 60 THEN '프로그래머'
    WHEN department_id = 100 THEN '인사부'
    ELSE '기타'
    END AS 소속
FROM employees;

--Q. employees 테이블에서 salary가 20000 이상이면 'A', 10000과 20000 미만 사이면 'B', 그 이하면 'C'로 표시하는 쿼리
SELECT last_name, salary,
CASE 
    WHEN salary >= 20000 THEN 'A'
    WHEN salary >= 10000 AND salary <= 20000 THEN 'B'
    ELSE 'C'
    END AS 등급
FROM employees ORDER BY 등급;

--INSERT
--테이블에 데이터를 입력하는 방법은 두 가지 유형이 있으며 한 번에 한 건만 입력된다.
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUMN_LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);


-- Concatenation : 콤마 대신에 사용하면 문자열이 연결되어 출력된다
SELECT last_name, 'is a', job_id FROM employees;
SELECT last_name || 'is a' || job_id FROM employees;


-- UNION (합집합), INTERSECT(교집합), MINUS(차집함), UNION ALL(겹치는 것까지 포함)
-- 두 개의 쿼리문을 사용해야한다. 데이터 타입을 일치 시켜야한다

-- UNION
SELECT first_name 이름, salary 급여, hire_date FROM employees
WHERE salary < 5000
UNION
SELECT first_name 이름, salary 급여, hire_date FROM employees
WHERE hire_date < '05/01/01';

-- MINUS
SELECT first_name 이름, salary 급여, hire_date FROM employees
WHERE salary < 5000
MINUS
SELECT first_name 이름, salary 급여, hire_date FROM employees
WHERE hire_date < '05/01/01';

-- INTERSECT
SELECT first_name 이름, salary 급여, hire_date FROM employees
WHERE salary < 5000
INTERSECT
SELECT first_name 이름, salary 급여, hire_date FROM employees
WHERE hire_date < '05/01/01';

--UNION ALL
SELECT first_name 이름, salary 급여, hire_date FROM employees
WHERE salary < 5000
UNION ALL
SELECT first_name 이름, salary 급여, hire_date FROM employees
WHERE hire_date < '05/01/01';


--CREATE VIEW 명령어는 오라클 SQL에서 테이블의 특정 부분이나 조인된 결과를 논리적인 뷰(view)로 만들 때 사용
--뷰는 데이터를 요약하거나 복잡한 조인을 단순화하며, 사용자에게 필요한 데이터만을 보여주는 데 유용
--뷰는 실제 테이블 데이터를 저장하지 않고, 대신 쿼리 결과를 저장
--뷰의 주요 특징
--쿼리 단순화: 복잡한 쿼리를 뷰로 저장함으로써 사용자는 복잡한 쿼리문을 반복해서 작성할 필요 없이 간단하게 뷰를 참조할 수 있다.
--데이터 추상화: 뷰는 기본 테이블의 구조를 숨기고 사용자에게 필요한 데이터만을 보여줄 수 있어, 데이터 추상화를 제공.
--보안 강화: 뷰를 사용하면 특정 데이터에 대한 접근을 제한할 수 있으며, 사용자가 볼 수 있는 데이터의 범위를 제어할 수 있다.
--데이터 무결성 유지: 뷰를 사용하여 데이터를 수정하더라도, 이 변경사항이 기본 테이블의 데이터 무결성 규칙을 위반하지 않도록 관리할 수 있다.

CREATE VIEW employee_details AS
SELECT employee_id, last_name, department_id
FROM employees;

SELECT * FROM employee_details;

--Q. employees 테이블에서 salary 가 10000원 이상인 직업만을 포함하는 뷰 special_employee 를 생성하는 SQL 명령문을 작성하세요
CREATE VIEW special_employee AS
SELECT last_name, salary
FROM employees WHERE salary >= 10000;
SELECT * FROM special_employee;

--Q. employees 테이블에서 각 부서별 직원수를 포함하는 뷰를 생성하세요
CREATE VIEW count_employee AS
SELECT department_id, count(*) AS 부서별_직원수
FROM employees GROUP BY department_id ORDER BY 부서별_직원수;
SELECT * FROM count_employee;

--Q. employees 테이블에서 근속기간이 10년 이상인 직원을 포함하는 뷰를 생성하세요
CREATE VIEW workday_employee AS
SELECT last_name, trunc(sysdate - hire_date) as 근속기간 FROM employees
WHERE trunc(sysdate - hire_date) > 365 * 10;
SELECT * FROM workday_employee;

--TCL (Transaction Control Language)
--COMMIT: 현재 트랜잭션 내에서 수행된 모든 변경(INSERT, UPDATE, DELETE 등)을 데이터베이스에 영구적으로 저장.
--COMMIT 명령을 실행하면, 트랜잭션은 완료되며, 그 이후에는 변경 사항을 되돌릴 수 없다.
--ROLLBACK: 현재 트랜잭션 내에서 수행된 변경들을 취소하고, 데이터베이스를 트랜잭션이 시작하기 전의 상태로 되돌린다. 
--오류가 발생했거나 다른 이유로 트랜잭션을 취소해야 할 경우에 사용된다.
--SAVEPOINT: 트랜잭션 내에서 중간 체크포인트를 생성합니다. 오류가 발생할 경우, ROLLBACK을 사용하여 최근의 SAVEPOINT까지 되돌릴 수 있다.
--트랜잭션을 콘트롤하는 TCL(TRANSACTION CONTROL LANGUAGE)

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


-- 예시
--부서별 급여 현황
--테이블생성, 부서별 급여와 총 급여를 확인 할 수 있음.
--(급여의 합 평균 최솟값 최댓값, 총 직원수, 급여전체총합, 직원평균급여, 부서평균급여)
--table 만들기 부서별 급여를 대략적으로 보기
--사용할 테이블 확인
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--부서 목록 확인
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- 부서 목록 department_id : 10,20,30,40,50,60,70,80,90,100,110 그 외 나머지(120~200등..)는 없고 null 값이 있음.
--department_id 가 null 인 사람은 모두 job_id 에 맞는 department_id 를 부여해주려고함(데이터 무결성)
--1. department_id 가 null 값인 사람 찾기
select *
from employees
where department_id IS NULL;
--한명 밖에 없음. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id 가 SA_REP 인 department_id 찾기 (직업에 맞는 부서 찾기)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP 의 department_id 는 80

--3. 수정 전 savepoint 생성
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. 제약조건primary key 인 employee_id 로 찾아서 derpartment_id 를 80으로 수정
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint로 가기
--commit;
--수정끝


--INSIGHT 예시

-- 팀구성 밑 년차별 샐러리
-- 각 부서마다 팀원은 몇명이고 어떤 포지션들이 있고 구성은 어떻게 되는지
-- ROLL UP은 다차원적인 집계 결과를 도출 : 사용 각 부서 및 직무별 직원수를 집계
SELECT e.department_id, d.department_name, nvl(e.job_id, 'Total') job_id, count(*) 직원수 FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id
GROUP BY ROLLUP((e.department_id, d.department_name), e.job_id)
ORDER BY e.department_id;


-- JOB ID 별 몇년차는 얼마 받는 지 각 년차별로 샐러리 평균
SELECT job_id, 연차, round(avg(salary)) 평균급여
FROM (SELECT job_id, floor(months_between(sysdate, hire_date)/12) as 연차, salary FROM employees)
GROUP BY job_id, 연차
ORDER BY job_id, 연차;