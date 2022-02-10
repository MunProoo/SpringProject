package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int idx;
	private String productCode;
	private String productName;
	private String detail;
	private int mainPrice;
	private String fName;
	private String fSName;
	private String content;
	
	private String categoryMainCode;
	private String categoryMainName;
	private String categoryMiddleCode;
	private String categoryMiddleName;
	
	/* 추천상품에서 사용 */
	private int productIdx;
	/* 인기상품에서 사용 */
	private double ratingAvg;
	
	private String oriContent; // 원본 content의 내용을 저장시켜두기위한 필드
}
