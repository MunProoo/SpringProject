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

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public int getMainPrice() {
		return mainPrice;
	}

	public void setMainPrice(int mainPrice) {
		this.mainPrice = mainPrice;
	}

	public String getFName() {
		return fName;
	}

	public void setFName(String fName) {
		this.fName = fName;
	}

	public String getFSName() {
		return fSName;
	}

	public void setFSName(String fSName) {
		this.fSName = fSName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCategoryMainCode() {
		return categoryMainCode;
	}

	public void setCategoryMainCode(String categoryMainCode) {
		this.categoryMainCode = categoryMainCode;
	}

	public String getCategoryMainName() {
		return categoryMainName;
	}

	public void setCategoryMainName(String categoryMainName) {
		this.categoryMainName = categoryMainName;
	}

	public String getCategoryMiddleCode() {
		return categoryMiddleCode;
	}

	public void setCategoryMiddleCode(String categoryMiddleCode) {
		this.categoryMiddleCode = categoryMiddleCode;
	}

	public String getCategoryMiddleName() {
		return categoryMiddleName;
	}

	public void setCategoryMiddleName(String categoryMiddleName) {
		this.categoryMiddleName = categoryMiddleName;
	}

	public int getProductIdx() {
		return productIdx;
	}

	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}

	public double getRatingAvg() {
		return ratingAvg;
	}

	public void setRatingAvg(double ratingAvg) {
		this.ratingAvg = ratingAvg;
	}

	public String getOriContent() {
		return oriContent;
	}

	public void setOriContent(String oriContent) {
		this.oriContent = oriContent;
	}
}
