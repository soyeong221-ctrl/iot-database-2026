/* 동시성 제어(Concurrency Control) */

-- 테이블 수정
ALTER TABLE accounts
MODIFY owner varchar(40) NOT NULL,
MODIFY balance int NOT NULL;

truncate TABLE accounts;

SELECT * FROM accounts;

SELECT @@autocommit;

ROLLBACK;
COMMIT;

-- 새로 데이터 입력
INSERT INTO accounts (id, owner, balance)
VALUES (1, 'Kim', 10000), (2, 'Lee', 20000), (3, 'Sung', 10000000);

SELECT * FROM accounts;

-- 기본 락 실행
-- 세션 1번
-- START TRANSACTION;

UPDATE accounts
   SET balance = balance - 1000
 WHERE id = 2;	

SELECT * FROM accounts;

COMMIT;
ROLLBACK;

-- Non-Repeatable Read
-- 격리수준 하강
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT balance FROM accounts WHERE id = 1;

-- 격리수준 원상태 복귀
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

COMMIT;


-- Phantom Read
-- 테이블 생성
CREATE TABLE employees 
( id int PRIMARY KEY AUTO_INCREMENT,
  name varchar(50),
  salary Int
);

INSERT INTO employees (name, salary)
values ('Ashely', 3000), ('Bread', 4000), ('Canton', 6000);


SELECT * FROM employees;

COMMIT;
ROLLBACK;

-- 팬텀 리드 세션 1
-- 격리수준 하강

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT * FROM employees WHERE salary >= 5000;


-- Deadlock
-- AutoCommit 해제
SELECT @@autocommit;
SET autocommit = 0;

COMMIT;

-- 5번 id 직원 급여를 7000으로 변경
UPDATE employees
  SET salary = 7000
WHERE id = 5;

SELECT * FROM employees;

UPDATE accounts
  SET balance = 9000
where id = 2;


-- 테이블 락
LOCK TABLES accounts WRITE;
LOCK TABLES accounts READ; -- 읽기 가능 테이블락

SELECT * FROM accounts;

UPDATE accounts
  SET balance = 9000
 WHERE id = 3;

UNLOCK TABLES;

