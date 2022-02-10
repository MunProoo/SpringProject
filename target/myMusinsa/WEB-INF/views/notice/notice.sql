/* 공지사항(notice) */

show tables;

CREATE TABLE notice(
	idx  int not null auto_increment,	/* 게시글의 고유번호 */
	nickName varchar(20)  not null,		/* 게시글 올린사람의 닉네임 */
	title    varchar(100) not null,		/* 게시글의 글 제목 */
	content  text not null,						/* 글 내용 */
	wDate    datetime default now(),  /* 글쓴 날짜(기본값:현재날짜/시간) */
	readNum  int default 0,						/* 글 조회수 */
	mid			 varchar(20) not null,		/* 회원 아이디(게시글 조회시 사용) */
	primary key(idx)
);

SELECT *, cast(timestampdiff(minute, wDate, now())/60 as signed integer) as diffTime FROM notice order by idx desc limit 0, 5;

select * FROM notice;

drop table board;
