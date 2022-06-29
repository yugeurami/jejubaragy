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


--SPOT                   
INSERT INTO SPOT(SID, CCODE, SNAME, SPHOTO, SADDRESS, DESCRIPTION )
                    VALUES(7912085, 'AT4', '비자림', '비자림.jpg', '제주특별자치도 제주시 구좌읍 평대리 3161-1',  '걷기 좋은 비자숲길');                    
                    




COMMIT;