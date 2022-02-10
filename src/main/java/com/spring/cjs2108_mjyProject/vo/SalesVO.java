package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class SalesVO {
	private String mainCategory;
	private String middleCategory;
	private int sales;
	private String date;

	// 아이템별 판매금액 및 개수
	private String productName;
	private int totalPrice;
	private int cnt;
	
	
}
