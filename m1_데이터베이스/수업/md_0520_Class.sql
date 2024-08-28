--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�
SELECT C.name, B.bookname FROM book B, customer C, orders O 
WHERE C.custid = O.custid AND B.bookid = O.bookid;

SELECT C.name, B.bookname FROM customer C, book B, orders O WHERE C.custid = O.custid AND O.bookid = B.bookid;

SELECT customer.name, book.bookname FROM orders INNER JOIN customer ON orders.custid = customer.custid INNER JOIN book ON orders.bookid = book.bookid;

--Q. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�
SELECT C.name, B.bookname FROM customer C, book B, orders O WHERE C.custid = O.custid AND O.bookid = B.bookid AND O.saleprice = 20000;

SELECT customer.name, book.bookname FROM orders
INNER JOIN customer ON orders.custid = customer.custid 
INNER JOIN book ON orders.bookid = book.bookid 
WHERE orders.saleprice = 20000;

SELECT C.name, B.bookname FROM orders O
INNER JOIN customer C ON O.custid = C.custid 
INNER JOIN book B ON O.bookid = B.bookid 
AND B.price = 20000;

--JOIN�� �� �� �̻��� ���̺��� �����Ͽ� ���õ� �����͸� ������ �� ���
--���� ���� (Inner Join)
SELECT * FROM customer;
SELECT * FROM orders;

SELECT customer.name, orders.saleprice FROM customer
INNER JOIN orders ON customer.custid = orders.custid;

--���� �ܺ� ���� (Left Outer Join) : . �� ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice FROM customer
LEFT OUTER JOIN orders ON customer.custid = orders.custid;

--������ �ܺ� ���� (Right Outer Join) : ù ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice FROM customer
RIGHT OUTER JOIN orders ON customer.custid = orders.custid;

--FULL OUTER JOIN : ��ġ�ϴ� �����Ͱ� ���� ��� �ش� ���̺����� NULL ���� ���
SELECT customer.name, orders.saleprice FROM customer
FULL OUTER JOIN orders ON customer.custid = orders.custid;

--CROSS JOIN : �� ���̺� ���� ��� ������ ������ ����
SELECT customer.name, orders.saleprice FROM customer
CROSS JOIN orders;

--Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�(2���� ���, WHERE, JOIN)
-- ���� �� ���̺��� �ݴ뿡 (+)�� ������ ���� ���� ���� ex) orders.custid�ʿ� �� �߰��� �ʿ������� �� ���ʿ� (+)�� ���´�
SELECT customer.name, orders.saleprice FROM customer, orders WHERE orders.custid(+) = customer.custid;

SELECT customer.name, orders.saleprice FROM customer
LEFT OUTER JOIN orders ON orders.custid = customer.custid;

-- �μ� ����
SELECT * FROM book;
SELECT * FROM orders;
--Q. ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
SELECT name FROM customer WHERE custid IN (SELECT custid FROM orders);


SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM orders;
--Q. �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT customer.name FROM customer, orders, book WHERE customer.custid = orders.custid AND book.bookid = orders.bookid AND book.publisher = '���ѹ̵��';

SELECT name FROM customer
WHERE custid IN (SELECT custid FROM orders
WHERE bookid IN (SELECT bookid FROM book
WHERE publisher = '���ѹ̵��'));

--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
SELECT b1.bookname FROM book b1 WHERE b1.price > (SELECT AVG(b2.price)
FROM book b2 WHERE b2.publisher = b1.publisher);

--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT name FROM customer WHERE custid NOT IN (SELECT custid FROM orders);

--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT name ���̸�, address �ּ� FROM customer
WHERE custid IN (SELECT custid FROM orders);



--������ Ÿ��
--������ (Numeric Types)
--NUMBER: ���� �������� ���� ������ Ÿ��. ����, �Ǽ�, ���� �Ҽ���, �ε� �Ҽ��� ���� ����
--NUMBER�� NUMBER(38, 0)�� ���� �ǹ̷� �ؼ�, Precision 38�� �ڸ���, Scale 0�� �Ҽ��� ���� �ڸ���
--NUMBER(10) : �ڸ����� 10�̰� �Ҽ��� ���� / NUMBER(8, 2) �ڸ����� 8�̰� �Ҽ��� 2�ڸ� ����(���� �ڸ��� ����)

--������ (Character Types)
--VARCHAR2(size): ���� ���� ���ڿ��� ����. size�� �ִ� ���� ���̸� ����Ʈ, Ȥ�� ���ڼ��� ����
--NVARCHAR2(size)�� ����� ������ ���� ����Ʈ ���� ��� �׻� ���� ������ ũ�Ⱑ ����
--CHAR(size): ���� ���� ���ڿ��� ����. ������ ���̺��� ª�� ���ڿ��� �ԷµǸ� �������� �������� ä����

--��¥ �� �ð��� (Date and Time Types)
--DATE: ��¥�� �ð��� ����. ������ Ÿ���� ��, ��, ��, ��, ��, �ʸ� ����
--TIMESTAMP: ��¥�� �ð��� �� ���� ������ �������� ����\
--DATE Ÿ���� ��¥�� �ð��� YYYY-MM-DD HH24:MI:SS �������� �����մϴ�.
--���� ���, 2024�� 5�� 20�� ���� 3�� 45�� 30�ʴ� 2024-05-20 15:45:30���� ����

--���� �������� (Binary Data Types)
--BLOB: �뷮�� ���� �����͸� ����. �̹���, ����� ���� ���� �����ϴ� �� ����

--��Ը� ��ü�� (Large Object Types)
--CLOB: �뷮�� ���� �����͸� ����
--NCLOB: �뷮�� ������ ���� ���� �����͸� ����


--���� ���ڵ��� �ǹ�
--��ǻ�ʹ� ���ڷ� �̷���� �����͸� ó��. ���ڵ��� ���� ����(��: 'A', '��', '?')�� 
--����(�ڵ� ����Ʈ)�� ��ȯ�Ͽ� ��ǻ�Ͱ� �����ϰ� ������ �� �ְ� �Ѵ�.
--���� ���, ASCII ���ڵ������� �빮�� 'A'�� 65��, �ҹ��� 'a'�� 97�� ���ڵ�. 
--�����ڵ� ���ڵ������� 'A'�� U+0041, �ѱ� '��'�� U+AC00, �̸�Ƽ�� '?'�� U+1F60A�� ���ڵ�
--�ƽ�Ű�� 7��Ʈ�� ����Ͽ� �� 128���� ���ڸ� ǥ���ϴ� �ݸ� �����ڵ�� �ִ� 1,114,112���� ���ڸ� ǥ��

--ASCII ���ڵ�:
--���� 'A' -> 65 (10����) -> 01000001 (2����)
--���� 'B' -> 66 (10����) -> 01000010 (2����)

--�����ڵ�(UTF-8) ���ڵ�: 
--���� 'A' -> U+0041 -> 41 (16����) -> 01000001 (2����, ASCII�� ����)
--���� '��' -> U+AC00 -> EC 95 80 (16����) -> 11101100 10010101 10000000 (2����)

--CLOB: CLOB�� �Ϲ������� �����ͺ��̽��� �⺻ ���� ����(��: ASCII, LATIN1 ��)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. 
--�� ������ �ַ� ����� ���� ���� ����Ʈ ���ڷ� �̷���� �ؽ�Ʈ�� �����ϴ� �� ���.
--NCLOB: NCLOB�� �����ڵ�(UTF-16)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. ���� �ٱ��� ������ �ʿ��� ��, \
--�� �پ��� ���� ������ �ؽ�Ʈ �����͸� ������ �� ����. �ٱ��� ���ڰ� ���Ե� �����͸� ȿ�������� ó���� �� �ִ�.

-- VALCHAR2�� �� ���� ������� ���̸� ���� (����Ʈ�� ����)
-- ���� Ȯ�� ���
SELECT *
FROM v$nls_parameters
WHERE parameter = 'NLS_LENGTH_SEMANTICS';

--�������� : 
--PRIMARY KEY : �� ���� �����ϰ� �ĺ��ϴ� ��(�Ǵ� ������ ����). �ߺ��ǰų� NULL ���� ������� �ʴ´�.
--FOREIGN KEY : �ٸ� ���̺��� �⺻ Ű�� �����ϴ� ��. ���� ���Ἲ�� ����
--UNIQUE : ���� �ߺ��� ���� ����� ���� ����. NULL���� ���
--NOT NULL : ���� NULL ���� ������� �ʴ´�.
--CHECK : �� ���� Ư�� ������ �����ؾ� ���� ���� (��: age > 18)
--DEFAULT : ���� ������� ���� �������� ���� ��� ���� �⺻���� ����


-- AUTHOR ���̺� ����
CREATE TABLE authors (
    id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    nationality VARCHAR2(50)
);
    
DROP TABLE authors;


--Q. NEWBOOK�̶�� ���̺��� �����ϼ���.
CREATE TABLE NEWBOOK (
    bookid NUMBER,
    isbn NUMBER(13),
    bookname VARCHAR2(50) NOT NULL,
    author VARCHAR2(50) NOT NULL,
    publisher VARCHAR2(30) NOT NULL,
    price NUMBER DEFAULT 10000 CHECK(price > 1000),
    published_date DATE,
    PRIMARY KEY(bookid)
);
DROP TABLE newbook;

-- 1�� ����
INSERT INTO newbook VALUES (1, 9781234567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));
-- ���� �ϱ��� �ݵ�� ���̺� �� ������ �����ϴ� ���� ����
DELETE FROM newbook;
-- ���̺� �������� ����, �߰� �Ӽ� �߰�, ����, ����(���ο� ������ �ִ� ��� ���� X)
ALTER TABLE newbook MODIFY (isbn VARCHAR2(50));
--�ݷ� �߰� / ����
ALTER TABLE newbook ADD author_id NUMBER;
ALTER TABLE newbook DROP COLUMN author_id;

INSERT INTO newbook VALUES (2, 9781234567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20 15:35:30', 'YYYY-MM-DD HH24:MI:SS'));
DESC NEWBOOK;
INSERT INTO newbook VALUES (3, 9781234512343267890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20 15:35:30', 'YYYY-MM-DD HH24:MI:SS'));
SELECT * FROM NEWBOOK;

-- ON DELETE CASCADE �ɼ��� �����Ǿ� �־�, newcustomer ���̺��� � ���� ���ڵ尡 �����Ǹ�, �ش� ���� ��� �ֹ��� neworders ���̺����� �ڵ����� ����
CREATE TABLE newcustomer (
    custid NUMBER PRIMARY KEY,
    name VARCHAR2(40),
    address VARCHAR2(40),
    phone VARCHAR2(30)
);

CREATE TABLE neworders (
    orderid NUMBER,
    custid NUMBER NOT NULL,
    bookid NUMBER NOT NULL,
    saleprice NUMBER,
    orderdate DATE,
    PRIMARY KEY(orderid),
    FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE
);

INSERT INTO newcustomer VALUES(1, 'KEVIN', '���ﵿ', '010-123-1234');
INSERT INTO neworders VALUES(10, 1, 100, 1000, SYSDATE);


DESC NEWORDERS;
SELECT * FROM newcustomer;
SELECT * FROM neworders;
-- newcustomer�� �������� neworders�� �ִ� �͵� ���� ��
DELETE FROM newcustomer;
DELETE FROM neworders;




