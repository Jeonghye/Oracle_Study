-- 함수 연습 문제
--1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
SELECT
       EMP_NAME
     , SUBSTR(EMP_NO, 1, 8) || '******'
  FROM EMPLOYEE;

--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT
       EMP_NAME 직원명
     , JOB_CODE 직급코드
     , TO_CHAR(SALARY * (1 + NVL(BONUS,'0')) * 12, 'L999,999,999') AS "연봉(원)"
  FROM EMPLOYEE;

--3. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 
--	사번 사원명 부서코드 입사일 조회
SELECT
       EMP_ID 사번
     , EMP_NAME 사원명
     , DEPT_CODE 부서코드
     , HIRE_DATE 입사일
  FROM EMPLOYEE
 WHERE DEPT_CODE BETWEEN 'D5' AND 'D9'
   AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;

--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--  단, 주말도 포함함
SELECT
       EMP_NAME
     , HIRE_DATE
     , LAST_DAY(HIRE_DATE) - HIRE_DATE + 1
  FROM EMPLOYEE;


--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서, 
--     ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
SELECT
       EMP_NAME 직원명
     , DEPT_CODE 부서코드
     , TO_CHAR(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YYMMDD'), 'YY"년" MM"월" DD"일') 생년월일
     , EXTRACT(YEAR FROM SYSDATE) - (SUBSTR(EMP_NO, 1, 2) + 1900) "나이(만)"
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO, 3, 2) < 13
   AND SUBSTR(EMP_NO, 5, 2) < 32; 
   
--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오. (못품)                                                 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, COUNT 사용
--
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------
SELECT
       COUNT(*) 전체인원수
     , COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YY'), '01', '1')) AS "2001년"
     , COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YY'), '02', '1')) AS "2002년"
     , COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YY'), '03', '1')) AS "2003년"
     , COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YY'), '04', '1')) AS "2004년"
  FROM EMPLOYEE;


--7.  부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
--  => case 사용
--	부서코드 기준 오름차순 정렬함.
SELECT
       EMP_ID 사번
     , EMP_NAME 이름
     , EMP_NO 주민번호
     , EMAIL 이메일
     , PHONE 전화번호
     , CASE
        WHEN DEPT_CODE = 'D5' THEN '총무부'
        WHEN DEPT_CODE = 'D6' THEN '기획부'
        WHEN DEPT_CODE = 'D9' THEN '영업부'
       END AS 부서코드
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D5'
    OR DEPT_CODE = 'D6'
    OR DEPT_CODE = 'D9'
 ORDER BY DEPT_CODE;


-- JOIN 연습문제

-- 1. 2020년 12월 25일이 무슨 요일인지 조회하시오.
SELECT TO_CHAR(TO_DATE(20201225, 'YYYYMMDD'), 'DAY') "2020년12월25일" FROM DUAL;

-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- ANSI 표준
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
     
-- 오라클 전용
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
   
      
-- 3. 가장 나이가 적은 직원의 사번, 사원명, 
--    나이, 부서명, 직급명을 조회하시오.
-- ANSI 표준
SELECT
       E.EMP_ID 사번
     , E.EMP_NAME 사원명
     , EXTRACT(YEAR FROM SYSDATE) - (1900 + SUBSTR(EMP_ID, 1, 2)) 나이
     , D.DEPT_TITLE 부서명
     , J.JOB_NAME 직급명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);
              
-- ORACLE 전용
SELECT
       E.EMP_ID 사번
     , E.EMP_NAME 사원명
     , EXTRACT(YEAR FROM SYSDATE) - (1900 + SUBSTR(EMP_ID, 1, 2)) 나이
     , D.DEPT_TITLE 부서명
     , J.JOB_NAME 직급명
  FROM EMPLOYEE E
     , DEPARTMENT D
     , JOB J
 WHERE E.DEPT_CODE = D.DEPT_ID
   AND E.JOB_CODE = J.JOB_CODE;

-- 4. 이름에 '형'자가 들어가는 직원들의
-- 사번, 사원명, 부서명을 조회하시오.
-- ANSI 표준
SELECT
       E.EMP_ID 사번
     , E.EMP_NAME 사원명
     , D.DEPT_TITLE 부서명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
 WHERE E.EMP_NAME LIKE '%형%';

-- 오라클 전용
SELECT
       E.EMP_ID 사번
     , E.EMP_NAME 사원명
     , D.DEPT_TITLE 부서명
  FROM EMPLOYEE E
     , DEPARTMENT D
 WHERE E.EMP_NAME LIKE '%형%'
   AND E.DEPT_CODE = D.DEPT_ID;


-- 5. 해외영업팀에 근무하는 사원명, 
--    직급명, 부서코드, 부서명을 조회하시오.
-- ANSI표준
SELECT
       D.DEPT_TITLE 직급명
     , E.DEPT_CODE 부서코드
     , D.DEPT_TITLE 부서명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
 WHERE D.DEPT_TITLE LIKE '해외영업%';

-- 오라클 전용
SELECT
       D.DEPT_TITLE 직급명
     , E.DEPT_CODE 부서코드
     , D.DEPT_TITLE 부서명
  FROM EMPLOYEE E
     , DEPARTMENT D
 WHERE D.DEPT_TITLE LIKE '해외영업%'
   AND E.DEPT_CODE = D.DEPT_ID;

-- 6. 보너스포인트를 받는 직원들의 사원명, 
--    보너스포인트, 부서명, 근무지역명을 조회하시오.
-- ANSI표준
SELECT
       E.BONUS 보너스포인트
     , D.DEPT_TITLE 부서명
     , L.LOCAL_NAME 근무지역명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
 WHERE BONUS IS NOT NULL;
 

-- 오라클 전용
SELECT
       E.BONUS 보너스포인트
     , D.DEPT_TITLE 부서명
     , L.LOCAL_NAME 근무지역명
  FROM EMPLOYEE E
     , DEPARTMENT D
     , LOCATION L
 WHERE BONUS IS NOT NULL
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE;

-- 7. 부서코드가 D2인 직원들의 사원명, 
--    직급명, 부서명, 근무지역명을 조회하시오.
-- ANSI 표준
SELECT
       J.JOB_NAME 직급명
     , D.DEPT_TITLE 부서명
     , L.LOCAL_NAME 근무지역명
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
 WHERE E.DEPT_CODE = 'D2';

-- 오라클 전용
SELECT
       J.JOB_NAME 직급명
     , D.DEPT_TITLE 부서명
     , L.LOCAL_NAME 근무지역명
  FROM EMPLOYEE E
     , JOB J
     , DEPARTMENT D
     , LOCATION L
 WHERE E.DEPT_CODE = 'D2'
   AND E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE;


-- 8. 본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의
--    사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오.
--    연봉에 보너스포인트를 적용하시오.
-- ANSI 표준
SELECT
       E.EMP_NAME 사원명
     , J.JOB_NAME 직급명
     , E.SALARY 급여
     , ((E.SALARY * (1 + NVL(E.BONUS,0))) * 12) 보너스포함연봉
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
  JOIN SAL_GRADE S ON(E.SAL_LEVEL = S.SAL_LEVEL)
 WHERE SALARY > S.MIN_SAL;

-- 오라클 전용
SELECT
       E.EMP_NAME 사원명
     , J.JOB_NAME 직급명
     , E.SALARY 급여
     , ((E.SALARY * (1 + NVL(E.BONUS,0))) * 12) 보너스포함연봉
  FROM EMPLOYEE E
     , JOB J
     , SAL_GRADE S
 WHERE SALARY > S.MIN_SAL
   AND E.JOB_CODE = J.JOB_CODE
   AND E.SAL_LEVEL = S.SAL_LEVEL;

-- 9. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--    사원명, 부서명, 지역명, 국가명을 조회하시오.
-- ANSI 표준
SELECT
       E.EMP_NAME 사원명
     , D.DEPT_TITLE 부서명
     , L.LOCAL_NAME 지역명
     , N.NATIONAL_NAME 국가명
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
  JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
 WHERE N.NATIONAL_CODE = 'KO'
    OR N.NATIONAL_CODE = 'JP';
       
-- 오라클 전용
SELECT
       E.EMP_NAME 사원명
     , D.DEPT_TITLE 부서명
     , L.LOCAL_NAME 지역명
     , N.NATIONAL_NAME 국가명
  FROM EMPLOYEE E
     , DEPARTMENT D
     , LOCATION L
     , NATIONAL N
 WHERE (N.NATIONAL_CODE = 'KO'
    OR N.NATIONAL_CODE = 'JP')
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE;

-- 10. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 
--     동료이름을 조회하시오.self join 사용
-- ANSI 표준
SELECT
       E2.EMP_NAME 사원명
     , E1.DEPT_CODE 부서코드
     , E1.EMP_NAME 동료이름
  FROM EMPLOYEE E1
  JOIN EMPLOYEE E2 ON (E1.DEPT_CODE = E2.DEPT_CODE);
  

-- 오라클 전용
SELECT
       E2.EMP_NAME 사원명
     , E1.DEPT_CODE 부서코드
     , E1.EMP_NAME 동료이름
  FROM EMPLOYEE E1
     , EMPLOYEE E2
 WHERE E1.DEPT_CODE = E2.DEPT_CODE;

-- 11. 보너스포인트가 없는 직원들 중에서 직급코드가 
--     J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
--     단, join과 IN 사용할 것
-- ANSI 표준
SELECT
       E.EMP_NAME 사원명
     , J.JOB_NAME 직급명
     , E.SALARY 급여
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE J.JOB_CODE IN('J4', 'J7')
   AND E.BONUS IS NULL;

-- 오라클 전용
SELECT
       E.EMP_NAME 사원명
     , J.JOB_NAME 직급명
     , E.SALARY 급여
  FROM EMPLOYEE E
     , JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
   AND J.JOB_CODE IN('J4', 'J7')
   AND E.BONUS IS NULL;

--12. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT
       COUNT(CASE WHEN ENT_DATE IS NULL THEN 1 END) 재직중인직원
     , COUNT(ENT_DATE) 퇴사한직원의수
  FROM EMPLOYEE;