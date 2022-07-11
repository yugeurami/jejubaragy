--ADMIN
INSERT INTO ADMIN( AID, APW, ANAME) VALUES('admin', '123', '홍길동');


-- MEMBER
INSERT INTO MEMBER(MID, MPW, MNAME, MPHOTO)
                VALUES('aaa', '111', '홍길동', 'noImage.png');
INSERT INTO MEMBER(MID, MPW, MNAME, MPHOTO)
                VALUES('bbb', '111', '김길동', 'noImage.png');    
                
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
INSERT INTO SPOT(SID, CCODE, SNAME, SPHOTO, SADDRESS, DESCRIPTION )
                    VALUES(1508345156, 'CT1', '아르떼뮤지엄 제주', '아르떼뮤지엄.png', '제주특별자치도 제주시 애월읍 어림비로 478',  '빛이 가득한 감성 넘치는 전시를 볼 수 있는 미술관');   
INSERT INTO SPOT(SID, CCODE, SNAME, SPHOTO, SADDRESS, DESCRIPTION )
                    VALUES(1682547680, 'CT1', '빛의 벙커', '빛의벙커.jpg', '제주특별자치도 서귀포시 성산읍 고성리 2039-22',  '빛이 가득한 아름다운 벙커');   

-- BOARD
INSERT INTO BOARD(BNUM, MID, AID, BWRITER, BTITLE, BCONTENT, BMAINPHOTO, BHIT, BIP, BRDATE)
                VALUES(BOARD_SEQ.NEXTVAL, 'aaa' , NULL, '홍길동', '게시글1', '안녕하세요', NULL, 0, '126.00.001', SYSDATE);
INSERT INTO BOARD(BNUM, MID, AID, BWRITER, BTITLE, BCONTENT, BMAINPHOTO, BHIT, BIP, BRDATE)
                VALUES(BOARD_SEQ.NEXTVAL, NULL , 'admin', '관리자', '게시글1', '안녕하세요', NULL, 0, '126.00.001', SYSDATE);
INSERT INTO BOARD(BNUM, MID, AID, BWRITER,  BTITLE, BCONTENT, BMAINPHOTO, BHIT, BIP, BRDATE)
                VALUES(BOARD_SEQ.NEXTVAL, 'bbb' , NULL, '김길동', '게시글3', '안녕하세요', NULL, 0, '126.00.001', SYSDATE);


-- COMMENTS
INSERT INTO COMMENTS(CID, MID, AID, CWRITER, CPHOTO, BNUM, CCONTENT, CGROUP, CSTEP, CINDENT, CRDATE, CIP)
                    VALUES(COMMENTS_SEQ.NEXTVAL, NULL, 'admin', '관리자', NULL, 1, '글 작성 감사합니다', COMMENTS_SEQ.CURRVAL, 0, 0, SYSDATE, '127.00.001');
INSERT INTO COMMENTS(CID, MID, AID, CWRITER, CPHOTO, BNUM, CCONTENT, CGROUP, CSTEP, CINDENT, CRDATE, CIP)
                    VALUES(COMMENTS_SEQ.NEXTVAL, 'bbb' , NULL, '김길동', 'noImage.png', 1, '좋은 글이네요', COMMENTS_SEQ.CURRVAL, 0, 0, SYSDATE, '127.00.001');


--ROUTE
INSERT INTO ROUTE(RNUM, RNAME, MID, RSTARTDATE, RENDDATE, RPRIVATE)
                VALUES(ROUTE_SEQ.NEXTVAL, '제주도 첫 여행', 'aaa', '2022-10-10', '2022-10-15' , 1);
INSERT INTO ROUTE(RNUM, RNAME, MID, RSTARTDATE, RENDDATE, RPRIVATE)
                VALUES(ROUTE_SEQ.NEXTVAL, '제주도 첫 여행', 'bbb', '2022-10-10', '2022-10-15' , 1);

--DETAILROUTE
INSERT INTO DETAILROUTE(DNUM, RNUM, SID, DDATE, DSEQ)
                VALUES(DETAILROUTE_SEQ.NEXTVAL, 1, 7912085, 1, 1);
            
            
            
                
COMMIT;