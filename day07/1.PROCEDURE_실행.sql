-- 프로시저 실행

CALL prc_InsertBook(43, '무명책', '무명도서', 3000000);

SELECT *
  FROM Book;


-- 프로시저 실행
CALL prc_InsertOrUpdateBook(44, '스포츠의 즐거움', '마당체육', 25000);

-- 재실행
CALL prc_InsertOrUpdateBook(44, '스포츠의 즐거움', '마당체육', 35000);


-- OUT 파라미터
SELECT avg(price)
	  FROM Book
	 WHERE price IS NOT NULL;

CALL prc_getAveragePrice(@myVal);
SELECT @myVal;


-- 커서 실행 프로시저, 입출력 파라미터가 없으면 () 생략 가능
CALL prc_getInterest;




