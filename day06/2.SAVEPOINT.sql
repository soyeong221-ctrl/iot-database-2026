-- 4. Kim -> Lee 송금 중 문제 발생
-- SAVEPOINT 다시!
START TRANSACTION;

-- Kim에서 출금
UPDATE accounts
  SET balance = balance - 1000
 WHERE id = 1;

SAVEPOINT sp_transfer;

-- Lee에게 입금
UPDATE accounts
  SET balance = balance + 1000
 WHERE id = 3;

SELECT * FROM accounts;

ROLLBACK TO sp_transfer;

COMMIT;
ROLLBACK;

-- 현재 MySQL DB엔진 종류확인
-- InnoDB(최신버전 엔진), MyISAM(구버전 5.5이하)
-- MyISAM 트랜잭션 처리가 필요 x
SHOW TABLE status LIKE 'accounts';

-- 현재 실행중인 트랜잭션 조회 쿼리(root만 가능)
SELECT * FROM information_schema.INNODB_TRX it;




