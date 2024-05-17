
SELECT bookid FROM book;
SELECT bookid, price FROM book;
SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM imported_book;
SELECT * FROM orders;

--�ߺ����� ���
SELECT DISTINCT publisher FROM book;

--Q. ������ 10,000�� �̻��� ������ �˻�
SELECT * FROM book WHERE price > 10000;

--Q. ������ 10,000�� �̻� 20,000������ ������ �˻��Ͻÿ�(2���� ���)
SELECT * FROM book WHERE 10000 <= price AND price <= 20000;
SELECT * FROM book WHERE price BETWEEN 10000 AND 20000;


-- LIKE�� ��Ȯ�� '�౸�� ����'�� ��ġ�ϴ� �ุ ����
SELECT bookname, publisher FROM book WHERE bookname LIKE '�౸�� ����';

-- '�౸'�� ���� �� ���ǻ�
SELECT bookname, publisher FROM book WHERE bookname LIKE '%�౸%';

-- �����̸��� ���� �� ���� ��ġ�� '��'��� ���ڿ��� ���� ����
SELECT bookname, publisher FROM book WHERE bookname LIKE '%_��%';


-- �����̸��� ������ �ø��������� ����
SELECT * FROM book ORDER BY bookname;
SELECT * FROM book ORDER BY price;
-- ������������ ����
SELECT * FROM book ORDER BY price DESC;

--Q. ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�(������ ���� ����ȴ�)
SELECT * FROM book ORDER BY price, bookname;

--Q. Ŀ���� ���̵� 2���� ���� �հ�
SELECT SUM(saleprice) AS "�� �Ǹž�" FROM orders WHERE custid = 2;

--GROUP BY : �����͸� Ư�� ���ؿ� ���� �׷�ȭ�ϴµ� ���. �̸� ���� ���� �ռ�(SUM, AVG, MAX, MIN, COUNT)�� �̿�, ���
SELECT SUM(saleprice) AS total, 
AVG(saleprice) AS average,
MIN(saleprice) AS minimum,
MAX(saleprice) AS maximun FROM orders;

--Q. �� �Ǹž��� custid �������� �׷�ȭ
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�" 
FROM orders GROUP BY custid;

-- bookid�� 5���� ū ����
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE bookid > 5
GROUP BY custid;

-- ���������� 2���� ū ����
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE bookid > 5
GROUP BY custid
HAVING COUNT(*) > 2;

