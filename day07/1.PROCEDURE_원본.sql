-- 프로시저 원문
CREATE PROCEDURE madangdb.prc_insertBook(
	IN vbookID INT,
	IN vbookName varchar(40),
	IN vpublisher varchar(40),
	IN vprice int

)
BEGIN
	INSERT INTO Book (bookid, bookname, publisher, price)
	VALUES (vbookId, vbookName, vpublisher, vprice);
END;


-- 수정/추가 동시 진행 프로시저
CREATE PROCEDURE madangdb.prc_InsertOrUpdateBook(
	IN vbookID INT,
	IN vbookName varchar(40),
	IN vpublisher varchar(40),
	IN vprice int
)
BEGIN
	DECLARE vcount int;
	-- 같은 책이 있는지 확인
	SELECT count(*) INTO vcount
	  FROM Book
	 WHERE bookname LIKE vbookName;

	IF vcount != 0 THEN
		SET SQL_SAFE_UPDATES=0;	-- MySQL 안전 업데이트모드
		-- 같은 데이터가 있으니 업데이트
		UPDATE Book
		   SET price = vprice
		     , publisher = vpublisher
		 WHERE bookname LIKE vbookName; -- 원래 PK로 조건필요
	ELSE 
		-- 새로 추가!
		INSERT INTO Book VALUES
		(vbookId, vbookName, vpublisher, vprice);
	END IF;
END;


-- OUT 파라미터
CREATE PROCEDURE madangdb.prc_getAveragePrice(
	OUT AverageVal INT
)
BEGIN
	SELECT avg(price) INTO AverageVal
	  FROM Book
	 WHERE price IS NOT NULL;
END;


-- 커서 사용 프로시저
CREATE PROCEDURE madangdb.prc_getinterest(

)
BEGIN
	DECLARE vinterest int DEFAULT 0; -- 총 이윤 담을 변수
	DECLARE vprice int; -- 커서당 Order 테이블 saleprice 각각 담을 변수
	DECLARE endOfRow Boolean DEFAULT FALSE; -- 커서 마지막 확인 변수
	DECLARE interestCursor CURSOR FOR -- 커서 변수
		SELECT saleprice FROM Orders; -- Orders 테이블 saleprice를 하나씩
		
	-- 더이상 Fetch할 게 없으면 endOfRow를 TRUE로 변경하라는 뜻	
	  DECLARE CONTINUE handler FOR
	  NOT FOUND SET endOfRow=TRUE;

	  OPEN interestCursor; -- 커서 오픈
	  cursor_loop: LOOP -- 커서 반복
		-- Orders의 saleprice 값이 반복적으로 vprice에 할당
	  	FETCH interestCursor INTO vprice;
	  	-- endOrRow가 TRUE가 되면 커서반복문 탈출(break와 동일)
	  	IF endOfRow THEN LEAVE cursor_loop;
	    END IF;
	  
	  	-- vprice에 들어온 값이 30000원 이상이면 10% 이윤 계산
	    -- 이하면 5% 이윤 계산
	    IF vprice >= 30000 THEN
	    	SET vinterest = vinterest + vprice * 0.1;
	    ELSE
	    	SET vinterest = vinterest + vprice * 0.05;	    
	    END IF;
	  END LOOP cursor_loop;
	  CLOSE interestCursor; -- 커서 종료	
	  
	  SELECT concat('전체 이익금 = ', vinterest);
END

