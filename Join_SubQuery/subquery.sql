use scott;

-- 1 부서위치가 CHICAGO 인 모든 사원에 대해 이름, 업무, 급여 출력
select emp.ename, emp.job, emp.sal
from emp
join dept
on dept.deptno = emp.deptno
where dept.loc = 'CHICAGO';

-- 2 부하직원이 없는 사원의 사원번호, 이름, 업무, 부서번호 출력
select empno, ename, job, deptno
from emp
where empno not in (
	select distinct ifnull(0, mgr)
    from emp);

-- 3 BLAKE 와 같은 상사를 가진 사원의 이름, 업무, 상사번호 출력
select ename, job, mgr
from emp
where mgr = (
	select empno
    from emp
    where ename = 'BLAKE');
    
-- 4 입사일이 가장 오래된 사람 5명 검색
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp
order by hiredate
limit 5;

-- 5 JONES 의 부하 직원의 이름, 업무, 부서명 검색
select emp.ename, emp.job, dept.dname
from emp
join dept
on emp.deptno = dept.deptno
where emp.mgr = (
	select empno
    from emp
    where ename = 'JONES');