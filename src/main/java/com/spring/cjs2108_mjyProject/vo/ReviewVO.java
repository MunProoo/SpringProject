package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int idx;
	private String orderIdx;
	private int productIdx;
	private int rating;
	private String mid;
	private String title;
	private String content;
	
	
	/* productContent에서 보여주기 위해서 */
	private String productName;
	private String nickName;
	private String optionName;
	
}
