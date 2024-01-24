package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class CategoryVO {
	private String categoryMainCode;
	private String categoryMainName;
	private String categoryMiddleCode;
	private String categoryMiddleName;
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
}
