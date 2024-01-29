package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int idx;
  private String orderIdx;
  private String mid;
  private int productIdx;
  private String orderDate;
  private String productName;
  private int mainPrice;
  private String thumbImg;
  private String optionName;
  private String optionPrice;
  private String optionNum;
  private int totalPrice;
  
  private int cartIdx;  // 장바구니 고유번호.
  private int maxIdx;   // 주문번호를 구하기위한 기존 최대 비밀번호필드
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
 * @return the orderIdx
 */
public String getOrderIdx() {
	return orderIdx;
}
/**
 * @param orderIdx the orderIdx to set
 */
public void setOrderIdx(String orderIdx) {
	this.orderIdx = orderIdx;
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
 * @return the orderDate
 */
public String getOrderDate() {
	return orderDate;
}
/**
 * @param orderDate the orderDate to set
 */
public void setOrderDate(String orderDate) {
	this.orderDate = orderDate;
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
/**
 * @return the cartIdx
 */
public int getCartIdx() {
	return cartIdx;
}
/**
 * @param cartIdx the cartIdx to set
 */
public void setCartIdx(int cartIdx) {
	this.cartIdx = cartIdx;
}
/**
 * @return the maxIdx
 */
public int getMaxIdx() {
	return maxIdx;
}
/**
 * @param maxIdx the maxIdx to set
 */
public void setMaxIdx(int maxIdx) {
	this.maxIdx = maxIdx;
}
}
