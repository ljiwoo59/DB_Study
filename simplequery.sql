-- 1 world db 사용
use world;

-- 2 city, country, countrylanguage 테이블 구조 보기
desc city;
desc country;
desc countrylanguage;

-- 3 country table 에서 code 가 KOR 인 자료 조회
select code, name, continent, region
from country
where code = "KOR";

-- 4 country 에서 gnp 변동량이 양수인 국가에 대해 gnp 변동량의 오름차순으로 정렬
select code, name, gnp, gnpold, (gnp - gnpold) as "gnp변동량"
from country
where gnp is not null and gnpold is not null and gnp > gnpold
order by gnp변동량;

-- 5 country table 에서 continent 를 중복 없이 조회, continent 길이로 정렬
select distinct continent
from country
order by length(continent);

-- 6 country 에서 asia 대륙에 속하는 국가들의 정보를 출력, name 으로 정렬
select concat(name, " is located in  ", region, " and total population is " ,population, ".") as "정보"
from country
where continent = "Asia"
order by name;

-- 7 country 에서 독립 년도에 대한 기록이 없고 인구가 10000 이상인 국가의 정보를 인구의 오름차순으로 출력
select name, continent, gnp, population
from country
where indepyear is null and population >= 10000
order by population;

-- 8 country 에서 인구가 1 억<=x<=2 억 인 나라를 인구 기준으로 내림차순 정렬해서 상위 3 개만 출력
select code, name, population
from country
where population between 100000000 and 200000000
order by population desc
limit 3;

-- 9 country 에서 800, 1810, 1811, 1901, 1901 에 독립한 나라를 독립년 기준으로 오름차순 출력, 독립 년이 같다면 code 기준으로 내림차순
select code, name, indepyear
from country
where indepyear in (800, 1810, 1811, 1901)
order by indepyear, code desc;

-- 10 country 에서 region 에 asia 가 들어가고 name 의 두 번째 글자가 ‘o’인 정보를 출력
select code, name, region
from country
where region like "%asia%" and name like "_o%";

-- 11 '홍길동'과 'hong'의 글자 길이를 각각 출력
select char_length('홍길동') as '한글', length('hong') as '영문';

-- 12 country 에서 (gnp-gnpold) 를 gnp 향상이라고 표현하시오. 단 gnpold 가 없는 경우 신규 라고 출력하고 name 으로 정렬
select name, gnp, gnpold, ifnull(gnp - gnpold, '신규') as 'gnp 향상'
from country
order by name;

-- 13 country 에서 code 가 모음으로 시작하는 나라의 정보를 출력, name 의 오름차순으로 정렬하고 3 번 부터 3 개만 출력
select code, name
from country
where code regexp '^[AEIOU]'
order by name
limit 2, 3;

-- 14 country 에서 name 을 맨 앞과 맨 뒤에 2 글자를 제외하고 나머지는 *로 처리해서 출력
delimiter //
DROP FUNCTION IF EXISTS world.star//
create function star(name char(52))
	returns varchar(128)
    DETERMINISTIC
begin
    return concat(left(name, 2), lpad('', length(name) - 4, '*'), right(name, 2));
end //
delimiter ;

select name, star(name) as 'guess'
from country;

-- 15 country 에서 region 을 중복 없이 가져오는데 공백을 _로 대체, region 의 길이로 정렬
select distinct replace(region, " ", "_") as '지역들'
from country
order by length(region) desc;