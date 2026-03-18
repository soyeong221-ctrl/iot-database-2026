-- NULL
-- 특수값 - 아직 지정되지 않은 값

SELECT NULL;

SELECT 100 + 10, 100 + NULL;

SELECT 50 * 4, 50 * NULL;

-- 전체 레코드를 선택(*)하면 모두가 NULL이 아니기 때문에 개수 카운팅 가능
-- price 컬럼만 봤을 때는 NULL값은 카운팅 안 됨
SELECT count(*), count(price)
  FROM Book;

-- NULL은 비교연산 불가
SELECT *
  FROM Book
 WHERE price IS NULL;

-- IS NULL, 해당 값이 NULL인지 확인
-- 1: NULL, 0: NULL이 아님
SELECT *
	  , isnull(publisher) AS "NULL아님(0)"
	  , isnull(price) AS "NULL(1)"
  FROM Book
 WHERE bookid = 14;

-- IFNULL, 값이 NULL일 경우 값을 대체
SELECT *
	  , IFNULL(price, 0) -- IFNULL(price, '값 없음') 와 같이 해도 됨
  FROM Book
 WHERE bookid = 14;





