# [JOIN](https://github.com/ljiwoo59/DB_Study/blob/master/Join_SubQuery/subquery.sql)
* **둘 이상의 테이블에서 데이터가 필요한 경우** 테이블 조인이 필요
* 일반적으로 조인 조건을 포함하는 *WHERE* 절을 작성
* 조인 조건은 일반적으로 각 테이블의 *PK* 및 *FK* 로 구성
* 조인의 처리는 **어느 테이블을 먼저 읽을지를 결정하는 것이 중요** (처리할 작업량 달라짐)
  * **INNER JOIN** : 어느 테이블을 먼저 읽어도 결과가 달라지지 않음
  * **OUTER JOIN** : 반드시 *OUTER* 가 되는 테이블을 먼저 읽어야 함

## INNER JOIN
* **교집합**
* *Equi-Join* 이라고도 하며, *N* 개의 테이블 조인 시 **N - 1개의 조인 조건** 필요

```sql
SELECT COL1, COL2,...COLN
FROM table1 INNER JOIN table2
ON table1.column = table2.column;

SELECT COL1, COL2,...COLN
FROM table1 JOIN table2
USING (공통 column);

SELECT COL1, COL2,...COLN
FROM table1 NATURAL JOIN table2;
```

### NON-EQUI JOIN
* *PK, FK* 가 아닌 일반 column 을 join 조건으로 지정
*  **>, <, >=, <=, BETWEEN~AND** 사용

## OUTER JOIN
* 어느 한쪽 테이블에는 해당하는 데이터가 존재하는데 다른 쪽 테이블에는 데이터가 존재하지 않을 경우 사용

### LEFT OUTER JOIN
* **왼쪽 테이블**을 기준으로 *JOIN* 조건에 일치하지 않는 데이터까지 출력

```sql
SELECT COL1, COL2,...COLN
FROM table1 LEFT OUTER JOIN table2
ON or USING;
```

### RIGHT OUTER JOIN
* **오른쪽 테이블**을 기준으로 *JOIN* 조건에 일치하지 않는 데이터까지 출력

```sql
SELECT COL1, COL2,...COLN
FROM table1 RIGHT OUTER JOIN table2
ON or USING;
```

### FULL OUTER JOIN
* **양쪽 테이블**을 기준으로 *JOIN* 조건에 일치하지 않는 데이터까지 출력
* *MySQL 은 지원하지 않음*

```sql
SELECT COL1, COL2,...COLN
FROM table1 FULL OUTER JOIN table2
ON or USING;
```

## SELF JOIN
* **같은 테이블**끼리 *JOIN*
* 자기 자신을 하나씩 비교하기 위해 사용


## JOIN 조건의 명시에 따른 구분
* **NATURAL JOIN**
* **CROSS JOIN (FULL JOIN, CARTESIAN JOIN)**

---

# SubQuery
* 다른 쿼리 **내부에 포함되어 있는 SELECT 문**
* 단일 행 또는 다중 행 비교 연산자와 함께 사용
* *SELECT, FROM, WHERE, HAVING, ORDER BY, INSERT 문의 VALUES, UPDATE 문의 SET* 에서 사용 가능 

## 중첩 서브 쿼리 (Nested Subquery)
* **WHERE 문**에 작성하는 서브 쿼리
### 단일 행
* 서브 쿼리의 결과가 *단일 행*을 반환
* **=, >, <** 으로 비교

### 복수 행
* 서브 쿼리의 결과가 *다중 행*을 반환
* **IN, ANY, ALL** 사용
  * **IN** : 반환 된 결과 중 하나라도 같으면 true
  * **ANY** : **=, >, <** 를 사용하여 반환 된 결과 중 하나라도 만족하면 true
  * **ALL** : **=, >, <** 를 사용하여 반환 된 결과를 모두 만족하면 true

### 다중 열
* 서브 쿼리의 결과가 *다중 열*을 반환

## 인라인 뷰 (Inline View)
* **FROM 문**에 작성하는 서브 쿼리
* *뷰 (View)* 처럼 동적으로 생성된 테이블로 사용
  * 임시적인 뷰이기에 데이터베이스에는 저장되지 않음
  * column 을 자유롭게 참조 가능

#### 모든 사원의 평균 급여보다 적게 받는 사원들과 같은 부서에서 근무하는 사원의 사번, 이름, 급여, 부서번호
```sql
SELECT e.employee_id, e.first_name, e.salary, e.department_id
FROM (
      SELECT DISTINCT department_id
      FROM employees
      WHERE salary < (SELECT AVG(salary) FROM employees)
      ) d JOIN employees e
ON d.department_id = e.department_id;
```

### TopN 질의
* *MySQL* 은 **LIMIT** 사용
* **LIMIT(시작 위치, 출력 개수)**
  * 인덱스는 0 부터 시작
  * 인자가 하나일 시 *출력 개수*

## 스칼라 서브 쿼리 (Scalar subquery)
* **SELECT 문**에 작성하는 서브 쿼리
* *한개의 행*만 반환

#### 직급 아이디가 IT_PROG 인 사원의 사번, 이름, 직급 아이디, 부서이름
```sql
SELECT e.employee_id, e.first_name, job_id,
       (SELECT department_name FROM departments d
        WHERE e.department_id = d.department_id) as department_name
FROM employees e
WHERE job_id = 'IT_PROG';
```

### CREATE
#### employees table 을 emp_copy 라는 이름으로 복사
```sql
CREATE TABLE emp_copy
SELECT * FROM EMPLOYEES;
```

#### employees table 의 구조만 emp_blank 라는 이름으로 생성
```sql
CREATE TABLE emp_blank
SELECT * FROM EMPLOYEES
WHERE 1 = 0;
```

#### 50번 부서의 사번, 이름, 급여, 부서번호만 emp50 이라는 이름으로 생성
```sql
CREATE TABLE emp50
SELECT employee_id eid, first_name name, salary sal, department_id did
FROM employees
WHERE department_id = 50;
```

### INSERT
#### employees table 에서 부서번호가 80인 사원의 모든 정보를 emp_blank 에 insert
```sql
INSERT INTO emp_blank
SELECT * FROM employees
WHERE department_id = 80;
```

### UPDATE
#### employees table 의 모든 사원의 평균 급여보다 적게 받는 emp50 table 의 사원 급여를 500 인상
```sql
UPDATE emp50
SET sal = sal + 500
WHERE sal < (SELECT AVG(salary) FROM employees);
```

### DELETE
#### employees table 의 모든 사원의 평균 급여보다 적게 받는 emp50 table 의 사원은 퇴사
```sql
DELETE FROM emp50
WHERE sal < (SELECT AVG(salary) FROM employees);
```
