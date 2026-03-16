-- 두 개 이상 테이블에서 SELECT
SELECT *
  FROM Customer c, Orders o;

-- 테이블의 관련있는 데이터로 합쳐서 SELECT JOIN
-- INNER JOIN, Natural JOIN, JOIN
-- 고객과 고객주문에 대한 데이터를 모두 조회하시오
SELECT *
  FROM Customer c, Orders o
 WHERE c.custid = o.custid;

-- 불필요한 custid 중복은 없애주기
SELECT c.*
	 , o.orderid 
	 , o.bookid 
	 , o.orderdate 
	 , o.saleprice 
  FROM Customer c, Orders o
 WHERE c.custid = o.custid

-- SQL 표준의 JOIN
-- INNER JOIN이나 JOIN 키워드를 사용해서 쿼리 작성
SELECT c.*
	 , o.orderid 
	 , o.bookid 
	 , o.orderdate 
	 , o.saleprice 
  FROM Customer c
  INNER JOIN Orders o
     ON c.custid = o.custid;

-- custid가 3번인 고객의 구매내역 <mysql join>
  SELECT c.*
	 , o.orderid 
	 , o.bookid 
	 , o.orderdate 
	 , o.saleprice 
  FROM Customer c, Orders o
 WHERE c.custid = o.custid -- JOIN 조건
   AND c.custid = 3;   -- 필터링 조건
   
-- custid가 3번인 고객의 구매내역 <sql 표준 join>
   SELECT c.*
	 , o.orderid 
	 , o.bookid 
	 , o.orderdate 
	 , o.saleprice 
  FROM Customer c
  INNER JOIN Orders o
     ON c.custid = o.custid	-- JOIN 조건
  WHERE c.custid = 3;		-- 필터링 조건
  
-- 고객의 이름과 고객이 주문한 도서의 판매가격을 조회하시오
SELECT c.name, o.saleprice
  FROM Customer c
  INNER JOIN Orders o
  ON c.custid = o.custid;

SELECT c.name "고객명"
     , sum(o.saleprice) "총 판매액"
  FROM Customer c
  INNER JOIN Orders o
  ON c.custid = o.custid
GROUP BY c.name
ORDER BY c.name;

-- 세 테이블을 조인해서 각 고객과 도서명을 모두 조회하시오
-- Customer 테이블과 Book 테이블 간의 조인은 불가능
-- 중간 매개체가 Orders 테이블
SELECT c.name, c.address, c.phone
     , b.bookname, b.publisher, b.price 
     , o.orderdate, o.saleprice 
  FROM Book b
  INNER JOIN Orders o
  ON b.bookid = o.bookid 
  INNER JOIN Customer c
  ON o.custid = c.custid;

-- 외부 조인
-- LEFT OUTER JOIN
-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 조회하시오
SELECT *
  FROM Customer c left OUTER JOIN Orders o
    ON c.custid = o.custid;

-- 고객으로 회원가입은 해놓고 책을 한번도 구매하지 않은 사람을 조회하시오
SELECT *
  FROM Customer c left OUTER JOIN Orders o
    ON c.custid = o.custid
 WHERE o.orderid IS NULL;

-- 책 중에서 한번도 팔리지 않은 책 정보도 같이 조회하시오
SELECT *
  FROM Orders o RIGHT OUTER JOIN Book b
  ON o.bookid = b.bookid;

-- 최종적으로 book을 기준으로 일치하지 않는 주문과 고객이 NULL 표시
SELECT *
  FROM Customer c RIGHT OUTER JOIN Orders o
  ON c.custid = o.custid
  RIGHT OUTER JOIN Book b
  ON o.bookid = b.bookid;

-- 최종적으로 customer를 기준으로 일치하지 않는 주문과 책을 NULL 표시
SELECT *
  FROM Customer c LEFT OUTER JOIN Orders o
  ON c.custid = o.custid
  LEFT OUTER JOIN Book b
  ON o.bookid = b.bookid;

-- 이런 경우는 별로 없음
SELECT *
  FROM Customer c LEFT OUTER JOIN Orders o
  ON c.custid = o.custid
  RIGHT OUTER JOIN Book b
  ON o.bookid = b.bookid;

-- std 표준편차
SELECT o.custid
	 , avg(o.saleprice)
	 , std(o.saleprice)
 FROM Orders o
 GROUP BY o.custid;


