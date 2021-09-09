use scottdb;

-- 1 이름이 Bruce 인 사원의 부서명 검색
select deptname
from dept
where deptid = (select deptid from emp where fname = 'Bruce');

-- 2 emp table 에 있는 모든 사원의 이름, 부서번호, 부서명, 급여를 출력 (dept table 에 있는 모든 부서를 출력)
select fname, emp.DEPTID, deptname, salary
from emp, dept
where emp.DEPTID = dept.DEPTID;

-- 3 emp table 에 있는 empid 와 mgrid 를 이용하여 서로의 관계를 'X의 매니저는 Y이다.' 라는 형식으로 출력
drop view if exists mgr;
create view mgr
as
select f.fname empname, s.fname mgrname
from emp f
join emp s
on f.mgrid = s.EMPID;

select concat(empname, '의 매니저는', mgrname, '이다.') '정보'
from mgr;

-- 4 10번 부서 중에서 50번 부서에는 없는 업무를 하는 사원의 사원번호, 이름, 부서명, 입사일, 지역 검색 **
select empid, fname, deptname, hdate, countryid
from emp
join dept join loc
on emp.deptid = dept.deptid and dept.locid = loc.locid
where emp.deptid = 10 and emp.jobid not in (select jobid from emp where deptid = 50);

-- 5 Vollman 이나 Fripp 의 급여와 같은 사원의 사원번호, 이름, 급여를 검색
select empid, fname, salary
from emp
where salary in (select salary from emp where fname in ('Vollman', 'Fripp'));

-- 6 emp 테이블 fname 에 인덱스를 생성
create index fnameIdx
on emp(fname);

-- 7 부서별 급여의 합계를 출력하는 view 작성
drop view if exists sal;
create view sal
as
select deptid, sum(salary) as 'sal'
from emp
group by deptid
order by deptid;

-- 8 7번에 작성된 view 를 이용하여 부서별 급여의 합계가 큰 1~3순위 출력
select sal
from sal
order by sal desc
limit 3;