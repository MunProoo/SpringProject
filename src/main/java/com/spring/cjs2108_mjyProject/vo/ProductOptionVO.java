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
	/**
	 * @return the idx
	 */
	public int getIdx() {
		return idx;
	}
	/**
	 * @param idx the idx to set
	 */
	public void setIdx(int idx) {
		this.idx = idx;
	}
	/**
	 * @return the productIdx
	 */
	public int getProductIdx() {
		return productIdx;
	}
	/**
	 * @param productIdx the productIdx to set
	 */
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}
	/**
	 * @return the colorName
	 */
	public String getColorName() {
		return colorName;
	}
	/**
	 * @param colorName the colorName to set
	 */
	public void setColorName(String colorName) {
		this.colorName = colorName;
	}
	/**
	 * @return the colorPrice
	 */
	public int getColorPrice() {
		return colorPrice;
	}
	/**
	 * @param colorPrice the colorPrice to set
	 */
	public void setColorPrice(int colorPrice) {
		this.colorPrice = colorPrice;
	}
	/**
	 * @return the sizeName
	 */
	public String getSizeName() {
		return sizeName;
	}
	/**
	 * @param sizeName the sizeName to set
	 */
	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}
	/**
	 * @return the sizePrice
	 */
	public int getSizePrice() {
		return sizePrice;
	}
	/**
	 * @param sizePrice the sizePrice to set
	 */
	public void setSizePrice(int sizePrice) {
		this.sizePrice = sizePrice;
	}
	/**
	 * @return the productName
	 */
	public String getProductName() {
		return productName;
	}
	/**
	 * @param productName the productName to set
	 */
	public void setProductName(String productName) {
		this.productName = productName;
	}
	/**
	 * @return the colorIdx
	 */
	public int getColorIdx() {
		return colorIdx;
	}
	/**
	 * @param colorIdx the colorIdx to set
	 */
	public void setColorIdx(int colorIdx) {
		this.colorIdx = colorIdx;
	}
}
