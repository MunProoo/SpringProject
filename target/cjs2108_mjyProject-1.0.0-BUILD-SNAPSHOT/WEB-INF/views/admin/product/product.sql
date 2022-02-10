show tables;

/* 대분류 */
CREATE TABLE categoryMain(
	categoryMainCode 		char(1) not null,      /* 대분류코드(A,B,C,... =>영문 대문자 1자) */    
	categoryMainName 		varchar(20) not null,  /* 대분류명 (외투,상의,바지, 등등) */
	primary key(categoryMainCode)
);

SELECT * FROM categoryMain;

/* 중분류 */
CREATE TABLE categoryMiddle(
	categoryMainCode		char(1) not null,        /* 대분류코드 외래키 */
	categoryMiddleCode	char(2) not null,				 /* 중분류코드 (01,02,  => 2글자 숫자(문자형식) */
	categoryMiddleName	varchar(20) not null,    /* 중분류명 (재킷,점퍼,슬랙스,긴팔티 등등) */
	primary key(categoryMiddleCode),
	foreign key(categoryMainCode) references categoryMain(categoryMainCode) on update cascade on delete restrict
);

SELECT * FROM categoryMiddle;
SELECT * FROM categoryMiddle WHERE categoryMainCode = 'A';
SELECT middle.*, main.categoryMainName as categoryMainName FROM categoryMiddle middle, categoryMain main WHERE middle.categoryMainCode = main.categoryMainCode
	order by middle.categoryMiddleCode desc;

/* 상품 테이블(product) */     /* 좋아요 추가? 아니면 후기 테이블을 만들어서 idx로 호출? */
create table product (
  idx  int  not null auto_increment,			/* 상품 고유번호 */
  productCode varchar(20)  not null,			/* 상품고유코드(대분류코드+중분류코드+고유번호) */
  productName	varchar(50)  not null,			/* 상품명(상품코드-모델명) - 세분류 */
  detail			varchar(100) not null,			/* 상품의 간단설명(초기화면 출력) */
  mainPrice		int not null,								/* 상품의 기본가격 */
  fName				varchar(50)	 not null,			/* 상품 기본사진(1장만 처리)-필수입력 */
  fSName			varchar(100) not null,			/* 서버에 저장될 상품의 고유이름 */
  content			text not null,							/* 상품의 상세설명 - ckeditor을 이용한 이미지 처리 */
  primary key(idx, productCode)
  /*
  foreign key(categoryMainCode)   references categorySub(categoryMainCode)   on update cascade on delete restrict,
  foreign key(categoryMiddleCode) references categorySub(categoryMiddleCode) on update cascade on delete restrict,
  foreign key(categorySubCode)    references categorySub(categorySubCode)    on update cascade on delete restrict
  */
);

SELECT max(idx) FROM product;
SELECT * FROM product order by idx DESC LIMIT 4;

SELECT product.*, main.categoryMainName, middle.categoryMiddleName FROM product, categoryMain main, categoryMiddle middle
WHERE productName = 'TMR-PH001' and main.categoryMainCode = 'C' and middle.categoryMiddleCode = '10';

SELECT productName FROM product WHERE productName like concat('%','123','%');

SELECT concat('%','하하','%') ;

SELECT product.* , main.categoryMainName, middle.categoryMiddleName FROM product, categoryMain main, categoryMiddle middle
			WHERE productName = '뀨22' && main.categoryMainCode = SUBSTRING(productCode,1,1) and middle.categoryMiddleCode = SUBSTRING(productCode,2,2);

SELECT product.productName, main.categoryMainName,main.categoryMainCode, middle.categoryMiddleName,middle.categoryMiddleCode FROM product, categoryMain main, categoryMiddle middle
			WHERE productName = '뀨22' and main.categoryMainCode = 'A' and middle.categoryMiddleCode = '04';			
			
SELECT SUBSTRING(productCode,4,1) FROM product WHERE idx = 23;

SELECT pr.*, main.categoryMainName
FROM product pr
INNER JOIN categoryMain main
ON substring(productCode,1,1) = 'C' and main.categoryMainCode = 'C' order by idx DESC ;

DELETE FROM product WHERE idx = 1;
DROP TABLE product;

SELECT pr.*, main.*
FROM product pr
INNER JOIN categoryMain main 
ON substring(pr.productCode,1,1) = main.categoryMainCode AND main.categoryMainCode = 'A' order by idx DESC ;


SELECT pr.* 
FROM product pr
INNER JOIN categoryMain main
ON substring(pr.productCode,1,1) = main.categoryMainCode and main.categoryMainCode = 'A'
JOIN categoryMiddle middle
ON substring(pr.productCode,2,2) = middle.categoryMiddleCode and middle.categoryMiddleCode = '00';

SELECT pr.* , main.categoryMainName
FROM product pr
JOIN categoryMiddle middle
ON substring(productCode,2,2) = middle.categoryMiddleCode and middle.categoryMiddleCode = '01' 
JOIN categoryMain main
  ON middle.categoryMainCode = main.categoryMainCode
order by idx DESC;




/* 상품 옵션(productOption) (색상옵션.) */
create table colorOption (
  idx 			  int not null auto_increment primary key,	/* 옵션 고유번호 */
  productIdx  int  not null,							/* dbProduct테이블의 고유번호 */
  colorName  varchar(50)  not null,			/* 색상 이름 */
  colorPrice int not null default 0,			/* 색상 가격 */
  foreign key(productIdx) references product(idx) on update cascade on delete restrict
);

/* 상품옵션 (사이즈) */
CREATE TABLE sizeOption(
  idx 			  int not null auto_increment primary key,	/* 옵션 고유번호 */
  productIdx  int  not null,							/* product테이블의 고유번호 */
  colorIdx		int not null,								/* colorOption테이블의 고유번호 */
  sizeName  varchar(50)  not null,			/* 사이즈 이름  */
  sizePrice int not null default 0,			/* 사이즈 가격 */
  foreign key(productIdx) references product(idx) on update cascade on delete restrict,
  foreign key(colorIdx) references colorOption(idx) on update cascade on delete cascade
);

SELECT c.* , p.productName 
FROM colorOption c 
join product p on c.productIdx = p.idx and c.productIdx = 7;

SELECT * FROM colorOption;

/* 조인 2번 */
SELECT s.*, p.productName , c.colorName
FROM sizeOption s 
INNER JOIN product p 
ON s.productIdx = p.idx and s.productIdx = 7 
INNER JOIN colorOption c 
ON s.colorIdx = c.idx and s.colorIdx = 1;

SELECT * FROM sizeOption WHERE colorIdx = 3;

INSERT INTO colorOption
			 VALUES (default,'7','white','0');
			 
			 
SELECT * FROM sizeOption;

DESC sizeOption;
DROP TABLE colorOption;
DROP TABLE sizeOption;

/* ================ 상품 주문 시작시에 사용하는 테이블들~ ==================== */

/* 장바구니 테이블 */
create table cartList (
  idx   int not null auto_increment,			/* 장바구니 고유번호 */
  cartDate datetime default now(),				/* 장바구니에 상품을 담은 날짜 */
  mid   varchar(20) not null,							/* 장바구니를 사용한 사용자의 아이디 - 로그인한 회원 아이디이다. */
  productIdx  int not null,								/* 장바구니에 구입한 상품의 고유번호 */
  productName varchar(50) not null,				/* 장바구니에 담은 구입한 상품명 */
  mainPrice   int not null,								/* 메인상품의 기본 가격 */
  thumbImg		varchar(100) not null,			/* 서버에 저장된 상품의 메인 이미지 */
  optionName  varchar(100) not null,			/* 옵션명 리스트(여러개가 될수 있기에 배열처리) */
  optionPrice varchar(100) not null,			/* 옵션가격 리스트(배열처리) */
  optionNum		varchar(50)  not null,			/* 옵션수량 리스트(배열처리) */
  totalPrice  int not null,								/* 구매한 모든 항목(상품과 옵션포함)에 따른 총 가격 */
  primary key(idx, mid),
  foreign key(productIdx) references product(idx) on update cascade on delete restrict,
  foreign key(mid) references member(mid) on update cascade on delete cascade    /* varchar형식을 외래키로하려면 유니크속성을 줘야한다. */
);

SELECT * FROM cartList;
DELETE FROM cartList WHERE idx = 14;
UPDATE cartList SET cartDate = default WHERE idx = 12;

DROP TABLE cartList;

/* 주문 테이블 -  */
create table orderList (
  idx         int not null auto_increment, /* 고유번호 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호(장바구니에 상품이 여러종류가 합쳐졌을 경우를 위해서 생성) */
  mid         varchar(20) not null,   /* 주문자 ID */
  productIdx  int not null,           /* 상품 고유번호 */
  orderDate   datetime default now(), /* 실제 주문을 한 날짜 */
  productName varchar(200) not null,   /* 상품명 (여러개 받을거니 배열처리*/
  mainPrice   int not null,				    /* 메인 상품 가격 */
  thumbImg    varchar(60) not null,   /* 썸네일(서버에 저장된 메인상품 이미지) */
  optionName  varchar(100) not null,  /* 옵션명    리스트 -배열로 넘어온다- */
  optionPrice varchar(100) not null,  /* 옵션가격  리스트 -배열로 넘어온다- */
  optionNum   varchar(50)  not null,  /* 옵션수량  리스트 -배열로 넘어온다- */
  totalPrice  int not null,					  /* 구매한 상품 항목(상품과 옵션포함)에 따른 총 가격 */
  /* cartIdx     int not null,	*/		/* 카트(장바구니)의 고유번호 */ 
  primary key(idx, orderIdx),
  foreign key(productIdx) references product(idx)  on update cascade on delete cascade
);

SELECT * FROM orderList;
SELECT * FROM orderList WHERE orderIdx = '20220202_19' and productIdx = '44';

SELECT * FROM orderList WHERE productName = 'MUCA7101'	;
SELECT * FROM orderList WHERE productIdx = 38	;
SELECT idx FROM product WHERE productName = 'MUCA7101';

/* 주문 건수 */
SELECT count(distinct orderIdx) FROM orderList;

/* 매출액 */
SELECT sum(totalPrice) FROM orderList;


commit
/* 배송테이블 */
create table baesong (
  idx     int not null auto_increment,
  oIdx    int not null,								/* 주문테이블의 고유번호를 외래키로 지정함 */
  orderIdx    varchar(15) not null,   /* 주문 고유번호 */
  orderTotalPrice int     not null,   /* 주문한 모든 상품의 총 가격 */
  mid         varchar(20) not null,   /* 회원 아이디 */
  name				varchar(20) not null,   /* 배송지 받는사람 이름 */
  address     varchar(100) not null,  /* 배송지 (우편번호)주소 */
  tel					varchar(15),						/* 받는사람 전화번호 */
  email 			varchar(20) not null,  /* 이메일주소 */
  message     varchar(100),						/* 배송시 요청사항 */
  payment			varchar(10)  not null,	/* 결재도구 */
  orderStatus varchar(10)  not null default '결제완료', /* 주문순서(결제완료->배송중->배송완료->구매완료, 반품처리) */
  primary key(idx),
  foreign key(oIdx) references orderList(idx) on update cascade on delete cascade
);

SELECT * FROM baesong;
SELECT * FROM baesong WHERE ;

SELECT ol.*, b.* 
FROM orderList ol 
JOIN baesong b USING(orderIdx) 
WHERE b.mid='admin' order by b.idx desc;

select count(*)                  /* subdate : 날짜를 뺴주는 함수 (  DATE_ADD(), DATE_SUB() 와 유사)  */
from orderList a 
where a.mid='admin' and date(a.orderDate) >= date(subdate(now(), INTERVAL 7 DAY)) 
and date(a.orderDate) <= date(now()) order by a.orderDate desc;

SELECT ol.*, b.*
FROM orderList ol
JOIN baesong b USING(orderIdx)
WHERE b.mid = 'admin' and date(ol.orderDate) >= date(subdate(now(), INTERVAL 7 DAY))
AND date(ol.orderDate) <= date(now()) ORDER BY ol.orderDate desc;


/* 주문상태 + 날짜 조건 */
SELECT count(*)
FROM orderList ol
JOIN baesong b USING(orderIdx)
WHERE b.mid = 'admin' and ol.orderDate >= '2022-01-04'
AND ol.orderDate <= '2022-02-02' and b.orderStatus = '결제완료' ORDER BY ol.orderDate desc;

SELECT count(*)
FROM orderList ol
JOIN baesong b USING(orderIdx)
WHERE b.mid = 'admin' and date(ol.orderDate) >= '2022-01-04'
AND date(ol.orderDate) <= '2022-02-04' and b.orderStatus = '결제완료' ORDER BY ol.orderDate desc; 


SELECT subdate(now(), interval 7 day) FROM orderList WHERE mid = 'admin';

UPDATE baesong 
SET orderStatus = #{orderStatus} 
WHERE orderIdx = #{orderIdx};

DROP TABLE baesong;

/* 메인화면 추천상품 */
CREATE TABLE recoProduct(
	idx          int not null auto_increment,
	productIdx   int ,       /* 상품 고유번호 */
	primary key(idx),
	foreign key(productIdx) references product(idx) on update cascade on delete cascade
);

SELECT * FROM recoProduct;
DROP TABLE recoProduct;

/* 리뷰 */
CREATE TABLE review(
	idx      int not null auto_increment,
	orderIdx varchar(15) not null,       /* 주문번호 */
	productIdx int not null,							/* 상품번호 */
	rating   int not null,							/* 상품평점 */
	mid      varchar(20) not null,       /* 아이디 */
	title    varchar(30) not null,      /* 후기 제목 */
	content  text not null,            /* 후기내용 */
	primary key(idx),
	foreign key(productIdx) references orderList(productIdx) on update cascade on delete cascade
);

SELECT * FROM review order BY idx DESC;
SELECT * FROM review WHERE productIdx = 44 and orderIdx = '20220202_19';


SELECT r.* , ol.optionName, m.nickName
  FROM review r 
  JOIN orderList ol
    ON r.productIdx = ol.productIdx
 INNER JOIN member m
    ON r.mid = m.mid and r.mid = ol.mid;


SELECT productIdx, round(avg(rating),2)
  FROM review 
 GROUP BY productIdx
HAVING avg(rating) 
 ORDER BY avg(rating) DESC
 LIMIT 4;

SELECT * FROM review WHERE productIdx = 50;
 
/* 상품으로 리뷰검색 */
SELECT r.* ,ol.productName, ol.optionName, m.nickName
  FROM review r 
  JOIN orderList ol
    ON r.productIdx = ol.productIdx and ol.productIdx = 50
 INNER JOIN member m
    ON r.mid = m.mid and r.mid = ol.mid; 
    
/* 닉네임으로 리뷰검색 */
	SELECT r.* , ol.productName, ol.optionName, m.nickName
	  FROM review r
	  JOIN orderList ol
	    ON r.productIdx = ol.productIdx
   INNER JOIN member m
      ON r.mid = m.mid and r.mid = ol.mid and  m.nickName like concat('%','관리자','%')
   ORDER BY idx DESC; 

/* 판매현황 연습 count(CASE WHEN SUBSTRING(p.productCode,1,1) ='A' THEN 1 END) */
/* 카테고리별 판매량(파이차트) */
SELECT cm.categoryMainName as 'mainCategory', count(p.productCode) as sales
FROM orderList ol
JOIN product p
  ON ol.productIdx = p.idx
JOIN categoryMain cm
  ON cm.categoryMainCode = SUBSTRING(p.productCode,1,1)
GROUP BY SUBSTRING(p.productCode,1,1);
  
  
/* 판매물품 별 판매금액 및 판매갯수 */
SELECT p.productName as productName, count(ol.totalPrice) as cnt, sum(ol.totalPrice) as totalPrice
  FROM orderList ol
  JOIN product p
    ON ol.productIdx = p.idx
GROUP BY ol.productIdx
ORDER BY sum(ol.totalPrice) DESC;
  

/* 일별 매출 */
SELECT  SUBSTRING(ol.orderIdx,1,8), sum(ol.totalPrice)
  FROM orderList ol
  JOIN product p
    ON ol.productIdx = p.idx
 GROUP BY SUBSTRING(ol.orderIdx,1,8);
 
 SELECT * FROM product;
 DELETE FROM product WHERE idx = 6;
 SELECT * FROM orderList WHERE productName like concat('%','지고','%');
 SELECT * FROM baesong;
 
 DELETE FROM baesong WHERE idx in(1,2,3,4,5,6);
 DELETE FROM orderList WHERE idx in(9,10,11,12,13);
 
 select * FROM review WHERE mid = 'cas5178'
 
SELECT * FROM orderList WHERE mid = 'kms1234'
SELECT * FROM baesong WHERE mid = 'kms1234'

SELECT r.* , ol.productName ,ol.optionName, m.nickName
  FROM review r 
  JOIN orderList ol
    ON r.orderIdx = ol.orderIdx and r.productIdx = ol.productIdx
 INNER JOIN member m
    ON r.mid = m.mid and m.nickName like concat('%','주영','%')
 ORDER BY idx DESC;

SELECT * FROM orderList WHERE productIdx = '42' and orderIdx = '20220202_22'
			 
SELECT productIdx, round(avg(rating),2) as ratingAvg 
      FROM review 
 		 GROUP BY productIdx
    HAVING avg(rating) 
     ORDER BY avg(rating) DESC
     LIMIT 4;
     
	 /* 리뷰가 없으면 평점이 없어서 값을 못가져오는데 그걸 해결할 방안이 있을까? */
SELECT p.* , round(avg(r.rating),2) as ratingAvg 
  FROM product p
  JOIN review r
    ON p.idx = r.productIdx

SELECT p.*, round(avg(r.rating),2) as ratingAvg 
	FROM product p
  INNER JOIN review r
    ON p.idx = r.productIdx
  JOIN categoryMain main
	  ON substring(p.productCode,1,1) = main.categoryMainCode 
	 and main.categoryMainCode = 'A' order by idx DESC ;
	 
	 
SELECT *
	FROM product
	WHERE productName like concat('%','컬러','%') 
	   OR detail like concat('%','컬러','%')
	ORDER BY idx DESC;
	 
	 
	  