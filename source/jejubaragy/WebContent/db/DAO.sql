-- ADMIN -- 
SELECT * FROM ADMIN;
-- 관리자 로그인
SELECT * FROM ADMIN WHERE AID='admin' AND APW='123';
-- 아이디 중복 확인
SELECT * FROM ADMIN WHERE AID = 'admin';
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
                                ORDER BY MID, MRDATE DESC) A )
    WHERE RN BETWEEN 1 AND 10;
-- 탈퇴/강등 회원 검색
SELECT * 
    FROM (SELECT ROWNUM RN, A.*
                    FROM (SELECT * FROM MEMBER
                                WHERE MID LIKE '%'||'a'||'%' AND
                                           MNAME LIKE '%'||'홍'||'%' AND
                                           MSTATUS = 0
                                ORDER BY MID, MRDATE DESC) A )
    WHERE RN BETWEEN 1 AND 10;
-- 회원 정보 수정
UPDATE MEMBER 
    SET MPW = '111',
          MNAME = '홍길동',
          MPHOTO = 'noImage.png'
    WHERE MID = 'aaa';
    
-- 회원 탈퇴(삭제)
UPDATE MEMBER SET MSTATUS = 0 WHERE MID = 'aaa';


-- CATEGORY -- 
-- 카테고리 목록
SELECT * FROM CATEGORY ORDER BY CCODE;



-- SPOT -- 
SELECT * FROM SPOT;
-- 여행지 검색해서 출력(카테고리/장소명/좌표)
SELECT A.*, CNAME 
    FROM (SELECT * FROM SPOT
                WHERE CCODE = 'AT4' AND
                SNAME LIKE '%'||' '||'%' ) A, CATEGORY C
    WHERE A.CCODE=C.CCODE
    ORDER BY SNAME;
    
    
-- 여행지 하나 자세히 보기(+관련 글도 보이게 해야함 BOARD 쿼리에 만들기)
SELECT S.*, CNAME 
    FROM SPOT S, CATEGORY C
    WHERE S.CCODE=C.CCODE AND SID=7912085;


-- 중복된 여행지 체크
SELECT * FROM SPOT WHERE SID = 7912085;

-- 여행지 등록
INSERT INTO SPOT(SID, CCODE, SNAME, SPHOTO, SADDRESS, DESCRIPTION )
                    VALUES(7912085, 'AT4', '비자림', '비자림.jpg', '제주특별자치도 제주시 구좌읍 평대리 3161-1',  '걷기 좋은 비자숲길');     
-- 여행지 수정
UPDATE SPOT
    SET CCODE = 'AT4',
          SNAME = '비자림',
          SPHOTO = '비자림.jpg',
          SADDRESS = '제주특별자치도 제주시 구좌읍 평대리 3161-1',
          DESCRIPTION = '걷기 좋은 비자숲길'
    WHERE SID = 7912085;

-- 여행지 삭제
DELETE FROM SPOT WHERE SID = 7912085;


-- ROUTE / DETAILROUTE / STORAGE -- 
-- 루트 목록
-- 루트 생성
-- 루트 수정
-- 루트 저장
-- 타인 루트 저장

-- BOARD
-- 자세히 보기한 여행지가 포함된 글 찾기
SELECT * FROM BOARD
    WHERE RNUM = ( SELECT RNUM FROM DETAILROUTE WHERE SID = 7912085 )
    ORDER BY BHIT DESC;