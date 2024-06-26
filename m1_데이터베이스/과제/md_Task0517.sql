--TASK1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어' 인 도서를 검색하시오(3가지 방법)
SELECT * FROM book WHERE publisher = '굿스포츠' OR publisher = '대한미디어';
SELECT * FROM book WHERE publisher LIKE '굿스포츠' OR publisher LIKE '대한미디어';
SELECT * FROM book WHERE publisher IN '굿스포츠' OR publisher IN '대한미디어';

--강사님 버전 문제 1
SELECT * FROM book WHERE publisher = '굿스포츠' OR publisher = '대한미디어';
SELECT * FROM book WHERE publisher IN ('굿스포츠', '대한미디어');
SELECT * FROM book WHERE publisher = '굿스포츠' UNION SELECT * FROM book WHERE publisher = '대한미디어';


--TASK2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어' 가 아닌 도서를 검색하시오
SELECT bookname FROM book WHERE publisher != '굿스포츠' AND publisher != '대한미디어';
SELECT bookname FROM book WHERE publisher <> '굿스포츠' AND publisher <> '대한미디어';

--강사님 버전 문제 2
SELECT * FROM book WHERE publisher NOT IN ('굿스포츠', '대한미디어');

--TASK3_0517. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시요
SELECT bookname FROM book WHERE bookname LIKE '%축구%' AND price >= 20000; 

--강사님 버전 문제 3
SELECT * FROM book WHERE bookname LIKE '%축구%' AND price >= 20000; 

--Task4_0517. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) AS "총 판매액" FROM orders WHERE custid = 2;

--강사님 버전 문제 4
SELECT customer.name, orders.custid, SUM(orders.saleprice) AS "총 판매액" FROM orders, customer
WHERE orders.custid = 2 AND orders.custid = customer.custid GROUP BY customer.name, orders.custid;

SELECT customer.name, orders.custid, SUM(orders.saleprice) FROM orders INNER JOIN customer on orders.custid = customer.custid
WHERE orders.custid = 2 GROUP BY customer.name, orders.custid;

-- 도서 개수 추가한 버전
SELECT customer.name, orders.custid, COUNT(orders.orderid) AS "도서 수량", SUM(orders.saleprice) AS "총 판매액" FROM orders, customer
WHERE orders.custid = 2 AND orders.custid = customer.custid GROUP BY customer.name, orders.custid;

--Task5_0517. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
SELECT custid, COUNT(*) AS 도서수량 FROM orders WHERE saleprice >= 8000 GROUP BY custid HAVING COUNT(*) >= 2 ORDER BY custid;

--강사님 버전 문제 5
SELECT custid, COUNT(*) AS 도서수량 FROM orders WHERE saleprice >= 8000 GROUP BY custid HAVING COUNT(*) >= 2;

--Task6_0517. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT custid, saleprice FROM orders custid ORDER BY custid;

--강사님 버전 문제 6
SELECT name, saleprice FROM customer, orders WHERE customer.custid = orders.custid;

-- 약자로 쓰기
SELECT name, saleprice FROM customer C, orders O WHERE C.custid = O.custid;

--Task7_0517. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT custid, SUM(saleprice) AS "총 주문 가격", COUNT(*) AS "총 주문 수량" FROM orders GROUP BY custid ORDER BY custid;

--강사님 버전 문제 7
SELECT custid, SUM(saleprice) AS "총 주문 가격" FROM orders GROUP BY custid ORDER BY custid;

--판매액 기준으로 정렬시
SELECT custid, SUM(saleprice) AS "총 주문 가격" FROM orders GROUP BY custid ORDER BY "총 주문 가격" DESC;