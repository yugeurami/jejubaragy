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
-- 내 루트 목록(페이징)
SELECT *
    FROM (SELECT ROWNUM RN, A.*
                FROM (SELECT *
                            FROM ROUTE 
                            WHERE MID = 'aaa'
                            ORDER BY RSTARTDATE DESC)  A )
    WHERE RN BETWEEN 1 AND 10;

-- 전체 공개 루트 목록(페이징)
SELECT *
    FROM (SELECT  A.*
                FROM (SELECT R.*, MNAME 
                            FROM ROUTE R, MEMBER M  
                            WHERE R.MID=M.MID AND RPRIVATE = 1 
                            ORDER BY RNUM DESC)  A );

-- 루트 생성
INSERT INTO ROUTE(RNUM, RNAME, MID, RSTARTDATE, RENDDATE, RPRIVATE)
                VALUES(ROUTE_SEQ.NEXTVAL, '제주도 첫 여행', 'aaa', '2022-10-10', '2022-10-15' , 1);
                
-- 루트 수정
UPDATE ROUTE 
    SET RNAME = '제주도 갑니다',
          RSTARTDATE = '2022-10-11',
          RENDDATE = '2022-10-15',
          RPRIVATE = 1
    WHERE RNUM = 1;
    
--루트 삭제
DELETE FROM ROUTE WHERE RNUM = 1;

-- 디테일 루트 보기
SELECT D.*, SNAME FROM DETAILROUTE D, SPOT S
    WHERE D.SID=S.SID AND RNUM = 1
    ORDER BY DDATE, DSEQ;

-- 디테일 루트 만들기(루트에 장소 추가하기)
INSERT INTO DETAILROUTE(DNUM, RNUM, SID, DDATE, DSEQ)
                VALUES(DETAILROUTE_SEQ.NEXTVAL, 1, 7912085, 1, 1);
                
-- 디테일 루트 수정
UPDATE DETAILROUTE
    SET DDATE = 0,
          DSEQ = 0
    WHERE DNUM = 1;
    
-- 디테일 루트 삭제
DELETE FROM DETAILROUTE WHERE DNUM = 1;


-- 타인 루트 저장
INSERT INTO STORAGE(SNUM, MID, RNUM)
                VALUES(STORAGE_SEQ.NEXTVAL, 'aaa', 2);
                
-- 타인 루트 삭제
DELETE FROM STORAGE WHERE SNUM = 1;



-- BOARD
-- 총 게시글 수
SELECT COUNT(*) CNT FROM BOARD;

-- 게시글 페이징
SELECT * 
    FROM (  SELECT ROWNUM RN, A.*
                    FROM (  SELECT *
                                    FROM BOARD
                                    ORDER BY BNUM DESC) A )
    WHERE RN BETWEEN 1 AND 10;

-- 게시글 작성
INSERT INTO BOARD(BNUM, MID, AID, BWRITER, RNUM, BTITLE, BCONTENT, BMAINPHOTO, BHIT, BIP, BRDATE)
                VALUES(BOARD_SEQ.NEXTVAL, 'aaa' , NULL, '홍길동', NULL, '게시글1', '안녕하세요', NULL, 0, '126.00.001', SYSDATE);
                
-- 게시글 조회수 올리기
UPDATE BOARD SET BHIT = BHIT + 1 WHERE BNUM = 1;

-- 게시글 자세히 보기
SELECT * FROM BOARD WHERE BNUM = 1;

-- 게시글 수정
UPDATE BOARD
    SET BTITLE = '수정된 게시글',
          RNUM = 1,
          BCONTENT = '수정했습니다',
          BMAINPHOTO = NULL
    WHERE BNUM = 2;

-- 베스트 글 보기
SELECT * 
    FROM (  SELECT ROWNUM RN, A.*
                    FROM (  SELECT *
                                    FROM BOARD
                                    ORDER BY BHIT DESC) A )
    WHERE RN BETWEEN 1 AND 5;
      
-- 여행지가 포함된 글 목록
SELECT * 
    FROM (  SELECT ROWNUM RN, A.*
                    FROM (  SELECT * FROM BOARD
                                    WHERE RNUM = ( SELECT RNUM FROM DETAILROUTE WHERE SID = '' )
                                    ORDER BY BHIT DESC) A )
    WHERE RN BETWEEN 1 AND 10;
    
-- 게시글 삭제
DELETE FROM BOARD WHERE BNUM = 1;
    
    
    
-- COMMENTS
SELECT * FROM COMMENTS;
-- 해당 글의 댓글 갯수
SELECT COUNT(*) CNT FROM COMMENTS WHERE BNUM = 1;
-- 댓글 페이징
SELECT * 
    FROM ( SELECT ROWNUM RN, A.*
                FROM ( SELECT * 
                            FROM COMMENTS
                            WHERE BNUM = 1
                            ORDER BY CGROUP DESC, CSTEP) A )
    WHERE RN BETWEEN 1 AND 10;                
-- 댓글 가져오기
SELECT * FROM COMMENTS WHERE CID=1;
-- 댓글 작성
INSERT INTO COMMENTS(CID, MID, AID, CWRITER, CPHOTO, BNUM, CCONTENT, CGROUP, CSTEP, CINDENT, CRDATE, CIP)
                    VALUES(COMMENTS_SEQ.NEXTVAL, NULL, 'admin', '관리자', NULL, 1, '글 작성 감사합니다', COMMENTS_SEQ.CURRVAL, 0, 0, SYSDATE, '127.00.001');
                    
-- 대댓글 작성로직
    --이전 스텝
    UPDATE COMMENTS SET CSTEP = CSTEP + 1
        WHERE CGROUP = 1 AND CSTEP > 0 ;
    --대댓글 작성
    INSERT INTO COMMENTS(CID, MID, AID, CWRITER, CPHOTO, BNUM, CCONTENT, CGROUP, CSTEP, CINDENT, CRDATE, CIP)
                    VALUES(COMMENTS_SEQ.NEXTVAL, NULL, 'admin', '관리자', NULL, 1, '글 작성 감사합니다', 1, 1, 1, SYSDATE, '127.00.001');

-- 댓글 수정
UPDATE COMMENTS
    SET CCONTENT = '수정된 댓글입니다'
    WHERE CID = 1;   
    
-- 댓글 삭제(대댓글까지 삭제)
DELETE FROM COMMENTS 
    WHERE CGROUP = 1 AND 
                ( CSTEP >= 1 AND 
                  CSTEP<( SELECT NVL( MIN(CSTEP), 9999 ) 
                                FROM COMMENTS 
                                WHERE CGROUP = 1 AND CSTEP > 1 AND CINDENT <= 1) );
                                
                                