package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class CategoryVO {
	private String categoryMainCode;
	private String categoryMainName;
	private String categoryMiddleCode;
	private String categoryMiddleName;
	/**
	 * @return the categoryMainCode
	 */
	public String getCategoryMainCode() {
		return categoryMainCode;
	}
	/**
	 * @param categoryMainCode the categoryMainCode to set
	 */
	public void setCategoryMainCode(String categoryMainCode) {
		this.categoryMainCode = categoryMainCode;
	}
	/**
	 * @return the categoryMainName
	 */
	public String getCategoryMainName() {
		return categoryMainName;
	}
	/**
	 * @param categoryMainName the categoryMainName to set
	 */
	public void setCategoryMainName(String categoryMainName) {
		this.categoryMainName = categoryMainName;
	}
	/**
	 * @return the categoryMiddleCode
	 */
	public String getCategoryMiddleCode() {
		return categoryMiddleCode;
	}
	/**
	 * @param categoryMiddleCode the categoryMiddleCode to set
	 */
	public void setCategoryMiddleCode(String categoryMiddleCode) {
		this.categoryMiddleCode = categoryMiddleCode;
	}
	/**
	 * @return the categoryMiddleName
	 */
	public String getCategoryMiddleName() {
		return categoryMiddleName;
	}
	/**
	 * @param categoryMiddleName the categoryMiddleName to set
	 */
	public void setCategoryMiddleName(String categoryMiddleName) {
		this.categoryMiddleName = categoryMiddleName;
	}
}
