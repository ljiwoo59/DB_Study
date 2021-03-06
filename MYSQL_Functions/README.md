# MySQL 내장함수

## 숫자 관련 함수
|Function|설명|
|--------|----|
|**ABS(숫자)**|절대값|
|**CEILING(숫자)**|값 보다 큰 정수 중 가장 작은 수 (올림)|
|**FLOOR(숫자)**|값 보다 작은 정수 중 가장 큰 수 (내림)|
|**ROUND(숫자, 자릿수)**|숫자를 자릿수를 기준으로 반올림|
|**TRUNCATE(숫자, 자릿수)**|숫자를 자릿수를 기준으로 버림|
|**POW(X, Y) or POWER(X, Y)**|X 의 Y 승|
|**MOD(TOP, BOT)**|TOP 을 BOT 으로 나눈 나머지|
|**GREATEST(숫자1, 숫자2...)**|주어진 수에서 가장 큰 수를 반환|
|**LEAST(숫자1, 숫자2...)**|주어진 수에서 가장 작은 수를 반환|

## 문자 관련 함수
|Function|설명|
|--------|----|
|**ASCII(문자)**|문자의 아스키 코드 값 반환|
|**CONCAT('문자열1', '문자열2'...)**|문자열들을 결합|
|**INSERT('문자열', 시작위치, 길이, '새로운 문자열')**|문자열의 시작위치부터 길이만큼 새로운 문자열로 대치|
|**REPLACE('문자열', '기존 문자열', '바뀔 문자열')**|문자열 중 기존 문자열을 바뀔 문자열로 변경|
|**INSTR('문자열', '찾는 문자열')**|문자열 중 찾는 문자열의 위치 값을 반환|
|**MID('문자열', 시작위치, 개수)**|문자열 중 시작위치부터 개수만큼 반환|
|**SUBSTRING('문자열', 시작위치, 개수)**|문자열 중 시작위치부터 개수만큼 반환|
|**LTRIM('문자열')**|문자열 중 왼쪽의 공백을 제거|
|**RTRIM('문자열')**|문자열 중 오른쪽의 공백을 제거|
|**TRIM('문자열')**|양쪽 모두의 공백을 제거|
|**LCASE('문자열') or LOWER('문자열')**|모든 문자를 소문자로 변경|
|**UCASE('문자열') or UPPER('문자열')**|모든 문자를 대문자로 변경|
|**LEFT('문자열', 개수)**|문자열 중 왼쪽에서 개수만큼 추출|
|**RIGHT('문자열', 개수)**|문자열 중 오른쪽에서 개수만큼 추출|
|**LPAD('기존 문자열', 자릿수, '채울 문자열')**|원하는 자릿수가 될때까지 기존 문자열 왼쪽에 채울 문자열을 채워서 반환|
|**RPAD('기존 문자열', 자릿수, '채울 문자열')**|원하는 자릿수가 될때까지 기존 문자열 오른쪽에 채울 문자열을 채워서 반환|
|**REVERSE('문자열')**|문자열을 반대로 나열|

## 날짜 관련 함수
|Function|설명|
|--------|----|
|**NOW() or SYSDATE() or CURRENT_TIMESTAMP()**|현재 날짜와 시간 반환|
|**CURDATE() or CURRENT_DATE()**|현재 날짜 반환|
|**CURTIME() or CURRENT_TIME()**|현재 시간 반환|
|**REPLACE('문자열', '기존 문자열', '바뀔 문자열')**|문자열 중 기존 문자열을 바뀔 문자열로 변경|
|**DATE_ADD(날짜, INTERVAL 기준 값)**|날짜에서 기준 값만큼 더한다|
|**DATE_SUB(날짜, INTERVAL 기준 값)**|날짜에서 기준 값만큼 뺀다|
|**YEAR(날짜)**|날짜의 연도 반환|
|**MONTH(날짜)**|날짜의 월 반환|
|**MONTHNAME(날짜)**|날짜의 월을 영어로 반환|
|**DAYNAME(날짜)**|날짜의 요일을 영어로 반환|
|**DAYOFMONTH(날짜)**|날짜의 월별 일자 반환|
|**DAYOFWEEK(날짜)**|날짜의 주별 일자 반환 [일요일(1), 월요일(2)...토요일(7)]|
|**WEEKDAY(날짜)**|날짜의 주별 일자 반환 [월요일(0), 화요일(1)...일요일(6)]|
|**DAYOFYEAR(날짜)**|일년을 기준으로 한 날짜까지의 일 수 (365일중 X일)|
|**WEEK(날짜)**|일년 중 몇 번째 주|
|**FROM_DAYS(날수)**|00년 00월 00일부터 날 수 만큼 경과한 날의 날짜 반환|
|**TO_DAYS(날짜)**|00년 00월 00일부터 날짜까지의 일자 수 반환|
|**DATE_FORMAT(날짜, '형식')**|날짜를 형식에 맞게 반환|

### 날짜 형식
|FMT|설명|FMT|설명|FMT|설명|
|---|----|---|----|---|----|
|**%Y**|년, 2020|**%a**|요일, Sun..Sat|**%k**|시간, 0, 1..22, 23|
|**%y**|년, 20|**%W**|요일, Sunday..Saturday|**%l (L)**| 시간, 1, 2..11, 12|
|**%b**|월, Jan..Dec|**%w**|요일, 0: 일요일..6: 토요일|**%i**|분, 00..59|
|**%M**|월, January..December|**%p**|AM or PM|**%S**|초, 00..59|
|**%m**|월, 01, 02..12|**%H**|시간, 01, 02..23|**%s**|초, 00..59|
|**%d**|일, 00, 01..31|**%h**|시간, 01, 02..12|**%T**|시간, 24-hour (hh:mm:ss)|
|**%e**|일, 0, 1..31|**%I (i)**|시간, 01, 02..12|**%j**|1년 중 X일, 001..365|

## 논리 관련 함수
|Function|설명|
|--------|----|
|**IF(논리식, 값1, 값2)**|논리식이 참이면 값1, 거짓이면 값2 반환|
|**IFNULL(값1, 값2)**|값1이 NULL 이면 값2 로 대치|
|**NULLIF(값1, 값2)**|값1=값2 이 TRUE 이면 NULL 아니면 값1 반환|

## 그룹 (Aggregate) 함수
|Function|설명|
|--------|----|
|**COUNT(필드명)**|NULL 값이 아닌 레코드 수를 반환|
|**SUM(필드명)**|필드명에 해당하는 레코드 값의 합계를 반환|
|**AVG(필드명)**|각각의 그룹 안에서 필드명에 해당하는 레코드 값의 평균을 반환|
|**MAX(필드명)**|필드명에 해당하는 레코드 값 중 최대값을 반환|
|**MIN(필드명)**|필드명에 해당하는 레코드 값 중 최소값을 반환|
