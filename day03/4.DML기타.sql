-- INSERT, UPDATE, DELETE

/* INSERT */

-- Book 테이블에 새로운 도서 '스포츠 의학' 삽입. 스포츠 의학은 한솔의학서적에서 출간. 가격은 90,000원.
INSERT INTO Book(bookid, bookname, publisher, price)
VALUES (11, '스포츠 의학', '한솔의학서적' , 90000);

SELECT * 
  FROM Book;

INSERT INTO Book(bookid, bookname, publisher)
VALUES (12, '스포츠 의학', '한솔의학서적');

-- 대량입력 준비
CREATE TABLE Imported_Book (
  bookid		INTEGER,
  bookname	VARCHAR(40),
  publisher	VARCHAR(40),
  price		INTEGER
);

INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);
COMMIT;

SELECT * FROM Imported_Book;
SELECT * FROM Book;

-- 대량입력(BULK INSERT)
INSERT INTO Book(bookid, bookname, publisher, price)
SELECT bookid, bookname, publisher, price FROM Imported_Book;


/* UPDATE */
-- Customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 수정하시오
SELECT * 
  FROM Customer
 WHERE custid = 5;

SELECT * from Customer;

SET SQL_SAFE_UPDATES=1;  -- SQL 안전모드 켜기

UPDATE Customer
SET address = '대한민국 부산'
  , phone = '010-0000-0000'
 WHERE custid = 5;  -- WHERE 절이 빠지는 순간, 끔찍한 일이 벌어짐


-- Book 테이블에서 14번 '스포츠의학'의 출판사를 imported_book 테이블의 21번 책의 출판사와 동일하게 변경하시오

 -- 14번 데이터 추가
INSERT INTO Book(bookid, bookname, publisher)
VALUES (14, '스포츠 의학3', 'Pearson');

SELECT * FROM Book;

UPDATE Book
   SET publisher = (SELECT publisher 
   					  FROM Imported_Book
					 WHERE bookid = 22)
WHERE bookid = 14;


/* DELETE */
-- 수정과 삭제 전 아래쿼리 확인
SELECT * FROM Book_copy
 WHERE bookid = 6;

DELETE FROM Book_copy
 WHERE bookid = 6;

-- Customer 복사
CREATE TABLE Customer_Copy
SELECT * FROM Customer;

SELECT * FROM Customer_Copy;

-- 삭제여부 컬럼 추가
ALTER TABLE Customer_Copy
 ADD COLUMN ISDEL char(1);

-- 삭제를 하지 않고 삭제플래그를 활용
update Customer_Copy
   SET ISDEL = 'Y'  
 WHERE custid = 4;

-- ISDEL이 NULL이거나 'N'(탈퇴하지않음)
SELECT * FROM Customer_Copy
 WHERE ISDEL IS NULL
	OR ISDEL = 'N';

