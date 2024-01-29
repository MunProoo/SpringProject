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
	/**
	 * @return the mainCategory
	 */
	public String getMainCategory() {
		return mainCategory;
	}
	/**
	 * @param mainCategory the mainCategory to set
	 */
	public void setMainCategory(String mainCategory) {
		this.mainCategory = mainCategory;
	}
	/**
	 * @return the middleCategory
	 */
	public String getMiddleCategory() {
		return middleCategory;
	}
	/**
	 * @param middleCategory the middleCategory to set
	 */
	public void setMiddleCategory(String middleCategory) {
		this.middleCategory = middleCategory;
	}
	/**
	 * @return the sales
	 */
	public int getSales() {
		return sales;
	}
	/**
	 * @param sales the sales to set
	 */
	public void setSales(int sales) {
		this.sales = sales;
	}
	/**
	 * @return the date
	 */
	public String getDate() {
		return date;
	}
	/**
	 * @param date the date to set
	 */
	public void setDate(String date) {
		this.date = date;
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
	 * @return the totalPrice
	 */
	public int getTotalPrice() {
		return totalPrice;
	}
	/**
	 * @param totalPrice the totalPrice to set
	 */
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	/**
	 * @return the cnt
	 */
	public int getCnt() {
		return cnt;
	}
	/**
	 * @param cnt the cnt to set
	 */
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	
}
