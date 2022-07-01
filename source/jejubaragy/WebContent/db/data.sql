--ADMIN
INSERT INTO ADMIN( AID, APW, ANAME) VALUES('admin', '123', '홍길동');


-- MEMBER
INSERT INTO MEMBER(MID, MPW, MNAME, MPHOTO)
                VALUES('aaa', '111', '홍길동', 'noImage.png');
     
                
-- CATEGORY
INSERT INTO CATEGORY (CCODE, CNAME)
                    VALUES('CT1', '문화시설');
INSERT INTO CATEGORY (CCODE, CNAME)
                    VALUES('AT4', '관광명소');
INSERT INTO CATEGORY (CCODE, CNAME)
                    VALUES('AD5', '숙박');
INSERT INTO CATEGORY (CCODE, CNAME)
                    VALUES('FD6', '음식점');
INSERT INTO CATEGORY (CCODE, CNAME)
                    VALUES('CE7', '카페');


-- SPOT                   
INSERT INTO SPOT(SID, CCODE, SNAME, SPHOTO, SADDRESS, DESCRIPTION )
                    VALUES(7912085, 'AT4', '비자림', '비자림.jpg', '제주특별자치도 제주시 구좌읍 평대리 3161-1',  '걷기 좋은 비자숲길');                    
                    

-- BOARD
INSERT INTO BOARD(BNUM, MID, AID, BWRITER, RNUM, BTITLE, BCONTENT, BMAINPHOTO, BHIT, BIP, BRDATE)
                VALUES(BOARD_SEQ.NEXTVAL, 'aaa' , NULL, '홍길동', NULL, '게시글1', '안녕하세요', NULL, 0, '126.00.001', SYSDATE);
INSERT INTO BOARD(BNUM, MID, AID, BWRITER, RNUM, BTITLE, BCONTENT, BMAINPHOTO, BHIT, BIP, BRDATE)
                VALUES(BOARD_SEQ.NEXTVAL, NULL , 'admin', '관리자', NULL, '게시글1', '안녕하세요', NULL, 0, '126.00.001', SYSDATE);



-- COMMENTS
INSERT INTO COMMENTS(CID, MID, AID, CWRITER, CPHOTO, BNUM, CCONTENT, CGROUP, CSTEP, CINDENT, CRDATE, CIP)
                    VALUES(COMMENTS_SEQ.NEXTVAL, NULL, 'admin', '관리자', NULL, 1, '글 작성 감사합니다', COMMENTS_SEQ.CURRVAL, 0, 0, SYSDATE, '127.00.001');





COMMIT;