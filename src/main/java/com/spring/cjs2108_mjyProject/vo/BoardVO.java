package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String nickName;
	private String title;
	private String content;
	private String wDate;
	private int readNum;
	private String hostIp;
	private int good;
	private String mid;
	
	private int diffTime;		// 시간계산을 위해 저장한 변수(sql에서 시간단위로 계산해서 넘어온값을 저장)
	private String oriContent; // 원본 content의 내용을 저장시켜두기위한 필드
	
	// 이전글/다음글을 위한 변수
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	// 댓글개수를 위한 변수
	private int replyCnt;
	private int replyCount;
	
	// 댓글관련 변수
	private int boardIdx;
	private int level;
	private int levelOrder;
	
	// 그림이 있으면 제목에 이미지표시하는 변수
	private String imgCheck;
}
