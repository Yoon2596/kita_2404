--TASK1_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� ������ �˻��Ͻÿ�(3���� ���)
SELECT * FROM book WHERE publisher = '�½�����' OR publisher = '���ѹ̵��';
SELECT * FROM book WHERE publisher LIKE '�½�����' OR publisher LIKE '���ѹ̵��';
SELECT * FROM book WHERE publisher IN '�½�����' OR publisher IN '���ѹ̵��';

--����� ���� ���� 1
SELECT * FROM book WHERE publisher = '�½�����' OR publisher = '���ѹ̵��';
SELECT * FROM book WHERE publisher IN ('�½�����', '���ѹ̵��');
SELECT * FROM book WHERE publisher = '�½�����' UNION SELECT * FROM book WHERE publisher = '���ѹ̵��';


--TASK2_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� �ƴ� ������ �˻��Ͻÿ�
SELECT bookname FROM book WHERE publisher != '�½�����' AND publisher != '���ѹ̵��';
SELECT bookname FROM book WHERE publisher <> '�½�����' AND publisher <> '���ѹ̵��';

--����� ���� ���� 2
SELECT * FROM book WHERE publisher NOT IN ('�½�����', '���ѹ̵��');

--TASK3_0517. �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�
SELECT bookname FROM book WHERE bookname LIKE '%�౸%' AND price >= 20000; 

--����� ���� ���� 3
SELECT * FROM book WHERE bookname LIKE '%�౸%' AND price >= 20000; 

--Task4_0517. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) AS "�� �Ǹž�" FROM orders WHERE custid = 2;

--����� ���� ���� 4
SELECT customer.name, orders.custid, SUM(orders.saleprice) AS "�� �Ǹž�" FROM orders, customer
WHERE orders.custid = 2 AND orders.custid = customer.custid GROUP BY customer.name, orders.custid;

SELECT customer.name, orders.custid, SUM(orders.saleprice) FROM orders INNER JOIN customer on orders.custid = customer.custid
WHERE orders.custid = 2 GROUP BY customer.name, orders.custid;

-- ���� ���� �߰��� ����
SELECT customer.name, orders.custid, COUNT(orders.orderid) AS "���� ����", SUM(orders.saleprice) AS "�� �Ǹž�" FROM orders, customer
WHERE orders.custid = 2 AND orders.custid = customer.custid GROUP BY customer.name, orders.custid;

--Task5_0517. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT custid, COUNT(*) AS �������� FROM orders WHERE saleprice >= 8000 GROUP BY custid HAVING COUNT(*) >= 2 ORDER BY custid;

--����� ���� ���� 5
SELECT custid, COUNT(*) AS �������� FROM orders WHERE saleprice >= 8000 GROUP BY custid HAVING COUNT(*) >= 2;

--Task6_0517. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT custid, saleprice FROM orders custid ORDER BY custid;

--����� ���� ���� 6
SELECT name, saleprice FROM customer, orders WHERE customer.custid = orders.custid;

-- ���ڷ� ����
SELECT name, saleprice FROM customer C, orders O WHERE C.custid = O.custid;

--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT custid, SUM(saleprice) AS "�� �ֹ� ����", COUNT(*) AS "�� �ֹ� ����" FROM orders GROUP BY custid ORDER BY custid;

--����� ���� ���� 7
SELECT custid, SUM(saleprice) AS "�� �ֹ� ����" FROM orders GROUP BY custid ORDER BY custid;

--�Ǹž� �������� ���Ľ�
SELECT custid, SUM(saleprice) AS "�� �ֹ� ����" FROM orders GROUP BY custid ORDER BY "�� �ֹ� ����" DESC;