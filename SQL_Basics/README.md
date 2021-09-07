# [SQL (Structured Query Language)](https://github.com/ljiwoo59/DB_Study/blob/master/SQL_Basics/simplequery.sql)
* *Database* 에 있는 정보를 사용할 수 있도록 지원하는 언어
* 모든 DBMS 에서 사용 가능
* **대소문자는 구별하지 않음 (단, 데이터의 대소문자는 구분)**

## DDL (Data Definition Language)
* *데이터베이스 객체 (table, view, index...)* 의 **구조**를 정의
* 테이블 생성, 컬럼 추가, 타입 변경, 제약조건 지정, 수정 등등

|SQL|설명|
|------|-----------------------|
|**CREATE**|데이터베이스 객체를 생성|
|**DROP**|데이터베이스 객체를 삭제|
|**ALTER**|기존에 존재하는 데이터베이스 객체를 수정|
|**RENAME**|데이터베이스 객체 이름 변경|

### 데이터베이스 생성
```sql
create database 데이터베이스명;

create database 데이터베이스명
  default character set 값
  collate 값;
```
* *Character set* : 각 문자가 컴퓨터에 저장될 때 어떠한 코드로 *저장*될지에 대한 규칙의 집합
* *Collation* : 특정 문자 셋에 의해 데이터베이스에 저장된 값들을 비교 검색하거나 정렬 등의 작업을 위해 문자들을 서로 *비교*할때 사용하는 규칙의 집합

### 데이터베이스 변경
```sql
alter database 데이터베이스명
  default character set 값
  collate 값;
```

### 데이터베이스 삭제
```sql
drop database 데이터베이스명;
```

### 데이터베이스 사용
```sql
use 데이터베이스명;
```

## table 생성
```sql
create table 테이블이름 (
  컬럼_이름1 Type [optional attributes],
  컬럼_이름2 Type,
  .
  컬럼_이름N Type
);
```

### Data Type

|문자형 데이터 타입|설명|
|----|----|
|**CHAR(M)**|**고정 길이**를 갖는 문자열 저장, 최대 8byte|
|**VARCHAR(M)**|**가변 길이**를 갖는 문자열 저장, 최대 16byte|
|**TEXT(M)**|*TINYTEXT* 2^8byte, *TEXT* 2^16byte, *MEDIUMTEXT* 2^24byte, *LONGTEXT* 2^32byte|
|**ENUM('value1', 'value2'...)**|**열거형**. 정해진 몇가지의 값들 중 **하나만 저장**. 내부적으로 정수 값|
|**SET('value1', 'value2'...)**|**집합형**. 정해진 몇가지의 값들 중 **여러개 저장**. 내부적으로 정수 값|


|숫자형 데이터 타입|설명|
|----|----|
|**BIT(M)**|비트 값 유형. *M* 은 값 당 비트 수|
|**BOOL, BOOLEAN**|0 은 false, 0 이 아닌 값은 true. *TINYINT(1)* 의 동의어|
|**INT(M)**|*TINYINT* 8bit, *SMALLINT* 16bit, *MEDIUMINT* 24bit, *INT* 32bit, *BIGINT* 64bit|
|**DECIMAL(M, D)**|묶음 고정 소수점 숫자. *M* 은 전체 자릿수, *D* 는 소수점 뒷 자리수|
|**DEC(M, D), NUMERIC(M, D), FIXED(M, D)**|*DECIMAL(M, D)* 동의어|


|날짜형 데이터 타입|설명|
|----|----|
|**DATE**|YYYY-MM-DD|
|**TIME**|HH:MM:SS|
|**DATETIME**|YYYY-MM-DD HH:MM:SS 문자형|
|**TIMESTAMP(M)**|YYYY-MM-DD HH:MM:SS 숫자형. TIME_ZONE 의존|
|**YEAR(2\|4)**|2 인 경우 70\~69, 4 인 경우 1970\~2069|


|이진 데이터 타입|설명|
|----|----|
|**BINARY(M)**|*CHAR* 과 유사하나 이진 바이트 문자열을 이진이 아닌 문자열로 저장|
|**VARBINARY(M)**|*VARCHAR* 과 유사하나 이진 바이트 문자열을 이진이 아닌 문자열로 저장|
|**BLOB(M)**|이진 데이터 타입. *TINYBLOB* 2^8byte, *BLOB* 2^16byte, *MEDIUMBLOB* 2^24byte, *LONGBLOB* 2^32byte|

### Optinoal Attributes
* **NOT NULL** : 각 행은 해당 열의 값을 포함해야 하며 *null* 값은 허용되지 않음
* **DEFAULT value** : 값이 전달되지 않을 때 추가되는 *기본값* 설정
* **UNSIGNED** : *Type 이 숫자인 경우*만 해당되며 숫자가 0 또는 양수로 제한됨
* **AUTO INCREMENT** : 새 레코드가 추가 될 때마다 필드 값을 자동으로 1 **증가**시킴
* **PRIMARY KEY** : 테이블에서 행을 고유하게 식별하기 위해 사용
  * 일반적으로 *ID* 이며 *AUTO INCREMENT* 와 같이 사용

### 제약 조건
* column 에 저장될 데이터의 조건을 설정 하는 것
* 제약 조건에 위배되는 데이터는 저장 불가
* 테이블 생성 시 컬럼에 **직접 지정**하거나 **constraint**로 지정, 또는 **ALTER** 을 이용하여 설정

|제약 조건|설명|
|---------|----|
|**NOT NULL**|NULL 불가, 반드시 쿼리문을 이용하여 값을 지정|
|**UNIQUE**|중복된 값 저장 불가, NULL 허용|
|**PRIMARY KEY**|중복된 값 저장 불가, NULL 불가, ROW 를 구분하기 위한 유일한 값 지정|
|**FOREIGN KEY**|NULL 허용, 특정 테이블의 PK 컬럼에 저장되어 있는 값만 저장, *references* 반드시 지정|
|**DEFAULT**|NULL 일 경우 기본값 지정|
|**CHECK**|값의 범위나 종류 지정|

---

## DML (Data Manipulation Language)
* *Data* **조작**기능
* 테이블의 레코드를 ***CRUD (Create, Retrieve, Update, Delete)***

|SQL|설명|
|------|-----------------------|
|**INSERT (C)**|데이터베이스 객체에 데이터 입력|
|**SELECT (R)**|데이터베이스 객체에서 데이터 조회|
|**UPDATE (U)**|데이터베이스 객체에 데이터 수정|
|**DELETE (D)**|데이터베이스 객체에 데이터 삭제|

### INSERT
```sql
INSERT INTO 테이블이름
VALUES (col_val1, col_val2...);

INSERT INTO 테이블이름(col_name1, col_name2...)
VALUES (col_val1, col_val2...),
       (col_val1, col_val2...);
```
* 생략 가능한 field
  * **NULL** 이 허용된 컬럼
  * **DEFAULT** 가 설정된 컬럼
  * **AUTO INCREMENT** 가 설정된 컬럼

### UPDATE
```sql
UPDATE 테이블이름
SET col_name1=col_val1,...
WHERE conditions;
```
* *WHERE* 절의 conditions 에 만족하는 레코드의 값을 변경
  * 생략 시 모든 데이터 변경

### DELETE
```sql
DELETE from 테이블이름
WHERE conditions;
```
* *WHERE* 절의 conditions 에 만족하는 레코드 값을 삭제
  * 생략 시 모든 데이터 삭제

### SELECT
```sql
SELECT * | {[ALL|DISTINCT] column|expression [alias],...}
FROM 테이블이름
WHERE conditions;
```
* **SELECT** 와 **FROM** 은 필수

|SELECT clause|설명|
|-------------|----|
|**\***|*FROM* 에 나열된 테이블에서 모든 column 을 선택|
|**ALL**|선택된 모든 row 를 반환. default 값 (생략 가능)|
|**DISTINCT**|선택된 모든 row 중에서 중복 row 제거|
|**column**|*FROM* 에 나열된 테이블에서 지정된 column 선택|
|**expression**|값으로 인식되는 하나 이상의 값, 연산자 및 SQL 함수의 조합|
|**alias**|별칭|

* **WHERE** 은 조건에 만족하는 행을 검색
  * **AND, OR, NOT**
  * **IN, NOT IN** : 여러개의 값 비교
  * **BETWEEN~AND** : ~이상, ~이하
  * **IS NULL, IS NOT NULL**
  * **LIKE '%, _' : 문자열 비교
    * **%** : 위치에 따라 문자열 존재 여부
    * **_** : 위치에 따라 한 문자 존재 여부 (문자 자리수)

* **ORDER BY**
  * default : **ASC**

---

## DCL (Data Control Language)
* *DB, Table* 의 **접근 권한**이나 **CRUD 권한**을 정의
* 특정 사용자에게 테이블의 검색 권한 부여/금지 등

|SQL|설명|
|--|----|
|**GRANT**|데이터베이스 객체에 권한을 부여|
|**REVOKE**|데이터베이스 객체 권한 취소|

---

## TCL (Transaction Control Language)
* *트랜잭션* **제어**
  * 데이터베이스의 논리적 연산 단위
  
|SQL|설명|
|--|----|
|**START TRANSACTION**|*COMMIT, ROLLBACK* 이 나올 때까지 실행되는 모든 SQL|
|**COMMIT**|실행한 Query 를 최종적으로 적용|
|**ROLLBACK**|실행한 Query 를 마지막 commit 전으로 취소시켜 데이터 복구| 
