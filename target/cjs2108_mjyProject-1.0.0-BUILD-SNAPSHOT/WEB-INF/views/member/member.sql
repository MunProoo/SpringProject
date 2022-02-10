show tables;

CREATE TABLE member(
	idx		int not null auto_increment,	/* 회원 고유번호 */
	mid		varchar(20)   not null,				/* 회원 아이디(중복불허) */
	pwd		varchar(100)		not null,			/* 비밀번호(bCrypt) */
	nickName  varchar(20) not null,			/* 별명(중복불허) */
	name			varchar(20) not null,			/* 성명 */
	email			varchar(50)	not null,			/* 이메일(아이디/비밀번호 분실시 필요) */
	gender    varchar(10) default '남자',/* 성별 */
	birthday	datetime		default now(),/* 생일 */
	tel				varchar(15),							/* 연락처 */
	address		varchar(50),							/* 주소 */
	userDel		char(2) default 'NO',			/* 회원 탈퇴 신청 여부(OK:탈퇴신청한회원, NO:현재가입중인회원) */
	point     int default 1000,					/* 포인트(최초가입회원은 1000, 구매 금액의 % 적립 */
	level			int default 1,						/* 1:정회원, 2:우수회원, 3,특별회원,  0:관리자 */
	primary key(idx, mid)								/* 기본키 : 고유번호, 아이디 */
);

DROP TABLE member;

DESC member;

 $2a$10$0CwApJ71rsYnyxnIOrYb1ehV8eG/ffsqndLx5YeTBsyy5WRKHt1JO


INSERT INTO member VALUES (default,'admin','1234','관리자','관리자','mjo5178@naver.com',default,default
	,'010-1234-1234','13536/경기 성남시 분당구 판교역로 6-2/123/ (백현동)',default,default,0);
	
SELECT * FROM member WHERE mid = 'admin';

UPDATE member SET pwd = '$2a$10$0CwApJ71rsYnyxnIOrYb1ehV8eG/ffsqndLx5YeTBsyy5WRKHt1JO' WHERE mid = 'admin';

SELECT * FROM member WHERE email like concat('mjo5178','%');

ALTER TABLE member ADD UNIQUE KEY (mid);  /* mid 를 외래키로 쓰기위해 유니크속성 줘야함*/