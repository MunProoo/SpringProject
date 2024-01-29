package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class CartListVO {
	private int idx;
	private String cartDate;
	private String mid;
	private int productIdx;
	private String productName;
	private int mainPrice;
	private String thumbImg;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
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
	 * @return the cartDate
	 */
	public String getCartDate() {
		return cartDate;
	}
	/**
	 * @param cartDate the cartDate to set
	 */
	public void setCartDate(String cartDate) {
		this.cartDate = cartDate;
	}
	/**
	 * @return the mid
	 */
	public String getMid() {
		return mid;
	}
	/**
	 * @param mid the mid to set
	 */
	public void setMid(String mid) {
		this.mid = mid;
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
	 * @return the mainPrice
	 */
	public int getMainPrice() {
		return mainPrice;
	}
	/**
	 * @param mainPrice the mainPrice to set
	 */
	public void setMainPrice(int mainPrice) {
		this.mainPrice = mainPrice;
	}
	/**
	 * @return the thumbImg
	 */
	public String getThumbImg() {
		return thumbImg;
	}
	/**
	 * @param thumbImg the thumbImg to set
	 */
	public void setThumbImg(String thumbImg) {
		this.thumbImg = thumbImg;
	}
	/**
	 * @return the optionName
	 */
	public String getOptionName() {
		return optionName;
	}
	/**
	 * @param optionName the optionName to set
	 */
	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}
	/**
	 * @return the optionPrice
	 */
	public String getOptionPrice() {
		return optionPrice;
	}
	/**
	 * @param optionPrice the optionPrice to set
	 */
	public void setOptionPrice(String optionPrice) {
		this.optionPrice = optionPrice;
	}
	/**
	 * @return the optionNum
	 */
	public String getOptionNum() {
		return optionNum;
	}
	/**
	 * @param optionNum the optionNum to set
	 */
	public void setOptionNum(String optionNum) {
		this.optionNum = optionNum;
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
}
