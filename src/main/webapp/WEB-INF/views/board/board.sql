show tables;

CREATE TABLE board (
	idx  int not null auto_increment,	/* 게시글의 고유번호 */
	nickName varchar(20)  not null,		/* 게시글 올린사람의 닉네임 */
	title    varchar(100) not null,		/* 게시글의 글 제목 */
	content  text not null,						/* 글 내용 */
	wDate    datetime default now(),  /* 글쓴 날짜(기본값:현재날짜/시간) */
	readNum  int default 0,						/* 글 조회수 */
	hostIp	 varchar(50) not null,		/* 접속 IP주소 */
	good		 int  default 0,					/* 좋아요 */
	mid			 varchar(20) not null,		/* 회원 아이디(게시글 조회시 사용) */
	primary  key(idx)									/* 기본키 : 글 고유번호 */
);

SELECT * FROM board;

SELECT count(*)
FROM board
WHERE DATE_SUB(now(), interval 2 day)  > wDate;

SELECT * , cast(timestampdiff(minute, wDate, now())/60 as signed integer) as diffTime
FROM board
WHERE DATE_SUB(now(), interval 2 day)  > wDate
ORDER BY idx DESC
LIMIT 1, 5;

SELECT count(*)
FROM board
WHERE title like concat('%','테','%') and DATE_SUB(now(), interval 0 day)  > wDate
ORDER BY idx DESC;


DROP TABLE board;

DELETE FROM board WHERE idx = 3;


CREATE TABLE boardReply(
  idx				int not null auto_increment primary key,	/* 댓글의 고유번호 */
  boardIdx	int not null,							/* 원본글의 고유번호(외래키지정) */
  mid				varchar(20) not null,			/* 올린이의 아이디 */
  nickName	varchar(20) not null,			/* 올린이의 닉네임 */
  wDate			datetime		default now(),/* 댓글 기록 날짜 */
  hostIp		varchar(50) not null,			/* 댓글쓴 PC의 IP */
  content		text				not null,			/* 댓글 내용 */
  level			int  not null default 0,	/* 댓글레벨 - 부모댓글의 레벨은 '0' */
  levelOrder int not null default 0,	/* 댓글의 순서 - (어떤 댓글의 부모인지) */
  foreign key(boardIdx) references board(idx) 
  on update cascade 
  on delete cascade
);

DESC boardReply;

SELECT * FROM boardReply ORDER BY levelOrder;

UPDATE boardReply 
SET level = 1 
WHERE level >= 1;

DROP TABLE boardReply;

SELECT count(*)
		FROM board
		WHERE nickName like concat('%','관리자','%') and DATE_SUB(now(), interval 1 day)  <= wDate
		ORDER BY idx DESC;
