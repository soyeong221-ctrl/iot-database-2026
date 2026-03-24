-- 대량삽입 저장프로시저 실행
CALL insert_big_orders(10); -- 한 번에 100만건 씩 10번 수행

-- orders_big 테이블 데이터 개수 확인
SELECT count(*) FROM orders_big;