
--Ư�� ���̺��� �̿��ϴ� ���� �ƴϱ� ������ FROM �ڿ� dual�� ����
--���밪
SELECT ABS(-70), ABS(+78) FROM dual;

--�ݿø�
SELECT ROUND(4.875, 2) FROM dual;
--2�̸� �ڷ� �Ҽ����̴ϱ� �ݴ�� -2�̸� ���ڸ����� �ݿø� �ȴ�
SELECT ROUND(1240, -2) FROM dual;

--���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�
SELECT * FROM orders;   
SELECT custid AS ����ȣ, ROUND(AVG(saleprice), -2) AS ����ֹ��ݾ� FROM orders GROUP BY custid;

--'�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT bookname ����, length(bookname) ���ڼ�, length(bookname) ����Ʈ�� FROM book WHERE publisher = '�½�����';

--���缭���� �ֹ��Ϸκ��� 2���� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�
SELECT orderid, orderdate AS �ֹ���, orderdate+ 62 AS Ȯ������ FROM orders;
SELECT orderid, orderdate AS �ֹ���, ADD_MONTHS(orderdate, 2) AS Ȯ������ FROM orders;

--substr(name, 1, 1) �Լ��� ���ڿ� name�� ù ���� ���ں��� �����Ͽ� �� ���ڸ� ��ȯ
--GROUP BY ������ substr(name, 1, 1) ǥ������ ����ؾ� �� (��Ī ��� �Ұ�) ex) GROUP BY �� �̷��� �ȵ�
SELECT * FROM customer;
SELECT substr(name, 1, 1) ��, COUNT(*) �ο� FROM customer GROUP BY substr(name, 1, 1);


--�������� ������� ��¥ ǥ�ð� �����ϴ�
--WHERE orderdate = TO_DATE('20/07/07', 'YY/MM/DD');
--WHERE orderdate = TO_DATE('20/07/24 days', 'DD/MM/YY');

--Q. DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') SYSDATE1 FROM dual;

--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� '����ó����'���� ǥ���Ͻÿ�
-- NVL �Լ��� ���� NULL�� ��� �������� ����ϰ�, NULL�� �ƴϸ� ���� ���� �״�� ����Ѵ�. �Լ� : NVL("��", "������")
SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ FROM customer;

--Q. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �θ� ���̽ÿ�.
-- ROWNUM : ����Ŭ���� �ڵ����� �����ϴ� ���� ���� ������ ����Ǵ� ���� �� �࿡ �Ϸù�ȣ�� �ڵ����� �Ҵ�.
SELECT rownum ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ FROM customer WHERE rownum < 3;
SELECT * FROM orders;


