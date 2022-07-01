DROP TABLE COMMENTS; 
DROP TABLE STORAGE;
DROP TABLE BOARD;
DROP TABLE DETAILROUTE;
DROP TABLE SPOT;
DROP TABLE CATEGORY;
DROP TABLE ROUTE;
DROP TABLE ADMIN;
DROP TABLE MEMBER;

DROP SEQUENCE COMMENTS_SEQ;
DROP SEQUENCE STORAGE_SEQ;
DROP SEQUENCE DETAILROUTE_SEQ;
DROP SEQUENCE ROUTE_SEQ;
DROP SEQUENCE BOARD_SEQ;


CREATE TABLE MEMBER(
    MID         VARCHAR2(30) PRIMARY KEY,
    MPW        VARCHAR2(30) NOT NULL,
    MNAME    VARCHAR2(30) NOT NULL,
    MPHOTO  VARCHAR2(100),
    MRDATE   DATE DEFAULT SYSDATE,
    MSTATUS NUMBER(1) DEFAULT 1 );

CREATE TABLE ADMIN(
    AID     VARCHAR(30) PRIMARY KEY,
    APW    VARCHAR2(30) NOT NULL,
    ANAME VARCHAR2(30) NOT NULL );
    
CREATE TABLE ROUTE(
    RNUM        NUMBER(9) PRIMARY KEY,
    RNAME       VARCHAR2(100) NOT NULL,
    MID            VARCHAR2(30) REFERENCES MEMBER(MID),
    RSTARTDATE DATE     NOT NULL,
    RENDDATE    DATE     NOT NULL,
    RPRIVATE     NUMBER(1) NOT NULL);
    
CREATE TABLE CATEGORY(
    CCODE    VARCHAR2(10) PRIMARY KEY,
    CNAME   VARCHAR2(50) NOT NULL );

CREATE TABLE SPOT(
    SID                 NUMBER(9) PRIMARY KEY,
    CCODE            VARCHAR2(10) REFERENCES CATEGORY(CCODE),
    SNAME            VARCHAR2(200) NOT NULL,
    SPHOTO          VARCHAR2(1000),
    SADDRESS        VARCHAR2(300),
    DESCRIPTION    VARCHAR2(1000)   );
    
CREATE TABLE DETAILROUTE(
    DNUM    NUMBER(9) PRIMARY KEY,
    RNUM    NUMBER(9) REFERENCES ROUTE(RNUM),
    SID        NUMBER(9) REFERENCES SPOT(SID),
    DDATE   DATE    NOT NULL,
    DSEQ    NUMBER(5) NOT NULL  );
    
CREATE TABLE BOARD(
    BNUM        NUMBER(9) PRIMARY KEY,
    MID           VARCHAR2(30) REFERENCES MEMBER(MID),
    AID            VARCHAR2(30) REFERENCES ADMIN(AID),
    BWRITER    VARCHAR2(30),
    RNUM        NUMBER(9)   REFERENCES  ROUTE(RNUM),
    BTITLE         VARCHAR2(50) NOT NULL,
    BCONTENT    CLOB NOT NULL,
    BMAINPHOTO VARCHAR2(2000),
    BHIT            NUMBER(5) DEFAULT 0 NOT NULL,
    BIP             VARCHAR2(50) NOT NULL,
    BRDATE      DATE DEFAULT SYSDATE NOT NULL     );

CREATE TABLE STORAGE(
    SNUM    NUMBER(9) PRIMARY KEY,
    MID       VARCHAR2(30) REFERENCES MEMBER(MID),
    RNUM    NUMBER(9) REFERENCES ROUTE(RNUM)    );
    
    
CREATE TABLE COMMENTS(
    CID             NUMBER(9) PRIMARY KEY,
    MID            VARCHAR2(30) REFERENCES MEMBER(MID),
    AID             VARCHAR2(30) REFERENCES ADMIN(AID),
    CWRITER      VARCHAR2(30),
    CPHOTO      VARCHAR2(100),
    BNUM         NUMBER(9)  REFERENCES BOARD(BNUM),
    CCONTENT   VARCHAR2(200) NOT NULL,
    CGROUP      NUMBER(9)   NOT NULL,
    CSTEP         NUMBER(6) NOT NULL,
    CINDENT     NUMBER(6) NOT NULL,
    CRDATE      DATE DEFAULT SYSDATE NOT NULL,
    CIP             VARCHAR2(50) NOT NULL   );
    
    
CREATE SEQUENCE COMMENTS_SEQ MAXVALUE 999999999 NOCACHE NOCYCLE;
CREATE SEQUENCE STORAGE_SEQ MAXVALUE 999999999 NOCACHE NOCYCLE;
CREATE SEQUENCE DETAILROUTE_SEQ MAXVALUE 999999999 NOCACHE NOCYCLE;
CREATE SEQUENCE ROUTE_SEQ MAXVALUE 999999999 NOCACHE NOCYCLE;
CREATE SEQUENCE BOARD_SEQ MAXVALUE 999999999 NOCACHE NOCYCLE;