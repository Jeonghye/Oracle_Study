-- �׷��Լ��� �������Լ�
-- ������ �Լ�(SINGLE ROW FUNCTION) : N���� ���� �־� N���� ��� ����
-- �׷� �Լ� (GROUP FUNCTION) : N���� ���� �־� 1���� ��� ����

-- �׷� �Լ� : SUM, AVG, MAX, MIN, COUNT

-- SUM(����) : �հ踦 ���Ͽ� ����
SELECT
       SUM(SALARY)
  FROM EMPLOYEE;
  
-- AVG(����) : ����� ���Ͽ� ����
SELECT
       AVG(SALARY)
  FROM EMPLOYEE;
  
-- MIN(���� | ���� | ��¥) : ���� ���� �� ����
SELECT
       MIN(EMAIL)
     , MIN(HIRE_DATE)
     , MIN(SALARY)
  FROM EMPLOYEE;
  
-- MAX(���� | ���� | ��¥) : ���� ū �� ����
SELECT
       MAX(EMAIL)
     , MAX(HIRE_DATE)
     , MAX(SALARY)
  FROM EMPLOYEE;
  
SELECT
       AVG(BONUS) ���ʽ��޴»�������
     , AVG(NVL(BONUS, 0)) ���������
  FROM EMPLOYEE;
  
-- COUNT(* | �÷���)
-- COUNT(*) : ��� ���� �� ����
-- COUNT(�÷���) : NULL�� ������ ���� ���� ��ϵ� ���� �� ����
SELECT
       COUNT(*)
     , COUNT(DEPT_CODE)
     , COUNT(DISTINCT DECT_CODE) �ߺ�������
  FROM EMPLOYEE;
  
-- ������ �Լ�
-- ���� ���� �Լ�
-- : LENGTH, LENGTHB(�� ���ڹ���Ʈ(3)), SUBSTR, UPPER, LOWER, INSTR...
SELECT
       LENGTH('����Ŭ')
     , LENGTHB('����Ŭ')
  FROM DUAL;           -- DUMMY TABLE ��¥
  
SELECT
       LENGTH(EMAIL)
     , LENGTH(EMAIL)
  FROM EMPLOYEE;
  
-- INSTR('���ڿ�' | �÷���, '���ڿ�', ã�� ��ġ�� ���۰�(-1 �����ʺ���), [��])
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;

SELECT
       EMAIL
     , INSTR(EMAIL, '@', -1) ��ġ
  FROM EMPLOYEE;

SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE INSTR(EMP_NAME, '��') > 0;
 
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
  FROM EMPLOYEE;
  
-- LPAD / RPAD : �־��� ���ڿ��� ������ ���ڿ��� ���ٿ� ����N�� ���ڿ��� ��ȯ�ϴ� �Լ�
SELECT
       LPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;
  
SELECT
       RPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;
  
-- ���� ���ڿ� ���̺��� ª�� �� ������ �Է±��̸�ŭ ���ŵ� ������ ��ȯ
SELECT
     LPAD(EMAIL, 10)
  FROM EMPLOYEE;
  
SELECT
     RPAD(EMAIL, 10)
  FROM EMPLOYEE;
  
-- LTRIM / RTRIM : �־��� �÷��̳� ���ڿ� ����⿡��
--                 ������ ���ڸ� ������ �������� ��ȯ�ϴ� �Լ�
-- ������ ���ڿ��� ���ӵ� ���ڿ����ٴ� ���� �������� ����� �ȴ�.
SELECT '    GREEDY' FROM DUAL;
SELECT LTRIM('   GREEDY', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123GREEDY', '123') FROM DUAL;
SELECT LTRIM('123123GREEDY123123', '123') FROM DUAL;
SELECT LTRIM('ACABACCGREEY', 'ABC') FROM DUAL;
SELECT LTRIM('5782GREEDY', '0123456789') FROM DUAL;
SELECT LTRIM('6731GREEDY', '0123456789') FROM DUAL;

SELECT
       EMP_ID
     , EMP_NAME
  FROM EMPLOYEE
 WHERE EMP_NAME = RTRIM('������ ');
 
-- TRIM : �־��� �÷��̳� ���ڿ��� ��/�ڿ� ������ ���ڸ� ����(�⺻��:����)
SELECT TRIM('   GREEDY   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZ12345ZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZ12345ZZZ') FROM DUAL;
-- LEADING ���ʿ��� ���� / TRAILING �����ʿ��� ����
SELECT TRIM(BOTH '3' FROM '333GREEDY333') FROM DUAL;
-- BOTH �⺻������ ������

-- SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ�κ��� ������ ������ ���ڿ��� �߶� ����
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('��� �� �� �Ӵ�', 2, 5) FROM DUAL;

-- �������� �̸�, �ֹι�ȣ ��ȸ
SELECT
       EMP_NAME
     , EMP_NO
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
 
-- EMPLOYEE ���̺��� ������ �ֹι�ȣ�� ��ȸ�Ͽ�
-- �����, ����, ����, ������ ���� �и��Ͽ� ��ȸ
-- ��, �÷��� ��Ī�� �����, ����, ����, ���Ϸ� �Ѵ�.
SELECT
       EMP_NAME �����
     , SUBSTR(EMP_NO, 1, 2) ����
     , SUBSTR(EMP_NO, 3, 2) ����
     , SUBSTR(EMP_NO, 5, 2) ����
  FROM EMPLOYEE;
  
-- EMPLOYEE ���̺��� ��������
-- ������, �Ի�⵵, �Ի��, �Ի����� �и� ��ȸ
SELECT
       EMP_NAME ������
     , SUBSTR(HIRE_DATE, 1, 2) �Ի�⵵
     , SUBSTR(HIRE_DATE, 4, 2) �Ի��
     , SUBSTR(HIRE_DATE, 7, 2) �Ի���
  FROM EMPLOYEE;
  
-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������
-- ���, �̸�, �޿� ��ȸ
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY >= AVG(SALARY);
-- WHERE������ ������ �Լ��� ��� ����

SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE
                );

-- EMPLOYEE ���̺��� �����, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ� '-' ���� ���� '*'�� �ٲ㼭 ���
SELECT
       EMP_NAME �����
     , RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') �ֹι�ȣ
  FROM EMPLOYEE;

SELECT
       EMP_NAME �����
     , SUBSTR(EMP_NO, 1, 7) || '*******' �ֹι�ȣ
  FROM EMPLOYEE;
  
-- LOWER / UPPER / INITCAP : ��ҹ��� �������ִ� �Լ�
SELECT LOWER('Welcome To Hello World') FROM DUAL;
SELECT UPPER('Welcome To Hello World') FROM DUAL;
SELECT INITCAP('welcome to hello world') FROM DUAL;

-- CONCAT : ���ڿ� �� ���� �ϳ��� ���ڿ��� ��ģ �� ����
SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL;

-- REPLACE : �÷� Ȥ�� ���ڿ��� �Է¹޾� �����ϰ��� �ϴ� ���ڿ��� ������ ���ڿ��� �ٲ� �� ����
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;

-- ���� ó�� �Լ� : ABS, MOD, ROUND, FLOOR, TRUNC, CELL, ...
-- ABS(���� | �÷���) : ���밪 ���ϴ� �Լ�
SELECT
       ABS(-10)
     , ABS(10)
  FROM DUAL;
  
-- MOD(����, ����) : �� ���� ����� �������� ���ϴ� �Լ�
--                  ù ��° ���ڴ� ���������� ��, �� ��° ���ڴ� ���� ��
SELECT
       MOD(10, 5)
     , MOD(10, 3)
  FROM DUAL;
  
-- ����� ¦���� ������ ���, �̸�, �޿�, �μ��ڵ� ��ȸ
SELECT
       EMP_ID ���
     , EMP_NAME �̸�
     , SALARY �޿�
     , DEPT_CODE �μ��ڵ�
  FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2)= 0; 
 
-- ROUND(����, [��ġ]) : �ݿø��ؼ� �������ִ� �Լ�
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;

-- FLOOR(����) : ����ó���� �� ������ ��ȯ�ϴ� �Լ�
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC(����, [��ġ]) : ����ó��(����) �Լ�
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL(����) : �ø�ó�� �Լ�
SELECT CEIL(123.456) FROM DUAL;

-- ��¥ ó�� �Լ� : SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, EXTRACT, ...
-- SYSDATE : ���� ��¥�� �ð��� ��ȯ���ִ� �Լ�
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN(��¥, ��¥)
-- : �� ��¥�� ���� �� ���̸� ���ڷ� �����ϴ� �Լ� (ù ��° ���ڰ� �ֽ��̾�� �� ��)
SELECT
       EMP_NAME
     , HIRE_DATE
     , CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
  FROM EMPLOYEE;
  
SELECT
       SYSDATE + 1
     , SYSDATE - 1
     , SYSDATE - HIRE_DATE
  FROM EMPLOYEE;
  
-- ADD_MONTHS (��¥, ����)
-- : ��¥�� �Է��� �������� ���ؼ� ����
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;
  
-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 6������ �Ǵ� ��¥ ��ȸ
SELECT
       EMP_NAME
     , HIRE_DATE
     , ADD_MONTHS(HIRE_DATE, 6)
  FROM EMPLOYEE;
  
-- EMPLOYEE ���̺��� �ٹ� ����� 20�� �̻��� ���� ��ȸ
SELECT 
       *
  FROM EMPLOYEE 
 WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- NEXT_DAY(���س�¥, ����)
-- : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥ ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;
-- ����Ŭ ������ �ѱ���� �Ǿ��־... FRIDAY�� �ȵ�...

-- LAST_DAY(��¥) : �ش� ���� ������ ��¥�� ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE ���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ��� ��ȸ�ϼ���
-- ��, �ָ��� ������� �ʴ´�.
SELECT
       EMP_NAME
     , HIRE_DATE
     , LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 �Ի����_�ٹ��ϼ�
  FROM EMPLOYEE;

-- EXTRACT : ��, ��, �� ������ �����ؼ� ����
-- EXTRACT(YEAR FROM ��¥) : �⵵�� ����
-- EXTRACT(MONTH FROM ��¥) : ���� ����
-- EXTRACT(DAY FROM ��¥) : ��¥(��)�� ����
SELECT
       EXTRACT(YEAR FROM SYSDATE) �⵵
     , EXTRACT(MONTH FROM SYSDATE) ��
     , EXTRACT(DAY FROM SYSDATE) ��
  FROM DUAL;
  
-- EMPLOYEE ���̺��� ����̸�, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT
       EMP_NAME ����̸�
     , EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵
     , EXTRACT(MONTH FROM HIRE_DATE) �Ի��
     , EXTRACT(DAY FROM HIRE_DATE) �Ի���
  FROM EMPLOYEE
--  ORDER BY ����̸�
 ORDER BY �Ի�⵵ ASC, �Ի�� DESC;
-- ORDER BY �Ի�⵵, �Ի�� DESC; ASC�� ������ ǥ���̱⿡ ���� �Ի�⵵�� ASC��

-- ORDER BY : ���� �������� ���� �����ϴ� ����, ��������(�⺻��) - ASC / �������� - DESC
--            ��Ī �Է� ����, ���� �Է� �� �÷��� �ε���
-- ��, ��Ī�� WHERE�������� ����� �� ����.

SELECT SYSDATE FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- ����ȯ �Լ�
-- TO_CHAR(��¥, [����]) : ��¥�� �����͸� ������ �����ͷ� ����
-- TO_CHAR(����, [����]) : ������ �����͸� ������ �����ͷ� ����

SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, '00000') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;
SELECT TO_CHAR(1234, '$99,999') FROM DUAL;
SELECT TO_CHAR(1234, '00,000') FROM DUAL;

-- ���� ���̺��� �����, �޿� ��ȸ
-- �޿��� '\9,000,000' �������� ǥ���ϼ���
SELECT
       EMP_NAME
     , TO_CHAR(SALARY, 'L99,999,999')
  FROM EMPLOYEE;

-- ��¥ �����Ϳ� ���� ����
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-FmMM-DD DAY') FROM DUAL;
-- FmMM 01 -> 1�� MM 1 -> 01��
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') �Ի���
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS') ���Ի���
     , TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') �Ի����ѱ�
  FROM EMPLOYEE;
  
-- �⵵(����) ����
SELECT
       TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'RRRR')
     , TO_CHAR(SYSDATE, 'YY')
     , TO_CHAR(SYSDATE, 'RR')
     , TO_CHAR(SYSDATE, 'YEAR')
  FROM DUAL;
  
-- YY�� RR�� ����
-- RR�� �� �ڸ��⵵�� ���ڸ��� ���� ��
--���� �⵵�� 50�� �̸��̸� 2000�� ����
-- 50�� �̻��̸� 1900��븦 �����Ѵ�.
SELECT
       TO_CHAR(TO_DATE('980630', 'YYMMDD')), 'YYYY-MM-DD'
     , TO_CHAR(TO_DATE('980630', 'RRMMDD')), 'RRRR-MM-DD'
  FROM DUAL;
  
-- �� ����
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MONTH')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'RM')
  FROM DUAL;
  
-- �� ����
SELECT
       TO_CHAR(SYSDATE, '"1�� ����" DDD "�� °')
     , TO_CHAR(SYSDATE, '"�� ����" DD "�� °')
     , TO_CHAR(SYSDATE, '"�� ����" D "�� °')
  FROM DUAL;
  
-- �б�� ����
SELECT
       TO_CHAR(SYSDATE, 'Q"�б�"')
     , TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')
  FROM DUAL;
  
-- ���� ���̺��� �̸�, �Ի��� ������
-- �Ի��Ͽ� ���� �����ؼ� ��ȸ
-- '2018�� 6�� 15�� (��)' �������� ����ϼ���
SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'RRRR"�� " fmMM"�� " DD"�� " "("DY")"')
  FROM EMPLOYEE;
  
-- TO_DATE : ���� Ȥ�� ������ �����͸� ��¥�� �����ͷ� ��ȯ�Ͽ� ����
SELECT
       TO_DATE('20101010', 'RRRRMMDD')
  FROM DUAL;
  
SELECT
       TO_CHAR(TO_DATE('20101010', 'RRRRMMDD'), 'RRRR, MON')
  FROM DUAL;
  
SELECT
       TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RR HH:MI:SS PM')
  FROM DUAL;
  
-- ���� ���̺��� 2000�⵵ ���Ŀ� �Ի��� �����
-- ���, �̸�, �Ի����� ��ȸ�ϼ���
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE HIRE_DATE >= TO_DATE(20000101, 'RRRRMMDD');
-- ���ڴ� ��¥�� �ڵ� ����ȯ ������, ���ڴ� ��¥�� �ڵ� ����ȯ �ȵ�

-- TO_NUMBER(����, [����]) : ���ڵ����͸� ���ڷ� ����
SELECT
       TO_NUMBER('123456789')
  FROM DUAL;
  
SELECT '123' + '456' FROM DUAL;

SELECT '123' + '456A' FROM DUAL;

SELECT '1,000,000' + '500,000' FROM DUAL;

SELECT
       TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999')
  FROM DUAL;
  
-- ���� ���̺��� �����ȣ�� 201�� �����
-- �̸�, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ��� ���ڸ��� ���� ��ȸ�ϼ���.
-- �� �ڵ�����ȯ�� ������� �ʰ� ��ȸ
SELECT
       EMP_NAME �̸�
     , EMP_NO
     , SUBSTR(EMP_NO, 1, 6) �պκ�
     , SUBSTR(EMP_NO, 8) �޺κ�
     , TO_NUMBER(SUBSTR(EMP_NO, 1, 6)) + TO_NUMBER(SUBSTR(EMP_NO, 8)) ��
  FROM EMPLOYEE
 WHERE EMP_ID = 201;
-- �ڵ�����ȯ ���ϴ°� ����

-- NULLó�� �Լ�
-- NVL(�÷���, �÷��� NULL�� ��� �ٲ� ��)
SELECT
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0)
  FROM EMPLOYEE;
  
-- NVL2(�÷���, �ٲܰ�1, �ٲܰ�2)
-- �ش� �÷��� ���� ������ �ٲܰ�1�� ����, NULL�̸� �ٲܰ�2�� ���� (�ణ IF����)

-- ���� �������� ���ʽ� ����Ʈ�� NULL�� ������ 0.5��
-- ���ʽ� ����Ʈ�� NULL�� �ƴ� ��� 0.7�� �����Ͽ� ��ȸ
SELECT
       EMP_NAME
     , BONUS
     , NVL2(BONUS, 0.7, 0.5)
  FROM EMPLOYEE;
  
-- �����Լ�
-- �������� ��쿡 ������ �� �ִ� ����� ����
-- DECODE(���� | �÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2, ...) CHOOSE���� 
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
--     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��')
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '��')
  FROM EMPLOYEE;
-- �������� �ִ� ���� ���� ���� ����

/* ������ �޿��� �λ��Ͽ� ��ȸ�Ϸ��� �Ѵ�.
   �����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
   �����ڵ尡 J6�� ������ �޿��� 15%�� �λ��ϰ�
   �����ڵ尡 J5�� ������ �޿��� 20%�� �λ��ϰ�
   �� �� ������ ������ 5%�� �λ��Ѵ�.
   ���� ���̺��� ������, �����ڵ�, �޿�, �λ�޿��� ��ȸ�ϼ���.
*/
SELECT
       EMP_NAME ������
     , JOB_CODE �����ڵ�
     , SALARY �޿�
     , DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15, 
                        'J5', SALARY * 1.2, 
                              SALARY * 1.05) �λ�޿�
  FROM EMPLOYEE;
  
-- CASE
--   WHEN ���ǽ� THEN �����
--   WHEN ���ǽ� THEN �����
-- END
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
     , CASE
        WHEN JOB_CODE = 'J7' THEN SALARY * 1.1
        WHEN JOB_CODE = 'J6' THEN SALARY * 1.15
        WHEN JOB_CODE = 'J5' THEN SALARY * 1.2
        ELSE SALARY * 1.05
      END AS �λ�޿�
  FROM EMPLOYEE;
  
-- ���, �����, �޿��� EMPLOYEE ���̺��� ��ȸ�ϰ�
-- �޿��� 500���� �ʰ��� '���'
-- �޿��� 300~500�����̸� '�߱�'
-- �� ���ϴ� '�ʱ�'���� ����ϵ��� �ϰ� ��Ī�� '����'���� �Ѵ�.
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , CASE
        WHEN SALARY > 5000000 THEN '���'
        WHEN SALARY BETWEEN 3000000 AND 5000000 THEN '�߱�'
        ELSE '�ʱ�'
      END AS ����
  FROM EMPLOYEE;