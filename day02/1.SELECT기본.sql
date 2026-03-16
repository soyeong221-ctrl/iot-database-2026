-- 1.SELECT
-- SELECT/FROM_서점에 어떤 도서가 있는지 알고 싶다.
-- 모든 도서의 이름과 가격을 조회하시오.
SELECT bookname
     , price
  FROM Book;

-- 모든 도서의 가격과 이름을 조회하시오.
SELECT price
	 , bookname
  FROM Book;

-- 모든 도서의 도서번호, 도서명, 출판사, 가격을 검색하시오.
SELECT *
  FROM Book;

SELECT bookid
	 , bookname
	 , publisher
	 , price
  FROM Book;

-- 도서 테이블에 있는 모든 출판사를 조회하시오.
SELECT publisher
  FROM Book;

-- 도서 테이블의 중복을 제거한 출판사를 조회하시오.
SELECT DISTINCT publisher
  FROM Book;

SELECT All publisher
  FROM Book;

-- WHERE 조건_가격이 20,000원 미만인 도서가 무엇인지 알고 싶다.
-- 가격이 10,000원 이상 20,000 이하인 도서를 조회하시오.
SELECT *
  FROM Book
 WHERE price BETWEEN 10000 AND 20000;

-- BETWEEN은 AND로 변경 가능
SELECT *
  FROM Book
 WHERE price >= 10000
   AND price <= 20000;

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 조회하시오.
SELECT * 
  FROM Book
 WHERE publisher IN ('굿스포츠', '대한미디어');

-- OR와 동일. 단, 값이 너무 많으면 IN절이 훨신 효율적
SELECT * 
  FROM Book
 WHERE publisher = '굿스포츠'
    OR publisher = '대한미디어';

-- 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 조회하시오.
SELECT *
  FROM Book
 WHERE publisher NOT IN ('굿스포츠', '대한미디어');

-- LIKE 패턴 필터링
-- '축구의 역사'를 출간한 출판사를 조회하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname = '축구의 역사';

SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구의 역사';

-- 도서이름에 '축구'가 포함된 출판사를 조회하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구%';

-- 도서이름이 '축구'로 시작하는 책을 출판한 출판사를 조회하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구%';

-- 도서이름이 '축구'로 끝나는 책을 출판한 출판사를 조회하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '%축구';

-- 도서이름이 '축구'로 시작하고 총 제목 길이가 8자리인 책을 출판한 출판사를 조회하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname LIKE '축구______';

-- 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 조회하시오.
SELECT *
  FROM Book
 WHERE bookname LIKE '_구%';

-- 복합조건
-- 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 조회하시오.
SELECT *
  FROM Book
 WHERE bookname LIKE '%축구%' AND price >= 20000;

-- ORDER by_도서를 이름순으로 보고 싶다.
-- 도서를 이름순으로 조회하시오.
SELECT *
  FROM Book
  ORDER BY bookname;

-- 도서를 가격순으로 조회하고, 가격이 같으면 이름순으로 조회하시오.  
SELECT *
  FROM Book
  ORDER BY price ASC, bookname ASC;

-- 2. 집계 함수와 GROUP BY
-- 집계 함수_도서 판매액의 합계를 알고 싶다.
-- 2번 김연아 고객이 주문한 도서의 총 판매액을 조회하시오.
SELECT custid
  FROM Customer
 WHERE name = '김연아';

SELECT sum(saleprice) AS "총매출"
  FROM Orders
 WHERE custid = 2;

-- Alias
SELECT b.bookid AS "책 순번"
	 , b.bookname AS "책 제목"
	 , b.price AS "정가"
  FROM Book AS b;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 조회하시오.
SELECT sum(saleprice) "Total"
     , avg(saleprice) "Average"
     , min(saleprice) "Minimum"
     , max(saleprice) "Maximum"
  FROM Orders o;

-- 마당서점의 도서 판매 건수를 조회하시오.
SELECT count(*) "총 판매수"
	 , count(o.orderid) "총 판매수"-- 아래와 개수 차이가 날 수 있음
  FROM Orders o;

-- GROUP BY_어느 고객이 얼마나 주문했는지 알고 싶다.
-- 고객별로 주문한 도서의 총 수량과 총 판매액을 조회하시오.
SELECT o.custid
	 , count(*) "도서수량"
	 , sum(o.saleprice) "총액"
  FROM Orders o
 GROUP BY o.custid;
  
-- 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 조회하시오.
-- 단, 두 권 이상 구매한 고객만 구한다.
SELECT o.custid, count(*) "도서수량"
  FROM Orders o
 WHERE o.saleprice >= 8000
 GROUP BY o.custid
 HAVING count(*) >= 2;
  
  