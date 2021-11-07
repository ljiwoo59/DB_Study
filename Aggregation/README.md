# Aggregation
* **집계 함수**는 하나 이상의 행을 *그룹*으로 묶어 연산하여 *하나의 결과*로 반환
* **sum** : 그룹의 누적 합계
* **avg** : 그룹의 평균
* **count** : 그룹의 총 개수
* **max** : 그룹의 최대값
* **min** : 그룹의 최소값

```sql
select sum(salary), sum(salary * commission_pct) from employees;

select rount(avg(salary), 2) from employees;

select count(employee_id) from employees;

select max(salary), min(salary) from employees;
```

---

# Group By
* 쿼리 된 테이블의 행을 **그룹**으로 묶는다
* 선택 목록의 집계 함수를 각 행 그룹에 적용하고, 각 그룹에 대해 단일 결과 행을 반환
  * *GROUP BY* 생략 시, 선택 목록의 집계 함수를 쿼리 된 테이블의 모든 행에 적용
* *SELECT* 절의 모든 요소는 *GROUP BY 표현식, 집계 함수를 포함하는 표현식 또는 상수*만 가능

### 실행 순서
```sql
SELECT columns # 5
FROM table_name # 1
WHERE conditions # 2
GROUP BY grouping column # 3
HAVING grouping conditions # 4
ORDER BY col # 6
```

### 예시
```sql
/* Error : department_id 는 다중 행 반환, sum, avg 는 단일 행 반환 */
select department_id, sum(salary), avg(salary) from employees;

select department_id, sum(salary), avg(salary)
from employees
group by department_id;

select department_id, max(salary), min(salary)
from employees
group by department_id;

/* 각 부서별 최고 급여를 받는 사원의 부서번호, 사번, 이름, 급여: JOIN 이용 */
select a.department_id, e.employee_id, e.first_name, a.smax
from employees e join (
                       select department_id, max(salary) as smax
                       from employees
                       group by department_id
                       ) a
on e.department_id = a.department_id and e.salary = a.smax;

/* 각 부서별 최고 급여를 받는 사원의 부서번호, 사번, 이름, 급여: 다중 컬럼 subquery 이용 */
select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id);
```

## HAVING
* ***GROUP BY*** 한 결과에 *조건을 추가*
* *WHERE* 절이 *GROUP BY* 절 보다 먼저 실행되기 때문에 Aggregate 조건은 *HAVING* 절에 작성

```sql
/* Error */
select department_id, avg(salary)
from employees
where avg(salary) > 7000
group by department_id;

select department_id, avg(salary)
from employees
group by department_id
having avg(salary) > 7000;

select job_id, avg(salary)
from employees
where department_id in (40, 50 ,80)
group by job_id
having sum(salary) > 50000
order by avg(salary) desc;

select deparyment_id, avg(salary)
from employees
group by department_id
having avg(salary) > (
                      select avg(salary)
                      from employees
                      where department_id = 20
                      )
order by avg(salary) desc;
```

---

# SET
* 모든 집합 연산자는 *동일한 우선 순위*를 갖는다
* *SELECT* 절에 있는 column 개수와 type 이 일치해야 함
* **UNION** : 두 쿼리에서 선택된 모든 행 반환(중복은 한번만)
* **UNION ALL** : 두 쿼리에서 선택된 모든 행 반환(중복 포함)
* **INTERSECT** : 두 쿼리에서 선택된 모든 중복 행 반환
* **MINUS** : 첫번째 쿼리에서 선택한 행 반환(중복행 제거)
