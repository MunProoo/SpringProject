package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class ProductOptionVO {
	private int idx;
	private int productIdx;
	private String colorName;
	private int colorPrice;
	private String sizeName;
	private int sizePrice;
	
	private String productName; // 옵션이 적용되는 상품의 이름
	private int colorIdx;    // 컬러테이블 idx
}
