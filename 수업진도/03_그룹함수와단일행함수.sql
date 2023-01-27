-- 그룹함수와 단일행함수
-- 단일행 함수(SINGLE ROW FUNCTION) : N개의 값을 넣어 N개의 결과 리턴
-- 그룹 함수 (GROUP FUNCTION) : N개의 값을 넣어 1개의 결과 리턴

-- 그룹 함수 : SUM, AVG, MAX, MIN, COUNT

-- SUM(숫자) : 합계를 구하여 리턴
SELECT
       SUM(SALARY)
  FROM EMPLOYEE;
  
-- AVG(숫자) : 평균을 구하여 리턴
SELECT
       AVG(SALARY)
  FROM EMPLOYEE;
  
-- MIN(숫자 | 문자 | 날짜) : 가장 작은 값 리턴
SELECT
       MIN(EMAIL)
     , MIN(HIRE_DATE)
     , MIN(SALARY)
  FROM EMPLOYEE;
  
-- MAX(숫자 | 문자 | 날짜) : 가장 큰 값 리턴
SELECT
       MAX(EMAIL)
     , MAX(HIRE_DATE)
     , MAX(SALARY)
  FROM EMPLOYEE;
  
SELECT
       AVG(BONUS) 보너스받는사람들평균
     , AVG(NVL(BONUS, 0)) 전직원평균
  FROM EMPLOYEE;
  
-- COUNT(* | 컬럼명)
-- COUNT(*) : 모든 행의 수 리턴
-- COUNT(컬럼명) : NULL을 제외한 실제 값이 기록된 행의 수 리턴
SELECT
       COUNT(*)
     , COUNT(DEPT_CODE)
     , COUNT(DISTINCT DECT_CODE) 중복값제외
  FROM EMPLOYEE;
  
-- 단일행 함수
-- 문자 관련 함수
-- : LENGTH, LENGTHB(총 글자바이트(3)), SUBSTR, UPPER, LOWER, INSTR...
SELECT
       LENGTH('오라클')
     , LENGTHB('오라클')
  FROM DUAL;           -- DUMMY TABLE 가짜
  
SELECT
       LENGTH(EMAIL)
     , LENGTH(EMAIL)
  FROM EMPLOYEE;
  
-- INSTR('문자열' | 컬럼명, '문자열', 찾을 위치의 시작값(-1 오른쪽부터), [빈도])
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;

SELECT
       EMAIL
     , INSTR(EMAIL, '@', -1) 위치
  FROM EMPLOYEE;

SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE INSTR(EMP_NAME, '하') > 0;
 
SELECT
       EMP_NAME
     , EMAIL
     , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
  FROM EMPLOYEE;
  
-- LPAD / RPAD : 주어진 문자열에 임의의 문자열을 덧붙여 길이N의 문자열을 반환하는 함수
SELECT
       LPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;
  
SELECT
       RPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;
  
-- 기존 문자열 길이보다 짧을 시 강제로 입력길이만큼 제거된 나머지 반환
SELECT
     LPAD(EMAIL, 10)
  FROM EMPLOYEE;
  
SELECT
     RPAD(EMAIL, 10)
  FROM EMPLOYEE;
  
-- LTRIM / RTRIM : 주어진 컬럼이나 문자열 양방향에서
--                 지정한 문자를 제거한 나머지를 반환하는 함수
-- 지정한 문자열은 연속된 문자열보다는 글자 패턴으로 여기면 된다.
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
 WHERE EMP_NAME = RTRIM('선동일 ');
 
-- TRIM : 주어진 컬럼이나 문자열의 앞/뒤에 지정한 문자를 제거(기본값:공백)
SELECT TRIM('   GREEDY   ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZGREEDYZZZ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZ12345ZZZ') FROM DUAL;
SELECT TRIM(TRAILING 'Z' FROM 'ZZZ12345ZZZ') FROM DUAL;
-- LEADING 왼쪽에서 제거 / TRAILING 오른쪽에서 제거
SELECT TRIM(BOTH '3' FROM '333GREEDY333') FROM DUAL;
-- BOTH 기본값으로 묵시적

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치로부터 지정한 개수의 문자열을 잘라서 리턴
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('쇼오 미 더 머니', 2, 5) FROM DUAL;

-- 여직원의 이름, 주민번호 조회
SELECT
       EMP_NAME
     , EMP_NO
  FROM EMPLOYEE
 WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
 
-- EMPLOYEE 테이블에서 직원의 주민번호를 조회하여
-- 사원명, 생년, 생월, 생일을 각각 분리하여 조회
-- 단, 컬럼의 별칭은 사원명, 생년, 생월, 생일로 한다.
SELECT
       EMP_NAME 사원명
     , SUBSTR(EMP_NO, 1, 2) 생년
     , SUBSTR(EMP_NO, 3, 2) 생월
     , SUBSTR(EMP_NO, 5, 2) 생일
  FROM EMPLOYEE;
  
-- EMPLOYEE 테이블에서 직원들의
-- 직원명, 입사년도, 입사월, 입사일을 분리 조회
SELECT
       EMP_NAME 직원명
     , SUBSTR(HIRE_DATE, 1, 2) 입사년도
     , SUBSTR(HIRE_DATE, 4, 2) 입사월
     , SUBSTR(HIRE_DATE, 7, 2) 입사일
  FROM EMPLOYEE;
  
-- 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 급여 조회
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY >= AVG(SALARY);
-- WHERE절에는 단일행 함수만 사용 가능

SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM EMPLOYEE
                );

-- EMPLOYEE 테이블에서 사원명, 주민번호 조회
-- 단, 주민번호는 생년월일만 보이게 하고 '-' 다음 값은 '*'로 바꿔서 출력
SELECT
       EMP_NAME 사원명
     , RPAD(SUBSTR(EMP_NO, 1, 7), 14, '*') 주민번호
  FROM EMPLOYEE;

SELECT
       EMP_NAME 사원명
     , SUBSTR(EMP_NO, 1, 7) || '*******' 주민번호
  FROM EMPLOYEE;
  
-- LOWER / UPPER / INITCAP : 대소문자 변경해주는 함수
SELECT LOWER('Welcome To Hello World') FROM DUAL;
SELECT UPPER('Welcome To Hello World') FROM DUAL;
SELECT INITCAP('welcome to hello world') FROM DUAL;

-- CONCAT : 문자열 두 개를 하나의 문자열로 합친 후 리턴
SELECT CONCAT('가나다라', 'ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL;

-- REPLACE : 컬럼 혹은 문자열을 입력받아 변경하고자 하는 문자열을 변경할 문자열로 바꾼 뒤 리턴
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;

-- 숫자 처리 함수 : ABS, MOD, ROUND, FLOOR, TRUNC, CELL, ...
-- ABS(숫자 | 컬럼명) : 절대값 구하는 함수
SELECT
       ABS(-10)
     , ABS(10)
  FROM DUAL;
  
-- MOD(숫자, 숫자) : 두 수를 나누어서 나머지를 구하는 함수
--                  첫 번째 인자는 나누어지는 수, 두 번째 인자는 나눌 수
SELECT
       MOD(10, 5)
     , MOD(10, 3)
  FROM DUAL;
  
-- 사번이 짝수인 직원의 사번, 이름, 급여, 부서코드 조회
SELECT
       EMP_ID 사번
     , EMP_NAME 이름
     , SALARY 급여
     , DEPT_CODE 부서코드
  FROM EMPLOYEE
 WHERE MOD(EMP_ID, 2)= 0; 
 
-- ROUND(숫자, [위치]) : 반올림해서 리턴해주는 함수
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;

-- FLOOR(숫자) : 내림처리를 한 정수를 반환하는 함수
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC(숫자, [위치]) : 내림처리(절삭) 함수
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
SELECT TRUNC(123.456, -1) FROM DUAL;

-- CEIL(숫자) : 올림처리 함수
SELECT CEIL(123.456) FROM DUAL;

-- 날짜 처리 함수 : SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, EXTRACT, ...
-- SYSDATE : 현재 날짜와 시간을 반환해주는 함수
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN(날짜, 날짜)
-- : 두 날짜의 개월 수 차이를 숫자로 리턴하는 함수 (첫 번째 인자가 최신이어야 할 듯)
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
  
-- ADD_MONTHS (날짜, 숫자)
-- : 날짜에 입력한 개월수를 더해서 리턴
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;
  
-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 6개월에 되는 날짜 조회
SELECT
       EMP_NAME
     , HIRE_DATE
     , ADD_MONTHS(HIRE_DATE, 6)
  FROM EMPLOYEE;
  
-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 조회
SELECT 
       *
  FROM EMPLOYEE 
 WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;

-- NEXT_DAY(기준날짜, 요일)
-- : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜 리턴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;
-- 오라클 세팅이 한국어로 되어있어서... FRIDAY가 안됨...

-- LAST_DAY(날짜) : 해당 월의 마지막 날짜를 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 입사일, 입사한 월의 근무일수를 조회하세요
-- 단, 주말은 고려하지 않는다.
SELECT
       EMP_NAME
     , HIRE_DATE
     , LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 입사월의_근무일수
  FROM EMPLOYEE;

-- EXTRACT : 년, 월, 일 정보를 추출해서 리턴
-- EXTRACT(YEAR FROM 날짜) : 년도만 추출
-- EXTRACT(MONTH FROM 날짜) : 월만 추출
-- EXTRACT(DAY FROM 날짜) : 날짜(일)만 추출
SELECT
       EXTRACT(YEAR FROM SYSDATE) 년도
     , EXTRACT(MONTH FROM SYSDATE) 월
     , EXTRACT(DAY FROM SYSDATE) 일
  FROM DUAL;
  
-- EMPLOYEE 테이블에서 사원이름, 입사년도, 입사월, 입사일 조회
SELECT
       EMP_NAME 사원이름
     , EXTRACT(YEAR FROM HIRE_DATE) 입사년도
     , EXTRACT(MONTH FROM HIRE_DATE) 입사월
     , EXTRACT(DAY FROM HIRE_DATE) 입사일
  FROM EMPLOYEE
--  ORDER BY 사원이름
 ORDER BY 입사년도 ASC, 입사월 DESC;
-- ORDER BY 입사년도, 입사월 DESC; ASC는 묵시적 표현이기에 현재 입사년도는 ASC임

-- ORDER BY : 제일 마지막에 적는 정렬하는 구문, 오름차순(기본값) - ASC / 내림차순 - DESC
--            별칭 입력 가능, 숫자 입력 시 컬럼의 인덱스
-- 단, 별칭은 WHERE절에서는 사용할 수 없다.

SELECT SYSDATE FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- 형변환 함수
-- TO_CHAR(날짜, [포맷]) : 날짜형 데이터를 문자형 데이터로 변경
-- TO_CHAR(숫자, [포맷]) : 숫자형 데이터를 문자형 데이터로 변경

SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, '00000') FROM DUAL;
SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;
SELECT TO_CHAR(1234, '$99,999') FROM DUAL;
SELECT TO_CHAR(1234, '00,000') FROM DUAL;

-- 직원 테이블에서 사원명, 급여 조회
-- 급여는 '\9,000,000' 형식으로 표현하세요
SELECT
       EMP_NAME
     , TO_CHAR(SALARY, 'L99,999,999')
  FROM EMPLOYEE;

-- 날짜 데이터에 포맷 적용
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-FmMM-DD DAY') FROM DUAL;
-- FmMM 01 -> 1월 MM 1 -> 01월
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '분기' FROM DUAL;

SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS') 상세입사일
     , TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') 입사일한글
  FROM EMPLOYEE;
  
-- 년도(연도) 포맷
SELECT
       TO_CHAR(SYSDATE, 'YYYY')
     , TO_CHAR(SYSDATE, 'RRRR')
     , TO_CHAR(SYSDATE, 'YY')
     , TO_CHAR(SYSDATE, 'RR')
     , TO_CHAR(SYSDATE, 'YEAR')
  FROM DUAL;
  
-- YY와 RR의 차이
-- RR은 두 자리년도를 네자리로 변경 시
--변경 년도가 50년 미만이면 2000대 적용
-- 50년 이상이면 1900년대를 적용한다.
SELECT
       TO_CHAR(TO_DATE('980630', 'YYMMDD')), 'YYYY-MM-DD'
     , TO_CHAR(TO_DATE('980630', 'RRMMDD')), 'RRRR-MM-DD'
  FROM DUAL;
  
-- 월 포맷
SELECT
       TO_CHAR(SYSDATE, 'MM')
     , TO_CHAR(SYSDATE, 'MONTH')
     , TO_CHAR(SYSDATE, 'MON')
     , TO_CHAR(SYSDATE, 'RM')
  FROM DUAL;
  
-- 일 포맷
SELECT
       TO_CHAR(SYSDATE, '"1년 기준" DDD "일 째')
     , TO_CHAR(SYSDATE, '"달 기준" DD "일 째')
     , TO_CHAR(SYSDATE, '"주 기준" D "일 째')
  FROM DUAL;
  
-- 분기와 요일
SELECT
       TO_CHAR(SYSDATE, 'Q"분기"')
     , TO_CHAR(SYSDATE, 'DAY')
     , TO_CHAR(SYSDATE, 'DY')
  FROM DUAL;
  
-- 직원 테이블에서 이름, 입사일 조ㅗ히
-- 입사일에 포맥 종응해서 조회
-- '2018년 6월 15일 (수)' 형식으로 출력하세요
SELECT
       EMP_NAME
     , TO_CHAR(HIRE_DATE, 'RRRR"년 " fmMM"월 " DD"일 " "("DY")"')
  FROM EMPLOYEE;
  
-- TO_DATE : 문자 혹은 숫자형 데이터를 날짜형 데이터로 변환하여 리턴
SELECT
       TO_DATE('20101010', 'RRRRMMDD')
  FROM DUAL;
  
SELECT
       TO_CHAR(TO_DATE('20101010', 'RRRRMMDD'), 'RRRR, MON')
  FROM DUAL;
  
SELECT
       TO_CHAR(TO_DATE('041030 143000', 'RRMMDD HH24MISS'), 'DD-MON-RR HH:MI:SS PM')
  FROM DUAL;
  
-- 직원 테이블에서 2000년도 이후에 입사한 사원의
-- 사번, 이름, 입사일을 조회하세요
SELECT
       EMP_ID
     , EMP_NAME
     , HIRE_DATE
  FROM EMPLOYEE
 WHERE HIRE_DATE >= TO_DATE(20000101, 'RRRRMMDD');
-- 문자는 날짜로 자동 형변환 되지만, 숫자는 날짜로 자동 형변환 안됨

-- TO_NUMBER(문자, [포맷]) : 문자데이터를 숫자로 리턴
SELECT
       TO_NUMBER('123456789')
  FROM DUAL;
  
SELECT '123' + '456' FROM DUAL;

SELECT '123' + '456A' FROM DUAL;

SELECT '1,000,000' + '500,000' FROM DUAL;

SELECT
       TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('500,000', '999,999')
  FROM DUAL;
  
-- 직원 테이블에서 사원번호가 201인 사원의
-- 이름, 주민번호 앞자리, 주민번호 뒷자리, 주민번호 앞자리와 뒷자리의 합을 조회하세요.
-- 단 자동형변환을 사용하지 않고 조회
SELECT
       EMP_NAME 이름
     , EMP_NO
     , SUBSTR(EMP_NO, 1, 6) 앞부분
     , SUBSTR(EMP_NO, 8) 뒷부분
     , TO_NUMBER(SUBSTR(EMP_NO, 1, 6)) + TO_NUMBER(SUBSTR(EMP_NO, 8)) 합
  FROM EMPLOYEE
 WHERE EMP_ID = 201;
-- 자동형변환 안하는게 빠름

-- NULL처리 함수
-- NVL(컬럼명, 컬럼이 NULL인 경우 바꿀 값)
SELECT
       EMP_NAME
     , BONUS
     , NVL(BONUS, 0)
  FROM EMPLOYEE;
  
-- NVL2(컬럼명, 바꿀값1, 바꿀값2)
-- 해당 컬럼에 값이 있으면 바꿀값1로 변경, NULL이면 바꿀값2로 변경 (약간 IF느낌)

-- 직원 정보에서 보너스 포인트가 NULL인 직원은 0.5로
-- 보너스 포인트가 NULL이 아닌 경우 0.7로 변경하여 조회
SELECT
       EMP_NAME
     , BONUS
     , NVL2(BONUS, 0.7, 0.5)
  FROM EMPLOYEE;
  
-- 선택함수
-- 여러가지 경우에 선택할 수 있는 기능을 제공
-- DECODE(계산식 | 컬럼명, 조건값1, 선택값1, 조건값2, 선택값2, ...) CHOOSE느낌 
SELECT
       EMP_ID
     , EMP_NAME
     , EMP_NO
--     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여')
     , DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '여')
  FROM EMPLOYEE;
-- 마지막에 있는 조건 값은 생략 가능

/* 직원의 급여를 인상하여 조회하려고 한다.
   직급코드가 J7인 직원은 급여의 10%를 인상하고
   직급코드가 J6인 직원은 급여의 15%를 인상하고
   직급코드가 J5인 직원은 급여의 20%를 인상하고
   그 외 직급의 직원은 5%만 인상한다.
   직원 테이블에서 직원명, 직급코드, 급여, 인상급여를 조회하세요.
*/
SELECT
       EMP_NAME 직원명
     , JOB_CODE 직급코드
     , SALARY 급여
     , DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15, 
                        'J5', SALARY * 1.2, 
                              SALARY * 1.05) 인상급여
  FROM EMPLOYEE;
  
-- CASE
--   WHEN 조건식 THEN 결과값
--   WHEN 조건식 THEN 결과값
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
      END AS 인상급여
  FROM EMPLOYEE;
  
-- 사번, 사원명, 급여를 EMPLOYEE 테이블에서 조회하고
-- 급여가 500만원 초과면 '고급'
-- 급여가 300~500만원이면 '중급'
-- 그 이하는 '초급'으로 출력하도록 하고 별칭은 '구분'으로 한다.
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
     , CASE
        WHEN SALARY > 5000000 THEN '고급'
        WHEN SALARY BETWEEN 3000000 AND 5000000 THEN '중급'
        ELSE '초급'
      END AS 구분
  FROM EMPLOYEE;