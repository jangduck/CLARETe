select * from tab;

show user;

create table tbl_member    
(m_id             varchar2(40)   not null  -- 회원아이디
,m_pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,m_name               varchar2(30)   not null  -- 회원명
,m_email              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,m_mobile             varchar2(200)  not null  -- 연락처 (AES-256 암호화/복호화 대상) 
,m_postcode           varchar2(5)              -- 우편번호
,m_address            varchar2(200)            -- 주소
,m_detail_address      varchar2(200)            -- 상세주소
,m_extra               varchar2(200)            -- 참고항목
,m_gender             varchar2(1)              -- 성별   남자:1  / 여자:2
,m_birth           varchar2(10)             -- 생년월일   
,m_point              number default 0         -- 포인트 
,m_register        date default sysdate     -- 가입일자 
,m_lastpwd  date        default sysdate     -- 마지막으로 암호를 변경한 날짜  
,m_status             number(1) default 1 not null     -- 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
,m_idle               number(1) default 1 not null     -- 휴면유무      1 : 활동중  /  0 : 휴면중 
,constraint PK_tbl_member_m_id primary key(m_id)
,constraint UQ_tbl_member_m_email  unique(m_email)
,constraint UQ_tbl_member_m_mobile  unique(m_mobile)
,constraint CK_tbl_member_m_gender check( m_gender in('1','2') )
,constraint CK_tbl_member_m_status check( m_status in(0,1) )
,constraint CK_tbl_member_m_idle check( m_idle in(0,1) )
);
-- Table TBL_MEMBER이(가) 생성되었습니다.

commit;
-- 커밋 완료.

select *
from tbl_member;

create table tbl_product (
    p_num          NUMBER(3)      NOT NULL, -- 제품고유번호
   p_season       NVARCHAR2(10)  NOT NULL, -- 카테고리(계절)
   p_name         NVARCHAR2(100) NOT NULL, -- 제품명
   p_ex           NVARCHAR2(500) NOT NULL, -- 제품설명
   p_price        NVARCHAR2(10)  NOT NULL, -- 가격
   p_inven        NUMBER         NOT NULL, -- 재고
   p_register     DATE           NOT NULL, -- 제품등록일
   p_release      DATE           NOT NULL, -- 발매일
   p_sale         NVARCHAR2(3)   NULL,     -- 할인률
   p_gender       number(1)      NULL,     -- 성별 향수
   p_image        NVARCHAR2(200) NOT NULL, -- 상품이미지
   p_detail_image NVARCHAR2(200) NULL      -- 상품상세이미지
    ,constraint PK_tbl_product_p_num primary key(p_num)
    ,constraint CK_tbl_product_p_season check( p_season in('1','2','3','4') )
    ,constraint CK_tbl_product_p_gender check( p_gender in('1','2') )
);
-- Table TBL_PRODUCT이(가) 생성되었습니다.

commit;

create sequence seq_product
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_PRODUCT이(가) 생성되었습니다.

create table tbl_delivery (
    d_num            number(5)     NOT NULL, -- 배송지번호
   fk_m_id          VARCHAR2(40)  NOT NULL, -- fk_userid
   d_address        VARCHAR2(200) NOT NULL, -- 받는사람 주소
   d_detail_address VARCHAR2(200) NOT NULL, -- 받는사람 상세주소
   d_postcode       VARCHAR2(5)   NOT NULL, -- 받는사람 우편번호
   d_extra          VARCHAR2(200) NOT NULL, -- 받는사람 참고항목
   d_mobile         VARCHAR2(200) NOT NULL, -- 받는사람 전화번호
   d_name           VARCHAR2(30)  NOT NULL  -- 받는사람 이름
    ,constraint PK_tbl_delivery_d_num primary key(d_num)
    ,constraint  FK_tbl_delivery_fk_m_id foreign key(fk_m_id) references tbl_member(m_id)
);
-- Table TBL_DELIVERY이(가) 생성되었습니다.


create sequence seq_delivery
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_DELIVERY이(가) 생성되었습니다.

create table tbl_log (
    l_num       number(5)    NOT NULL, -- historyno
   fk_m_id     VARCHAR2(40) NOT NULL, -- fk_userid
   l_logindate  date        default sysdate, -- logindate
   l_ip        VARCHAR2(20) NOT NULL  -- clientip
    ,constraint PK_tbl_log_d_num primary key(l_num)
    ,constraint  FK_tbl_log_fk_m_id foreign key(fk_m_id) references tbl_member(m_id)
);
-- Table TBL_LOG이(가) 생성되었습니다.

create sequence seq_log
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_LOG이(가) 생성되었습니다.

CREATE TABLE tbl_qna (
   q_num        NUMBER(5)      NOT NULL, -- Q&A번호
   fk_m_id      VARCHAR2(40)   NOT NULL, -- userid
   fk_p_num     NUMBER(3)      NOT NULL, -- 제품고유번호
   q_title      NVARCHAR2(30)  NOT NULL, -- 제목
   q_ask        NVARCHAR2(300) NOT NULL, -- 질문
   q_register   DATE           default sysdate, -- 질문등록일자
   q_category   NUMBER(1)      NOT NULL, -- 문의유형
   q_answer     NVARCHAR2(300) NULL,     -- 답변
   q_answerdate DATE           default sysdate -- 답변등록일자
    ,constraint PK_tbl_qna_q_num primary key(q_num)
    ,constraint FK_tbl_qna_fk_m_id foreign key(fk_m_id) references tbl_member(m_id)
    ,constraint FK_tbl_qnan_fk_p_num foreign key(fk_p_num) references tbl_product(p_num)
);
-- Table TBL_QNA이(가) 생성되었습니다.

create sequence seq_qna
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_QNA이(가) 생성되었습니다.

CREATE TABLE tbl_review (
   r_num      NUMBER(5)     NOT NULL, -- 리뷰번호
   fk_m_id    VARCHAR2(40)  NOT NULL, -- userid
   fk_p_num   NUMBER(3)     NOT NULL, -- 제품고유번호
   r_update   NUMBER(10)    NOT NULL, -- 리뷰수정일자
   r_register NVARCHAR2(20) NOT NULL, -- 리뷰작성일자
   r_star     NUMBER(1)     NOT NULL, -- 별점
   r_msg      VARCHAR2(200) NOT NULL  -- 리뷰내용
    ,constraint PK_tbl_review_r_num primary key(r_num)
    ,constraint FK_tbl_review_fk_m_id foreign key(fk_m_id) references tbl_member(m_id)
    ,constraint FK_tbl_review_fk_p_num foreign key(fk_p_num) references tbl_product(p_num)
);
-- Table TBL_REVIEW이(가) 생성되었습니다.

create sequence seq_review
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_REVIEW이(가) 생성되었습니다.



create table tbl_option (
    op_num   NUMBER(5)     NOT NULL, -- 옵션번호
    fk_p_num NUMBER(3)     NULL,     -- 제품고유번호
    op_ml    NVARCHAR2(5)   NOT NULL, -- 용량
    op_price      NVARCHAR2(10) NOT NULL  -- 용량별가격
 ,constraint PK_tbl_option_op_num primary key(op_num)
 ,constraint FK_tbl_option_fk_p_num foreign key(fk_p_num) references tbl_product(p_num)
 ,constraint CK_tbl_option_op_ml check( op_ml in('1','2','3') )
);
-- Table TBL_OPTION이(가) 생성되었습니다.

create sequence seq_option
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_OPTION이(가) 생성되었습니다.

CREATE TABLE tbl_order (
   o_num     number(5)     NOT NULL, -- 주문번호
   fk_m_id   VARCHAR2(40)  NOT NULL, -- fk_userid
   fk_d_num  number(5)     NOT NULL, -- 배송지번호
   fk_op_num NUMBER(5)     NOT NULL, -- 옵션번호
   o_date    DATE           DEFAULT  sysdate, -- 주문날짜
   status    NUMBER         DEFAULT  0, -- 배송현황
   o_price   NVARCHAR2(10) NOT NULL  -- 주문금액
    ,constraint PK_tbl_order_o_num primary key(o_num)
    ,constraint FK_tbl_order_fk_m_id foreign key(fk_m_id) references tbl_member(m_id)
    ,constraint FK_tbl_order_fk_d_num foreign key(fk_d_num) references tbl_delivery(d_num)
    ,constraint FK_tbl_order_fk_op_num foreign key(fk_op_num) references tbl_option(op_num)
    ,constraint CK_tbl_order_status check( status in('0','1','2'))
); 
-- Table TBL_ORDER이(가) 생성되었습니다.

create sequence seq_order
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ORDER이(가) 생성되었습니다.
-- create sequence seq_order;

create table tbl_orderdetail (
    od_num    NUMBER(5)    NOT NULL, -- 주문상세일련번호
   fk_p_num NUMBER(3)     NOT NULL, -- 제품고유번호
   fk_o_num number(5)     NOT NULL, -- 주문번호
   od_count NUMBER(2)     NOT NULL, -- 주문수
   od_price NVARCHAR2(10) NOT NULL  -- 가격
 ,constraint PK_tbl_orderdetail_od_num primary key(od_num)
 ,constraint FK_tbl_orderdetail_fk_p_num foreign key(fk_p_num) references tbl_product(p_num)
 ,constraint FK_tbl_orderdetail_fk_o_num foreign key(fk_o_num) references tbl_order(o_num)
);
-- Table TBL_ORDERDETAIL이(가) 생성되었습니다.

create sequence seq_orderdetail
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ORDERDETAIL이(가) 생성되었습니다.

create table tbl_cart (
    c_num     number(5)    NOT NULL, -- 장바구니번호
   fk_p_num  NUMBER(3)    NOT NULL, -- 제품고유번호
   fk_op_num NUMBER(5)    NOT NULL, -- 옵션번호
   fk_m_id   VARCHAR2(40) NOT NULL, -- userid
   c_count   number(5)    NOT NULL  -- 제품수량
 ,constraint PK_tbl_cart_c_num primary key(c_num)
 ,constraint FK_tbl_cart_fk_p_num foreign key(fk_p_num) references tbl_product(p_num)
 ,constraint FK_tbl_cart_fk_op_num foreign key(fk_op_num) references tbl_option(op_num)
 ,constraint FK_tbl_cart_fk_m_id foreign key(fk_m_id) references tbl_member(m_id)
);
-- Table TBL_CART이(가) 생성되었습니다.

create sequence seq_cart
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CART이(가) 생성되었습니다.

create table tbl_carousel (
   title  NVARCHAR2(50)  NOT NULL, -- title
   contents NVARCHAR2(200) NULL,     -- contents
   filename NVARCHAR2(50)  NULL      -- filename
);   
-- Table TBL_CAROUSEL이(가) 생성되었습니다.

create table tbl_FAQ (
   FAQ_num NUMBER(2)          NOT NULL, -- 자주묻는질문번호
   ask NVARCHAR2(200) NULL,     -- 질문
   answer NVARCHAR2(50)  NULL      -- 답변
);
-- Table TBL_FAQ이(가) 생성되었습니다.

commit;
-- 커밋 완료.

select *
from tab;



---------------------------------------------------------------------------

INSERT INTO tbl_order (o_num, fk_m_id, fk_d_num, fk_op_num, o_date, status, o_price)
VALUES (1, 'leess', 1, 1, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 0, '50000');

COMMIT;

select *
from tbl_order;


INSERT INTO tbl_option (op_num, fk_p_num, op_ml, op_price)
VALUES (seq_option.NEXTVAL, 1, '1', '10000');

COMMIT;

select *
from tbl_option;


insert into tbl_delivery(d_num, fk_m_id, d_address, d_detail_address, d_postcode, d_extra, d_mobile, d_name)
    values(seq_delivery.nextval, '2hoon', '서울 서초구 과천대로 786', '과연', '06761', ' (방배동)', '010-1236-6541', '김민지');
    
commit;

select *
from tbl_delivery;


-------------------------------------------------------------------

SELECT 
    m_id,          -- 회원아이디
    m_name,        -- 회원명
    m_email,       -- 이메일
    o_num,         -- 주문번호
    o_date,        -- 주문날짜
    o_price,       -- 주문금액
    status         -- 배송현황
FROM 
    tbl_member m
JOIN 
    tbl_order o
ON 
    m.m_id = o.fk_m_id;
-- 회원, 주문 join



-------------------------------------------------------------------

SELECT 
   o_num,
   fk_m_id,
   fk_d_num,
   fk_op_num,
   o_date,
   status,
   o_price 
   FROM tbl_member m 
   JOIN tbl_order o ON m_id = fk_m_id;

select *
from tbl_order;

COMMIT;


SELECT 
    o_num,             -- 주문 번호
    m_id,              -- 회원 아이디
    m_name,            -- 회원 이름
    d_address,         -- 배송지 주소
    op_ml,            -- 상품 용량
    op_price,         -- 옵션 가격
    p_name,            -- 상품명
    o_date,            -- 주문 날짜
    status,            -- 배송 상태
    o_price            -- 주문 금액
FROM 
    tbl_order o
JOIN 
    tbl_member m ON o.fk_m_id = m.m_id
JOIN 
    tbl_delivery d ON o.fk_d_num = d.d_num
JOIN 
    tbl_option op ON o.fk_op_num = op.op_num
JOIN 
    tbl_product p ON op.fk_p_num = p.p_num;
-- 회원정보, 배송지정보, 상품옵션, 상품정보 join


INSERT INTO tbl_member (m_id, m_name, m_email, m_mobile, m_pwd) 
VALUES ('kimmj', '김민지', 'kimmj@gmail.com', '010-5678-1234', 'qwer1234$');

INSERT INTO tbl_delivery (d_num, fk_m_id, d_address, d_detail_address, d_postcode, d_extra, d_mobile, d_name) 
VALUES (seq_delivery.NEXTVAL, 'kimmj', '서울시 강남구', '아파트 101동 202호', '12345', '참고 없음', '010-5678-1234', '김민지');

INSERT INTO tbl_option (op_num, fk_p_num, op_ml, op_price) 
VALUES (seq_option.NEXTVAL, 1, '1', '5000');

INSERT INTO tbl_product (p_num, p_season, p_name, p_ex, p_price, p_inven, p_register, p_release, p_sale, p_gender, p_image) 
VALUES (1, '1', '테스트 상품', '테스트 설명', '50000', 100, SYSDATE, SYSDATE + 1, '10%', 1, 'image.jpg');



INSERT INTO tbl_order (o_num, fk_m_id, fk_d_num, fk_op_num, o_date, status, o_price) 
VALUES (seq_order.NEXTVAL, 'kimmj', 1, 1, TO_DATE('2024-12-15', 'YYYY-MM-DD'), 1, '50000');

COMMIT;


select *
from tbl_order;

SELECT COUNT(*) AS row_count FROM tbl_order;

SELECT * FROM tbl_member;
SELECT * FROM tbl_delivery;
SELECT * FROM tbl_option;


select * from tbl_order;

SELECT 
	O_NUM,
    FK_M_ID,
    FK_D_NUM,
    FK_OP_NUM,
    O_DATE,
    STATUS,
    O_PRICE
FROM tbl_order o 
JOIN tbl_member m ON o.fk_m_id = m.m_id
JOIN





DESC tbl_product;

---------------adminOrder---------------------
SELECT
	o_num,
	fk_m_id, 
	fk_d_num,
	fk_op_num,
	o_date, 
	 status, 
	o_price,
	m_name, 
	m_email, 
	m_mobile 
	FROM tbl_member m 	
	JOIN tbl_order o ON m.m_id = o.fk_m_id;
----------------------------------------------

desc tbl_orderdetail;

select *
from tbl_orderdetail
where fk_o_num =
(
SELECT
	o_num
	FROM tbl_member m 	
	JOIN tbl_order o ON m.m_id = o.fk_m_id
);

------------------------------------------------adminOrder메인페이지------------------
SELECT
    od_count as 주문수,
	o_num,
	fk_m_id, 
	fk_d_num,
	fk_op_num,
	o_date, 
	 status, 
	o_price,
	m_name, 
	m_email, 
	m_mobile,
    p_name
FROM tbl_member m 	
JOIN tbl_order o ON m.m_id = o.fk_m_id
join tbl_orderdetail od on od.fk_o_num = o.o_num
JOIN tbl_product p ON od.fk_p_num = p.p_num;
------------------------------------------------------------------------------------
INSERT INTO tbl_order (o_num, fk_m_id, fk_d_num, fk_op_num, o_date, status, o_price) 
VALUES (3, 'iyou', 1, 101, SYSDATE, 1, '5000');

SELECT o_num FROM tbl_order ORDER BY o_num;

-- tbl_product 테이블에 데이터 삽입
INSERT INTO tbl_product (p_num, p_season, p_name, p_ex, p_price, p_inven, p_register, p_release, p_sale, p_gender, p_image, p_detail_image)
VALUES (101, '1', '겨울코롱', '겨울에 잘어울리는 향입니다', '5000', 100, SYSDATE, SYSDATE, '10', 1, 'test_image.jpg', 'test_detail_image.jpg');

INSERT INTO tbl_product (p_num, p_season, p_name, p_ex, p_price, p_inven, p_register, p_release, p_sale, p_gender, p_image)
VALUES (
    102,                  -- 제품고유번호
    '3',                  -- 카테고리(가을)
    '가을코롱',          -- 제품명
    '가을에 잘 어울리는 향입니다', -- 제품설명
    '35000',              -- 가격
    50,                   -- 재고
    TO_DATE('2024-12-01', 'YYYY-MM-DD'), -- 제품등록일
    TO_DATE('2024-12-15', 'YYYY-MM-DD'), -- 발매일
    '30',                 -- 할인률
    1,                    -- 성별 향수(남성)
    '사진1' -- 상품이미지 경로 (필수 값)
);

commit;

-- tbl_orderdetail에 데이터 삽입
INSERT INTO tbl_orderdetail (od_num, fk_o_num, fk_p_num, od_count, od_price) 
VALUES (1, 1, 101, 2, '10000');

commit;


SELECT *
FROM tbl_orderdetail;











SELECT 
    o.o_num,          -- 주문 번호
    o.fk_m_id,        -- 회원 ID
    o.fk_d_num,       -- 배송지 번호
    o.fk_op_num,      -- 옵션 번호
    o.o_date,         -- 주문 날짜
    o.status,         -- 주문 상태
    o.o_price,        -- 주문 가격
    m.m_name,         -- 회원 이름
    m.m_email,        -- 회원 이메일
    m.m_mobile,       -- 회원 연락처
    p.p_name          -- 상품명 (추가된 부분)
FROM tbl_member m
JOIN tbl_order o ON m.m_id = o.fk_m_id
JOIN tbl_product p ON o.fk_op_num = p.p_num;



-- 배송전, 배송중인 회원들만 나오게
select o.o_num, o.fk_m_id, v.p_name ,o.fk_d_num, o.fk_op_num, o.o_date, o.status, o.o_price
from
(
select *
from tbl_product p join tbl_option op
on p.p_num = op.fk_p_num
)v join tbl_order o
on v.op_num = o.fk_op_num
where o.status in(0,1);





-----------------------------------------------------------------------------------상품테이블
SELECT 
    p_num,             -- 제품고유번호
    p_season,          -- 카테고리(계절)
    p_name,            -- 제품명
    p_ex,              -- 제품설명
    p_price,           -- 가격
    p_inven,           -- 재고
    TO_CHAR(p_register, 'YYYY-MM-DD') AS p_register,  -- 제품등록일 (날짜 포맷)
    TO_CHAR(p_release, 'YYYY-MM-DD') AS p_release,    -- 발매일 (날짜 포맷)
    p_sale,            -- 할인률
    p_gender,          -- 성별 향수
    p_image,           -- 상품이미지
    p_detail_image     -- 상품상세이미지
FROM 
    tbl_product;



commit;





SELECT p_num, p_season, p_name, p_ex, p_price, p_inven, 
       TO_CHAR(p_register, 'YYYY-MM-DD') AS p_register, 
       TO_CHAR(p_release, 'YYYY-MM-DD') AS p_release, 
       p_sale, p_gender, p_image, p_detail_image 
FROM tbl_product;


DESC tbl_product;



UPDATE tbl_product
SET p_price = '0'
WHERE NOT REGEXP_LIKE(p_price, '^[0-9,]+$');

commit;



select 

SELECT RNO, p_num, p_season, p_name, p_ex, p_price, p_inven, p_register, p_release, p_sale, p_gender 
    	                   FROM ( 
                         SELECT rownum AS RNO, p_num, p_season, p_name, p_ex, p_price, p_inven, p_register, p_release, p_sale, p_gender 
    	                    FROM ( 
    	                   SELECT p_num, p_season, p_name, p_ex, p_price, p_inven, p_register, p_release, p_sale, p_gender 
    	                     FROM tbl_product 
    	                    ) 
    	                   )
WHERE p_gender like '%'|| '2' ||'%'





SELECT 
	           		 od_count,
	           		 	o_num,
	           		  	fk_m_id, 
	           		  	fk_d_num, 
	           		  	fk_op_num, 
	           		  	o_date, 
	           		  	 status, 
	           		  	o_price, 
                    	m_name, 
	           		  	m_email, 
	           		   	m_mobile, 
	           		  	p_name 
	           		   FROM tbl_member m 
	           		   JOIN tbl_order o ON m.m_id = o.fk_m_id 
	           		   join tbl_orderdetail od on od.fk_o_num = o.o_num 
	           		  JOIN tbl_product p ON od.fk_p_num = p.p_num

---------------------------------주문회원조회 insert---------------------------
insert into tbl_orderdetail(od_num, fk_p_num, fk_o_num, od_count, od_price)
values(seq_orderdetail.nextval, 101, 4, 1, '50000');

commit;


insert into tbl_order(o_num, fk_m_id, fk_d_num, fk_op_num, o_date ,o_price, o_cnt)
values(seq_order.nextval, 'minkyu', 25, 1, sysdate,'50000', 1);

commit;
----------------------------------------------------------------------------

-- 주문회원조회 검색기능
SELECT RNO, o_num, p_season, p_name, p_ex, p_price, p_inven, p_register, p_release, p_sale, p_gender 
FROM (
    SELECT rownum AS RNO, o_num, p_season, p_name, p_ex, p_price, p_inven, p_register, p_release, p_sale, p_gender 
    FROM (
        SELECT 
            o.o_num AS o_num, 
            p.p_season AS p_season, 
            p.p_name AS p_name, 
            p.p_ex AS p_ex, 
            p.p_price AS p_price, 
            p.p_inven AS p_inven, 
            p.p_register AS p_register, 
            p.p_release AS p_release, 
            p.p_sale AS p_sale, 
            p.p_gender AS p_gender 
        FROM tbl_member m 
        JOIN tbl_order o ON m.m_id = o.fk_m_id 
        JOIN tbl_orderdetail od ON od.fk_o_num = o.o_num 
        JOIN tbl_product p ON od.fk_p_num = p.p_num
    )
)



    
SELECT 
    o.o_num, 
    o.o_date,  
    m.m_name,         -- 회원 이름
    m.m_email,        -- 회원 이메일
    m.m_mobile,       -- 회원 연락처
    p.p_name, 
    od.od_count, 
    o.o_price, 
    o.status, 
    o.fk_op_num, 
    o.fk_d_num
FROM  
    tbl_member m
JOIN 
    tbl_order o ON m.m_id = o.fk_m_id 
JOIN 
    tbl_orderdetail od ON od.fk_o_num = o.o_num 
JOIN 
    tbl_product p ON od.fk_p_num = p.p_num;
    
    
    
    
    
select *
from tbl_product;
    
----------------------------------------------------tbl_member insert문 ---------------------------------    
insert into tbl_member(m_id, m_pwd, m_name, m_email, m_mobile, m_postcode, m_address, m_detail_address, m_extra, m_gender, m_birth)
values('mango', 'qwer1234$', '장망고', 'mango@naver.com', '010-5834-1244', '04001', '서울특별시 마포구', '월드컵북로 21', '풍성빌딩 3층', '2', '2023-07-29');

insert into tbl_member(m_id, m_pwd, m_name, m_email, m_mobile, m_postcode, m_address, m_detail_address, m_extra, m_gender, m_birth)
values('kimmj', 'qwer1234$', '김민지', 'kimmj@naver.com', '010-2222-3333', '23303', '서울특별시 마포구', '월드컵북로 21', '풍성빌딩 3층', '1', '2022-04-20');

delete from tbl_member where m_id = 'kimmj';

commit;
--------------------------------------------------------------------------------------------------------
-- 주문배송 select 

SELECT 
    d_num,
    fk_m_id,
    d_address,
    d_detail_address,
    d_postcode,
    d_extra,
    d_mobile,
    d_name
FROM 
    tbl_delivery 


SELECT RNO, d_num, fk_m_id, d_address, d_detail_address, d_postcode, d_extra, d_mobile, d_name 
            FROM ( 
                SELECT rownum AS RNO, d_num, fk_m_id, d_address, d_detail_address, d_postcode, d_extra, d_mobile, d_name 
              FROM ( 
                  SELECT d_num, fk_m_id, d_address, d_detail_address, d_postcode, d_extra, d_mobile, d_name 
                 FROM tbl_delivery
                 
SELECT * FROM tbl_delivery;



--------------------------------탈퇴회원조회-----------------------------------------
SELECT m_id, m_name, m_email, m_mobile, m_postcode, m_address, 
       m_detail_address, m_extra, m_gender, m_birth, m_point,
       m_register, m_lastpwd, m_status, m_idle 
FROM tbl_member
WHERE m_status = 0;
---------------------------------------------------------------------------------


select *
from tbl_order


INSERT INTO tbl_order (
    o_num, 
    fk_m_id, 
    fk_d_num, 
    fk_op_num, 
    o_date, 
    status, 
    o_price
) 
VALUES (
    1,               -- 주문번호
    'kimmj',       -- 회원 ID (tbl_member의 m_id 참조)
    101,             -- 배송지번호 (tbl_delivery의 d_num 참조)
    201,             -- 옵션번호 (tbl_option의 op_num 참조)
    SYSDATE,         -- 주문날짜 (기본값으로 현재 날짜)
    0,               -- 배송현황 (0: 주문접수)
    '10000'          -- 주문금액
);

SELECT * 
FROM tbl_option 
SELECT * 
FROM tbl_member 
WHERE m_id = 'kimmj';

