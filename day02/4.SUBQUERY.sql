-- 부속질의_SQL 문 내에 또 다른 SQL 문을 작성해보자
-- 가장 비싼 도서의 이름을 조회하시오

SELECT b.price, b.bookname
  FROM Book b
 WHERE b.price >= (SELECT max(b.price)
 					FROM Book b);