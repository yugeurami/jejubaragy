-- ADMIN -- 
SELECT * FROM ADMIN;
-- 관리자 로그인
SELECT * FROM ADMIN WHERE AID='admin' AND APW='123';
-- 아이디 중복 확인
SELECT * FROM ADMIN WHERE AID = 'aaa';
-- 관리자 등록
INSERT INTO ADMIN( AID, APW, ANAME) VALUES('admin', '123', '홍길동');
--관리자 수
SELECT COUNT(*) CNT FROM ADMIN;
--관리자 목록
SELECT * 
    FROM (SELECT ROWNUM RN, A.* FROM 
                (SELECT * FROM ADMIN ORDER BY AID, ANAME) A)
    WHERE RN BETWEEN 1 AND 10;
-- 관리자 삭제
DELETE FROM ADMIN WHERE AID = 'aaa';


-- MEMBER --
SELECT * FROM MEMBER;
-- 아이디 중복 확인
SELECT * FROM MEMBER WHERE MID = 'aaa';
-- 회원 가입
INSERT INTO MEMBER(MID, MPW, MNAME, MPHOTO)
                VALUES('aaa', '111', '홍길동', NULL);
                
-- 로그인
SELECT * FROM MEMBER 
    WHERE MID = 'aaa' AND MPW = '111' AND MSTATUS = 1;

-- 총 회원 수
SELECT COUNT(*) CNT FROM MEMBER;
-- 회원 목록(PAGING)
SELECT * 
    FROM (SELECT ROWNUM RN,  A.*
                    FROM (SELECT * FROM MEMBER ORDER BY MSTATUS DESC, MID, MRDATE DESC) A)
                    WHERE RN BETWEEN 1 AND 10;
-- 회원 검색
SELECT * 
    FROM (SELECT ROWNUM RN, A.*
                    FROM (SELECT * FROM MEMBER
                                WHERE MID LIKE '%'||'a'||'%' AND
                                           MNAME LIKE '%'||'홍'||'%' AND
                                           MSTATUS = 1
                                ORDER BY MID, MRDATE DESC) A );
-- 회원 정보 수정
UPDATE MEMBER 
    SET MPW = '111',
          MNAME = '박길동',
          MPHOTO = NULL
    WHERE MID = 'bbb';
    
-- 회원 탈퇴(삭제)
UPDATE MEMBER SET MSTATUS = 1 WHERE MID = 'aaa';


-- CATEGORY -- 
-- 카테고리 목록
SELECT * FROM CATEGORY;
-- 카테고리 등록
INSERT INTO CATEGORY (CNUM, CNAME)
                    VALUES(CATEGORY_SEQ.NEXTVAL, '관광명소');
-- 카테고리 수정
UPDATE CATEGORY SET CNAME = '관광명소' WHERE CNUM = 1;
-- 카테고리 삭제
DELETE FROM CATEGORY WHERE CNUM = 1; 

-- TRAVELSPOT -- 
-- 여행지 목록
SELECT * FROM TRAVELSPOT;
-- 여행지 등록

-- 여행지 수정
-- 여행지 삭제


-- ROUTE / DETAILROUTE / STORAGE -- 
-- 루트 목록
-- 루트 생성
-- 루트 수정
-- 루트 저장
-- 타인 루트 저장
-- 