--Q. 10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ���. �� foreign key�� �����Ͽ� ���� ���̺� �����͸� ���� ��
-- �ٸ� ���̺��� ���õǴ� �����͵� ��� �����ǵ��� �ϼ��� (��� ���������� ���)
-- ��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù���� �����͸� �����ϰ� �ִ� �Ӽ��� �����Ͽ� ������ ����
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
INSERT INTO MOVIE VALUES(1, '���˵���4', TO_DATE('2024-02-23', 'YYYY-MM-DD'), 15000, 109);
INSERT INTO ACTORS VALUES(1, '������', 53, '���˵���', 'action');

SELECT * FROM MOVIE;
SELECT * FROM ACTORS;

DELETE FROM MOVIE;
DELETE FROM ACTORS;

SELECT * FROM customer;
SELECT * FROM orders;
SELECT * FROM book;

--����� ���� ����1
DROP TABLE mart;
DROP TABLE department;
CREATE TABLE mart (
    custid NUMBER PRIMARY KEY,
    name VARCHAR2(20),
    age NUMBER,
    sx VARCHAR2(20),
    phone NUMBER NOT NULL,
    address VARCHAR2(100),
    frequency NUMBER, --�湮 ��
    amount_num NUMBER,
    amount_price NUMBER,
    parking VARCHAR(20), -- ��������
    family NUMBER       -- ���� ������ ��
);

ALTER TABLE mart DROP COLUMN amount_num;
ALTER TABLE mart MODIFY(name VARCHAR2(30));
ALTER TABLE mart MODIFY(phone VARCHAR2(20));
DESC mart;
INSERT INTO mart VALUES(1, '��浿', 32, '��', '010-123-1234', '���� ����', 5 , 1500000, 'N', 3);
INSERT INTO mart VALUES(2, '�̼���', 87, '��', '010-123-1234', '���� ��õ', 5 , 300000000, 'N', 5);
INSERT INTO mart VALUES(3, 'ö��', 12, '��', '010-123-1234', '���� �뿵', 5 , 20000, 'N', 4);
INSERT INTO mart VALUES(4, '����', 56, '��', '010-123-1234', '���� ����', 5 , 600000000, 'N', 2);
INSERT INTO mart VALUES(5, '�ƾƾ�', 31, '��', '010-123-1234', '���� ����', 5 , 123000000, 'N', 1);
SELECT * FROM mart;

CREATE TABLE department (
    custid NUMBER PRIMARY KEY,
    name VARCHAR2(20),
    age NUMBER,
    sx VARCHAR2(20),
    phone NUMBER NOT NULL,
    address VARCHAR2(100),
    use_store NUMBER, --�湮 ����
--    amount_num NUMBER,
    amount_price NUMBER,
    valet VARCHAR2(20), -- ��������
    rounge VARCHAR2(20)  
    FOREIGN KEY
);

INSERT INTO department VALUES(1, '�����', 31, '��', '010-123-1234', '���� ��õ', 'LV' , 90000500000, '', '');


--Task2_0520. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE customer SET address = REPLACE(address, '���ѹα� ����','���ѹα� ����');
--����� ���� ����2
UPDATE customer SET address = (SELECT address FROM customer WHERE name = '�迬��') WHERE name = '�ڼ���';
SELECT address, name FROM customer;
--�ٽ� �λ����� ����
UPDATE customer SET address = '���ѹα� ����' WHERE name = '�ڼ���';

--Task3_0520.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
SELECT price, REPLACE(bookname, '�߱�', '��') FROM book;
UPDATE book SET bookname = REPLACE(bookname, '��', '�߱�') WHERE bookname LIKE '��%';
UPDATE book SET bookname = REPLACE(bookname, '�߱�', '��') WHERE bookname LIKE '�߱�%';

--����� ���� ����3
SELECT bookid, REPLACE(bookname, '�߱�', '��') bookname, publisher, price FROM book;
SELECT bookid, REPLACE(bookname, '��', '�߱�') bookname, publisher, price FROM book;

SELECT * FROM book;

--Task4_0520. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
SELECT COUNT (*) �������� FROM customer WHERE name = (SELECT name WHERE name LIKE '��%');
--����� ���� ����4
--substr(name, 1, 1) �Լ��� ���ڿ� name�� ù ���� ���ں��� �����Ͽ� �� ���ڸ� ��ȯ
--GROUP BY ������ substr(name, 1, 1) ǥ������ ����ؾ� �� (��Ī ��� �Ұ�) ex) GROUP BY �� �̷��� �ȵ�
SELECT * FROM customer;
SELECT substr(name, 1, 1) ��, COUNT(*) �ο� FROM customer GROUP BY substr(name, 1, 1);


--Task5_0520. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT orderdate+10 AS Ȯ������ FROM orders;
--����� ���� ����5
SELECT orderid, orderdate AS �ֹ���, orderdate + 10 AS Ȯ������ FROM orders;


--Task6_0520.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT orderid, custid, orderdate, bookid FROM orders WHERE orderdate = '20-07-07';
--����� ���� ����6
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'YYYY-MM-DD day') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders WHERE orderdate = '2020-07-07';
SELECT orderid �ֹ���ȣ, orderdate �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders WHERE orderdate = TO_DATE('2020/07/07', 'YYYY/MM/DD');



--Task7_0520. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT AVG(saleprice) AS "���" FROM orders;
SELECT o1.orderid, o1.saleprice FROM orders o1
WHERE o1.saleprice <= (SELECT AVG(o2.saleprice) FROM orders o2);
--����� ���� ����7
SELECT orderid, saleprice FROM orders
WHERE saleprice <= (SELECT avg(saleprice) FROM orders);
--���������� o2��� ��Ī���� ����, saleprice�� ��հ��� avg_saleprice�� ���
SELECT o1.orderid, o1.saleprice FROM orders o1
JOIN (SELECT AVG(saleprice) AS avg_saleprice FROM orders) o2
ON o1.saleprice <= o2.avg_saleprice;

SELECT o1.orderid, o1.saleprice, o2.��հ� FROM orders o1
JOIN (SELECT AVG(saleprice) AS ��հ� FROM orders) o2
ON o1.saleprice <= o2.��հ�;


--Task8_0520. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) "���Ǹŷ�" FROM orders WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '���ѹα�%');
--����� ���� ����8
SELECT SUM(saleprice) "���Ǹž�" FROM orders WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '���ѹα�%');