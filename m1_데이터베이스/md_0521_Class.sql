
--특정 테이블을 이용하는 것이 아니기 때문에 FROM 뒤에 dual을 쓴다
--절대값
SELECT ABS(-70), ABS(+78) FROM dual;

--반올림
SELECT ROUND(4.875, 2) FROM dual;
--2이면 뒤로 소수점이니까 반대로 -2이면 백자리에서 반올림 된다
SELECT ROUND(1240, -2) FROM dual;

--고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오
SELECT * FROM orders;   
SELECT custid AS 고객번호, ROUND(AVG(saleprice), -2) AS 평균주문금액 FROM orders GROUP BY custid;

--'굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
SELECT bookname 제목, length(bookname) 글자수, length(bookname) 바이트수 FROM book WHERE publisher = '굿스포츠';

--마당서점은 주문일로부터 2개월 후 매출을 확정한다. 각 주문의 확정일자를 구하시오
SELECT orderid, orderdate AS 주문일, orderdate+ 62 AS 확정일자 FROM orders;
SELECT orderid, orderdate AS 주문일, ADD_MONTHS(orderdate, 2) AS 확정일자 FROM orders;

--substr(name, 1, 1) 함수는 문자열 name의 첫 번쨰 글자부터 시작하여 한 글자를 반환
--GROUP BY 절에서 substr(name, 1, 1) 표현식을 사용해야 함 (별칭 사용 불가) ex) GROUP BY 성 이렇게 안됨
SELECT * FROM customer;
SELECT substr(name, 1, 1) 성, COUNT(*) 인원 FROM customer GROUP BY substr(name, 1, 1);


--여러가지 방법으로 날짜 표시가 가능하다
--WHERE orderdate = TO_DATE('20/07/07', 'YY/MM/DD');
--WHERE orderdate = TO_DATE('20/07/24 days', 'DD/MM/YY');

--Q. DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') SYSDATE1 FROM dual;

--Q. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하시오
-- NVL 함수는 값이 NULL인 경우 지정값을 출력하고, NULL이 아니면 원래 값을 그대로 출력한다. 함수 : NVL("값", "지정값")
SELECT name 이름, NVL(phone, '연락처없음') 전화번호 FROM customer;

--Q. 고객목록에서 고객번호, 이름, 전화번호를 앞의 두명만 보이시오.
-- ROWNUM : 오라클에서 자동으로 제공하는 가상 열로 쿼리가 진행되는 동안 각 행에 일련번호를 자동으로 할당.
SELECT rownum 순번, custid 고객번호, name 이름, phone 전화번호 FROM customer WHERE rownum < 3;
SELECT * FROM orders;


