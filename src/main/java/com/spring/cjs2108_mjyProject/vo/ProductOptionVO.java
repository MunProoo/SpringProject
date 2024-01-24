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
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getProductIdx() {
		return productIdx;
	}
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}
	public String getColorName() {
		return colorName;
	}
	public void setColorName(String colorName) {
		this.colorName = colorName;
	}
	public int getColorPrice() {
		return colorPrice;
	}
	public void setColorPrice(int colorPrice) {
		this.colorPrice = colorPrice;
	}
	public String getSizeName() {
		return sizeName;
	}
	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}
	public int getSizePrice() {
		return sizePrice;
	}
	public void setSizePrice(int sizePrice) {
		this.sizePrice = sizePrice;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getColorIdx() {
		return colorIdx;
	}
	public void setColorIdx(int colorIdx) {
		this.colorIdx = colorIdx;
	}
}
