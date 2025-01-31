
SELECT bookid FROM book;
SELECT bookid, price FROM book;
SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM imported_book;
SELECT * FROM orders;

--중복없이 출력
SELECT DISTINCT publisher FROM book;

--Q. 가격이 10,000원 이상인 도서를 검색
SELECT * FROM book WHERE price > 10000;

--Q. 가격이 10,000원 이상 20,000이하인 도서를 검색하시요(2가지 방법)
SELECT * FROM book WHERE 10000 <= price AND price <= 20000;
SELECT * FROM book WHERE price BETWEEN 10000 AND 20000;


-- LIKE는 정확이 '축구의 역사'와 일치하는 행만 선택
SELECT bookname, publisher FROM book WHERE bookname LIKE '축구의 역사';

-- % : 0개 이상의 임의의 문자  //  _ : 정확히 1개의 임의의 문자

-- '축구'가 포함 된 출판사 
SELECT bookname, publisher FROM book WHERE bookname LIKE '%축구%';

-- 도서이름의 왼쪽 두 번쨰 위치에 '구'라는 문자열을 갖는 도서
SELECT bookname, publisher FROM book WHERE bookname LIKE '_구%';


-- 도서이름과 가격을 올림차순으로 정렬
SELECT * FROM book ORDER BY bookname;
SELECT * FROM book ORDER BY price;
-- 내림차순으로 정렬
SELECT * FROM book ORDER BY price DESC;

--Q. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오(순서에 따라 적용된다)
SELECT * FROM book ORDER BY price, bookname;

--Q. 커스텀 아이디 2번인 가격 합계
SELECT SUM(saleprice) AS "총 판매액" FROM orders WHERE custid = 2;

--GROUP BY : 데이터를 특정 기준에 따라 그룹화하는데 사용. 이를 통해 집계 합수(SUM, AVG, MAX, MIN, COUNT)를 이용, 계산
SELECT SUM(saleprice) AS total, 
AVG(saleprice) AS average,
MIN(saleprice) AS minimum,
MAX(saleprice) AS maximun FROM orders;

--Q. 총 판매액을 custid 기준으로 그룹화
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액" 
FROM orders GROUP BY custid;

-- bookid가 5보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
WHERE bookid > 5
GROUP BY custid;

-- 도서수량이 2보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
WHERE bookid > 5
GROUP BY custid
HAVING COUNT(*) > 2;

