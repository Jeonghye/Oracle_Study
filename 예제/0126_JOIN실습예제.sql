-- �Լ� ���� ����
--1. ������� �ֹι�ȣ�� ��ȸ��
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******
SELECT
       EMP_NAME
     , SUBSTR(EMP_NO, 1, 8) || '******'
  FROM EMPLOYEE;

--2. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT
       EMP_NAME ������
     , JOB_CODE �����ڵ�
     , TO_CHAR(SALARY * (1 + NVL(BONUS,'0')) * 12, 'L999,999,999') AS "����(��)"
  FROM EMPLOYEE;

--3. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--	��� ����� �μ��ڵ� �Ի��� ��ȸ
SELECT
       EMP_ID ���
     , EMP_NAME �����
     , DEPT_CODE �μ��ڵ�
     , HIRE_DATE �Ի���
  FROM EMPLOYEE
 WHERE DEPT_CODE BETWEEN 'D5' AND 'D9'
   AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;

--4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--  ��, �ָ��� ������
SELECT
       EMP_NAME
     , HIRE_DATE
     , LAST_DAY(HIRE_DATE) - HIRE_DATE + 1
  FROM EMPLOYEE;


--5. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--     ������ ������ �����Ϸ� ��µǰ� ��.
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
SELECT
       EMP_NAME ������
     , DEPT_CODE �μ��ڵ�
     , TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YYMMDD'), 'YY"��" MM"��" DD"��') �������
     , EXTRACT(YEAR FROM SYSDATE) - (SUBSTR(EMP_NO, 1, 2) + 1900) "����(��)"
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO, 3, 2) < 13
   AND SUBSTR(EMP_NO, 5, 2) < 32; 
   
--6. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�. (��ǰ)                                                 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => to_char, decode, COUNT ���
--
--	-------------------------------------------------------------
--	��ü������   2001��   2002��   2003��   2004��
--	-------------------------------------------------------------
SELECT
       COUNT(*) ��ü�ο���
     , COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YY'), '01', '1')) AS "2001��"
     , COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YY'), '02', '1')) AS "2002��"
     , COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YY'), '03', '1')) AS "2003��"
     , COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YY'), '04', '1')) AS "2004��"
  FROM EMPLOYEE;


--7.  �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ��
--  => case ���
--	�μ��ڵ� ���� �������� ������.
SELECT
       EMP_ID ���
     , EMP_NAME �̸�
     , EMP_NO �ֹι�ȣ
     , EMAIL �̸���
     , PHONE ��ȭ��ȣ
     , CASE
        WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
        WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
        WHEN DEPT_CODE = 'D9' THEN '������'
       END AS �μ��ڵ�
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
    OR DEPT_CODE = 'D6'
    OR DEPT_CODE = 'D9'
 ORDER BY DEPT_CODE;


-- JOIN ��������

-- 1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE(20201225, 'YYYYMMDD'), 'DAY') "2020��12��25��" FROM DUAL;

-- 2. �ֹι�ȣ�� 70��� ���̸鼭 ������ �����̰�, 
--    ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
-- ANSI ǥ��
SELECT
       E.EMP_NAME
     , E.EMP_NO
     , D.DEPT_TITLE
     , J.JOB_NAME
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE) 
 WHERE (SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 80)
   AND SUBSTR(EMP_NO, 8, 1) = 2;
     
-- ����Ŭ ����
SELECT
       E.EMP_NAME
     , E.EMP_NO
     , D.DEPT_TITLE
     , J.JOB_NAME
  FROM EMPLOYEE E
     , DEPARTMENT D
     , JOB J
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND E.JOB_CODE = J.JOB_CODE
   AND (SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 80)
   AND SUBSTR(EMP_NO, 8, 1) = 2;
   
      
-- 3. ���� ���̰� ���� ������ ���, �����, 
--    ����, �μ���, ���޸��� ��ȸ�Ͻÿ�.
-- ANSI ǥ��
SELECT
       E.EMP_ID ���
     , E.EMP_NAME �����
     , EXTRACT(YEAR FROM SYSDATE) - (1900 + SUBSTR(EMP_ID, 1, 2)) ����
     , D.DEPT_TITLE �μ���
     , J.JOB_NAME ���޸�
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);
              
-- ORACLE ����
SELECT
       E.EMP_ID ���
     , E.EMP_NAME �����
     , EXTRACT(YEAR FROM SYSDATE) - (1900 + SUBSTR(EMP_ID, 1, 2)) ����
     , D.DEPT_TITLE �μ���
     , J.JOB_NAME ���޸�
  FROM EMPLOYEE E
     , DEPARTMENT D
     , JOB J
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND E.JOB_CODE = J.JOB_CODE;

-- 4. �̸��� '��'�ڰ� ���� ��������
-- ���, �����, �μ����� ��ȸ�Ͻÿ�.
-- ANSI ǥ��
SELECT
       E.EMP_ID ���
     , E.EMP_NAME �����
     , D.DEPT_TITLE �μ���
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
 WHERE E.EMP_NAME LIKE '%��%';

-- ����Ŭ ����
SELECT
       E.EMP_ID ���
     , E.EMP_NAME �����
     , D.DEPT_TITLE �μ���
  FROM EMPLOYEE E
     , DEPARTMENT D
 WHERE E.EMP_NAME LIKE '%��%'
   AND E.DEPT_CODE = D.DEPT_ID;


-- 5. �ؿܿ������� �ٹ��ϴ� �����, 
--    ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
-- ANSIǥ��
SELECT
       D.DEPT_TITLE ���޸�
     , E.DEPT_CODE �μ��ڵ�
     , D.DEPT_TITLE �μ���
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
 WHERE D.DEPT_TITLE LIKE '�ؿܿ���%';

-- ����Ŭ ����
SELECT
       D.DEPT_TITLE ���޸�
     , E.DEPT_CODE �μ��ڵ�
     , D.DEPT_TITLE �μ���
  FROM EMPLOYEE E
     , DEPARTMENT D
 WHERE D.DEPT_TITLE LIKE '�ؿܿ���%'
   AND E.DEPT_CODE = D.DEPT_ID;

-- 6. ���ʽ�����Ʈ�� �޴� �������� �����, 
--    ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
-- ANSIǥ��
SELECT
       E.BONUS ���ʽ�����Ʈ
     , D.DEPT_TITLE �μ���
     , L.LOCAL_NAME �ٹ�������
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
 WHERE BONUS IS NOT NULL;
 

-- ����Ŭ ����
SELECT
       E.BONUS ���ʽ�����Ʈ
     , D.DEPT_TITLE �μ���
     , L.LOCAL_NAME �ٹ�������
  FROM EMPLOYEE E
     , DEPARTMENT D
     , LOCATION L
 WHERE BONUS IS NOT NULL
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE;

-- 7. �μ��ڵ尡 D2�� �������� �����, 
--    ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
-- ANSI ǥ��
SELECT
       J.JOB_NAME ���޸�
     , D.DEPT_TITLE �μ���
     , L.LOCAL_NAME �ٹ�������
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
 WHERE E.DEPT_CODE = 'D2';

-- ����Ŭ ����
SELECT
       J.JOB_NAME ���޸�
     , D.DEPT_TITLE �μ���
     , L.LOCAL_NAME �ٹ�������
  FROM EMPLOYEE E
     , JOB J
     , DEPARTMENT D
     , LOCATION L
 WHERE E.DEPT_CODE = 'D2'
   AND E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE;


-- 8. ���� �޿� ����� �ּұ޿�(MIN_SAL)�� �ʰ��Ͽ� �޿��� �޴� ��������
--    �����, ���޸�, �޿�, ���ʽ����� ������ ��ȸ�Ͻÿ�.
--    ������ ���ʽ�����Ʈ�� �����Ͻÿ�.
-- ANSI ǥ��
SELECT
       E.EMP_NAME �����
     , J.JOB_NAME ���޸�
     , E.SALARY �޿�
     , ((E.SALARY * (1 + NVL(E.BONUS,0))) * 12) ���ʽ����Կ���
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  JOIN SAL_GRADE S ON(E.SAL_LEVEL = S.SAL_LEVEL)
 WHERE SALARY > S.MIN_SAL;

-- ����Ŭ ����
SELECT
       E.EMP_NAME �����
     , J.JOB_NAME ���޸�
     , E.SALARY �޿�
     , ((E.SALARY * (1 + NVL(E.BONUS,0))) * 12) ���ʽ����Կ���
  FROM EMPLOYEE E
     , JOB J
     , SAL_GRADE S
 WHERE SALARY > S.MIN_SAL
   AND E.JOB_CODE = J.JOB_CODE
   AND E.SAL_LEVEL = S.SAL_LEVEL;

-- 9. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
--    �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
-- ANSI ǥ��
SELECT
       E.EMP_NAME �����
     , D.DEPT_TITLE �μ���
     , L.LOCAL_NAME ������
     , N.NATIONAL_NAME ������
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
  JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
 WHERE N.NATIONAL_CODE = 'KO'
    OR N.NATIONAL_CODE = 'JP';
       
-- ����Ŭ ����
SELECT
       E.EMP_NAME �����
     , D.DEPT_TITLE �μ���
     , L.LOCAL_NAME ������
     , N.NATIONAL_NAME ������
  FROM EMPLOYEE E
     , DEPARTMENT D
     , LOCATION L
     , NATIONAL N
 WHERE (N.NATIONAL_CODE = 'KO'
    OR N.NATIONAL_CODE = 'JP')
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- 10. ���� �μ��� �ٹ��ϴ� �������� �����, �μ��ڵ�, 
--     �����̸��� ��ȸ�Ͻÿ�.self join ���
-- ANSI ǥ��
SELECT
       E2.EMP_NAME �����
     , E1.DEPT_CODE �μ��ڵ�
     , E1.EMP_NAME �����̸�
  FROM EMPLOYEE E1
  JOIN EMPLOYEE E2 ON (E1.DEPT_CODE = E2.DEPT_CODE);
  

-- ����Ŭ ����
SELECT
       E2.EMP_NAME �����
     , E1.DEPT_CODE �μ��ڵ�
     , E1.EMP_NAME �����̸�
  FROM EMPLOYEE E1
     , EMPLOYEE E2
 WHERE E1.DEPT_CODE = E2.DEPT_CODE;

-- 11. ���ʽ�����Ʈ�� ���� ������ �߿��� �����ڵ尡 
--     J4�� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
--     ��, join�� IN ����� ��
-- ANSI ǥ��
SELECT
       E.EMP_NAME �����
     , J.JOB_NAME ���޸�
     , E.SALARY �޿�
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE J.JOB_CODE IN('J4', 'J7')
   AND E.BONUS IS NULL;

-- ����Ŭ ����
SELECT
       E.EMP_NAME �����
     , J.JOB_NAME ���޸�
     , E.SALARY �޿�
  FROM EMPLOYEE E
     , JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND J.JOB_CODE IN('J4', 'J7')
   AND E.BONUS IS NULL;

--12. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
SELECT
       COUNT(CASE WHEN ENT_DATE IS NULL THEN 1 END) ������������
     , COUNT(ENT_DATE) ����������Ǽ�
  FROM EMPLOYEE;