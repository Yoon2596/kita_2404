--Q. 10개의 속성으로 구성되는 테이블 2개를 작성하세요. 단 foreign key를 적용하여 한쪽 테이블 데이터를 삭제 시
-- 다른 테이블의 관련되는 데이터도 모두 삭제되도록 하세요 (모든 제약조건을 사용)
-- 단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번쨰 데이터를 참조하고 있는 속성을 선택하여 데이터 삭제
CREATE TABLE MOVIE (
    movieid NUMBER PRIMARY KEY,
    title VARCHAR2(50) NOT NULL,
    publish_date DATE,
    price NUMBER,
    run_time NUMBER(2)
);

CREATE TABLE ACTORS (
    act_id NUMBER,
    name VARCHAR2(50),
    age number(3),
    filmograph VARCHAR2(50),
    main_act VARCHAR2(50),
    PRIMARY KEY(act_id),
    FOREIGN KEY(act_id) REFERENCES MOVIE(movieid) ON DELETE CASCADE
);
DROP TABLE ACTORS;
INSERT INTO MOVIE VALUES(1, '범죄도시4', TO_DATE('2024-02-23', 'YYYY-MM-DD'), 15000, 109);
INSERT INTO ACTORS VALUES(1, '마동석', 53, '범죄도시', 'action');

SELECT * FROM MOVIE;
SELECT * FROM ACTORS;

DELETE FROM MOVIE;
DELETE FROM ACTORS;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM book;

--강사님 버전 문제1
DROP TABLE mart;
DROP TABLE department;
CREATE TABLE mart (
    custid NUMBER PRIMARY KEY,
    name VARCHAR2(20),
    age NUMBER,
    sx VARCHAR2(20),
    phone NUMBER NOT NULL,
    address VARCHAR2(100),
    frequency NUMBER, --방문 빈도
    amount_num NUMBER,
    amount_price NUMBER,
    parking VARCHAR(20), -- 주차여부
    family NUMBER       -- 가족 구성원 수
);

ALTER TABLE mart DROP COLUMN amount_num;
ALTER TABLE mart MODIFY(name VARCHAR2(30));
ALTER TABLE mart MODIFY(phone VARCHAR2(20));
DESC mart;
INSERT INTO mart VALUES(1, '고길동', 32, '남', '010-123-1234', '서울 강남', 5 , 1500000, 'N', 3);
INSERT INTO mart VALUES(2, '이순신', 87, '남', '010-123-1234', '서울 춘천', 5 , 300000000, 'N', 5);
INSERT INTO mart VALUES(3, '철수', 12, '남', '010-123-1234', '서울 통영', 5 , 20000, 'N', 4);
INSERT INTO mart VALUES(4, '영희', 56, '여', '010-123-1234', '서울 서초', 5 , 600000000, 'N', 2);
INSERT INTO mart VALUES(5, '아아아', 31, '여', '010-123-1234', '서울 역삼', 5 , 123000000, 'N', 1);
SELECT * FROM mart;

CREATE TABLE department (
    custid NUMBER PRIMARY KEY,
    name VARCHAR2(20),
    age NUMBER,
    sx VARCHAR2(20),
    phone NUMBER NOT NULL,
    address VARCHAR2(100),
    use_store NUMBER, --방문 이유
--    amount_num NUMBER,
    amount_price NUMBER,
    valet VARCHAR2(20), -- 주차여부
    rounge VARCHAR2(20)  
    FOREIGN KEY
);

INSERT INTO department VALUES(1, '손흥민', 31, '남', '010-123-1234', '서울 춘천', 'LV' , 90000500000, '', '');


--Task2_0520. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE customer SET address = REPLACE(address, '대한민국 대전','대한민국 서울');
--강사님 버전 문제2
UPDATE customer SET address = (SELECT address FROM customer WHERE name = '김연아') WHERE name = '박세리';
SELECT address, name FROM customer;
--다시 부산으로 변경
UPDATE customer SET address = '대한민국 대전' WHERE name = '박세리';

--Task3_0520.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
SELECT price, REPLACE(bookname, '야구', '농구') FROM book;
UPDATE book SET bookname = REPLACE(bookname, '농구', '야구') WHERE bookname LIKE '농구%';
UPDATE book SET bookname = REPLACE(bookname, '야구', '농구') WHERE bookname LIKE '야구%';

--강사님 버전 문제3
SELECT bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, price FROM book;
SELECT bookid, REPLACE(bookname, '농구', '야구') bookname, publisher, price FROM book;

SELECT * FROM book;

--Task4_0520. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
SELECT COUNT (*) 같은성씨 FROM customer WHERE name = (SELECT name WHERE name LIKE '박%');
--강사님 버전 문제4
--substr(name, 1, 1) 함수는 문자열 name의 첫 번쨰 글자부터 시작하여 한 글자를 반환
--GROUP BY 절에서 substr(name, 1, 1) 표현식을 사용해야 함 (별칭 사용 불가) ex) GROUP BY 성 이렇게 안됨
SELECT * FROM customer;
SELECT substr(name, 1, 1) 성, COUNT(*) 인원 FROM customer GROUP BY substr(name, 1, 1);


--Task5_0520. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT orderdate+10 AS 확정일자 FROM orders;
--강사님 버전 문제5
SELECT orderid, orderdate AS 주문일, orderdate + 10 AS 확정일자 FROM orders;


--Task6_0520.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.
SELECT orderid, custid, orderdate, bookid FROM orders WHERE orderdate = '20-07-07';
--강사님 버전 문제6
SELECT orderid 주문번호, TO_CHAR(orderdate, 'YYYY-MM-DD day') 주문일, custid 고객번호, bookid 도서번호
FROM orders WHERE orderdate = '2020-07-07';
SELECT orderid 주문번호, orderdate 주문일, custid 고객번호, bookid 도서번호
FROM orders WHERE orderdate = TO_DATE('2020/07/07', 'YYYY/MM/DD');



--Task7_0520. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT AVG(saleprice) AS "평균" FROM orders;
SELECT o1.orderid, o1.saleprice FROM orders o1
WHERE o1.saleprice <= (SELECT AVG(o2.saleprice) FROM orders o2);
--강사님 버전 문제7
SELECT orderid, saleprice FROM orders
WHERE saleprice <= (SELECT avg(saleprice) FROM orders);
--서브쿼리를 o2라는 별칭으로 지정, saleprice의 평균값을 avg_saleprice로 계산
SELECT o1.orderid, o1.saleprice FROM orders o1
JOIN (SELECT AVG(saleprice) AS avg_saleprice FROM orders) o2
ON o1.saleprice <= o2.avg_saleprice;

SELECT o1.orderid, o1.saleprice, o2.평균가 FROM orders o1
JOIN (SELECT AVG(saleprice) AS 평균가 FROM orders) o2
ON o1.saleprice <= o2.평균가;


--Task8_0520. 대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) "총판매량" FROM orders WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '대한민국%');
--강사님 버전 문제8
SELECT SUM(saleprice) "총판매액" FROM orders WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '대한민국%');