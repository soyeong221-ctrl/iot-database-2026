-- 도서번호가 1인 도서의 이름
SELECT bookid, bookname
  FROM Book
 WHERE bookid = 1;

-- 가격이 20,000원 이상인 도서의 이름
SELECT bookname, price
  FROM Book
 WHERE price >= 20000;

-- 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
 SELECT *
   FROM Customer
  WHERE name = '박지성';

SELECT sum(saleprice)
  FROM Orders
 WHERE custid = 1;

-- 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
 SELECT count(*)
  FROM Orders
 WHERE custid = 1;

-- 마당서점 도서의 총 개수
 SELECT count(*)
 FROM Book;

-- 마당서점에 도서를 출고하는 출판사의 총 개수
 SELECT count(DISTINCT publisher)
   FROM Book;

-- 2024년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서의 주문번호
-- Date형은 문자열이 아니지만 날짜를 검색할 때 문자열로 비교검색 가능
-- between str_to_date('2024-07-04', '%Y-%m-%d') 써도 됨
 SELECT *
   FROM Orders o
  WHERE orderdate BETWEEN '2024-07-04'
    AND '2024-07-07';

-- 2024년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
SELECT *
   FROM Orders o
  WHERE orderdate NOT BETWEEN '2024-07-04'
    AND '2024-07-07';

-- 성이 '김'씨인 고객의 이름과 주소
SELECT *
  FROM Customer c
 WHERE c.name LIKE '김%';

-- 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT c.name, c.address
  FROM Customer c
 WHERE c.name LIKE '김%아';


