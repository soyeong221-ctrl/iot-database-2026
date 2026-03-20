-- 함수 원형 fnc_Interest

CREATE FUNCTION fnc_Interest(
	price INT
)
RETURNS INT
BEGIN
	
	-- 변수 선언
	DECLARE myInterest INT;
	-- 가격이 30,000원 이상이면 10%, 그 미만은 5% 이윤 남김
	
	IF price >= 30000 THEN
		SET myInterest = price * 0.1;
	ELSE
		SET myInterest = price * 0.05;
	END IF;
	
	RETURN myInterest;
	
END;

-- 함수 원형 fnc_balanceGrade
CREATE FUNCTION fnc_balanceGrade(
	balance integer
)
RETURNS varchar(20)
deterministic
BEGIN
	DECLARE grade varchar(20);

	IF balance >= 50000 THEN
		SET grade = 'VIP';
	ELSEIF balance >= 20000 THEN
		SET grade = 'GOLD';
	ELSE
		SET grade = 'SILVER';
	
	END IF;
	
	RETURN grade;
	
END;