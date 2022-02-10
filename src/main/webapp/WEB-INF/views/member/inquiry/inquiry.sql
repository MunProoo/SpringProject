show tables;

CREATE TABLE inquiry(
	idx      int not null auto_increment,     /* 문의 고유번호 */
	nickName     varchar(20) not null,         /* 문의하는 사람의 닉네임 */
	category  varchar(30) not null,         /* 문의유형 */
	title        varchar(40) not null,
	status			 varchar(20) default '답변대기중',   /* 문의 상태 */		
	iDate				 datetime default now(),         /* 문의 날짜 */
	content      text not null,                  /* 문의 내용 */
	primary key(idx)
);

SELECT * FROM inquiry;

SELECT count(*) FROM inquiry WHERE status = '답변대기중' ;
DELETE FROM inquiry WHERE idx = 1;

SELECT *, cast(timestampdiff(minute, iDate, now())/60 as signed integer) as diffTime FROM inquiry order by idx;

DROP TABLE inquiry;
DESC inquiry;


CREATE TABLE inquiryReply(
	idx 				int not null auto_increment,    /* 문의 답변번호 */
	inquiryIdx	int not null,          /* 문의 번호 */
	ansContent  text not null,         /* 문의 답변 */
	rDate       datetime default now(),  /* 답변날짜 */
	primary key(idx),
	foreign key(inquiryIdx) references inquiry(idx) on update cascade on delete restrict
);

SELECT * FROM inquiryReply;

SELECT * FROM inquiryReply WHERE idx in (1,2);

DROP TABLE inquiryReply;

