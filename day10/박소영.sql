-- 1. 현재 대여 중인 도서를 조회하시오.

SELECT m.member_name "회원명", b.book_name "책제목", r.rentalDate "대여일"
  FROM rentals r
  JOIN books b
    ON r.book_idx = b.book_idx
  JOIN members m
    ON r.member_idx = m.member_idx
 WHERE r.returnDate IS NULL;


-- 2. 회원별 대여 횟수를 집계하시오. order by만 잘하면 됨~

SELECT m.member_idx "회원번호", m.member_name "회원명", count(r.rental_idx) "대여횟수"
  FROM rentals r
  JOIN members m
    ON r.member_idx = m.member_idx
 GROUP BY m.member_idx, m.member_name
 ORDER BY count(r.rental_idx) DESC, m.member_name ASC;
    

-- 3. 장르별 도서수를 조회하시오.

SELECT d.div_code "장르코드", d.div_name "장르명", count(b.book_idx) "도서수"
  FROM division d 
  LEFT OUTER JOIN books b
    ON d.div_code = b.div_code 
 GROUP BY d.div_code, d.div_name;


-- 4. 한번도 대여되지 않은 도서를 조회하시오. (잔혹한 어머니의 날 1 부터 총 46건)
 
SELECT b.book_name 
  FROM books b
  LEFT OUTER JOIN rentals r
    ON b.book_idx = r.book_idx
 WHERE r.rental_idx IS NULL;
    

-- 5. 평균 대여수보다 많이 대여한 회원을 조회하시오. (서브쿼리 사용 유무 확인)

SELECT m.member_idx "회원번호", m.member_name "회원명", count(r.rental_idx) "대여횟수"
  FROM members m
  JOIN rentals r
    ON m.member_idx = r.member_idx 
 GROUP BY m.member_idx , m.member_name 
HAVING COUNT(r.rental_idx) > (SELECT AVG(sub.c)
							    FROM (SELECT COUNT(rental_idx) AS c
							            FROM rentals
							           GROUP BY member_idx) AS sub);

