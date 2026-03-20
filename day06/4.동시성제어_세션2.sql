-- 세션 2번

select @@autocommit;

set autocommit = 0;

--START TRANSACTION;

UPDATE accounts
   SET balance = balance - 500
 WHERE id = 2;

SELECT * FROM accounts;

-- 다른 세션에서 다른 데이터를 수정
UPDATE accounts
   SET balance = balance - 1500
 WHERE id = 3;

 COMMIT;

ROLLBACK;


-- Non-Repeatable Read
-- 격리수준 하강
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- 격리수준 원상태 복귀
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

UPDATE accounts
   SET balance = 30000
 WHERE id = 1;

 Commit;

 -- Phantom Read 세션 2
 INSERT INTO employees (name, salary) values ('Dred', 6500);

select * from employees;

rollback;
commit;

-- Deadlock
-- AutoCommit 해제
SELECT @@autocommit;
SET autocommit = 0;

select * from accounts;
select * from employees;


-- 6번 id 급여를 8000으로 변경
UPDATE employees
  SET salary = 8000
WHERE id = 6;

rollback;

-- 다른 세션의 5번 id 급여를 100 증가
UPDATE employees
  SET salary = salary + 100
WHERE id = 5;

UPDATE accounts
  SET balance = 7000
where id = 2;

-- 테이블락
select * from accounts;

UPDATE accounts
  SET balance = 9000
 WHERE id = 3;

rollback;