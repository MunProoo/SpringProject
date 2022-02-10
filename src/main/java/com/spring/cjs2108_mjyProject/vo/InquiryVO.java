package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class InquiryVO {
	private int idx;
	private String nickName;
	private String category;
	private String title;
	private String status;
	private String iDate;
	private String content;
	
	private int diffTime; //시간계산을 위해 저장한 변수(sql에서 시간단위로 계산해서 넘어온값을 저장)
	
	private int inquiryIdx;
	private String ansContent;
	private String rDate;
	
}
