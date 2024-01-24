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
public int getIdx() {
	return idx;
}
public void setIdx(int idx) {
	this.idx = idx;
}
public String getOrderIdx() {
	return orderIdx;
}
public void setOrderIdx(String orderIdx) {
	this.orderIdx = orderIdx;
}
public String getMid() {
	return mid;
}
public void setMid(String mid) {
	this.mid = mid;
}
public int getProductIdx() {
	return productIdx;
}
public void setProductIdx(int productIdx) {
	this.productIdx = productIdx;
}
public String getOrderDate() {
	return orderDate;
}
public void setOrderDate(String orderDate) {
	this.orderDate = orderDate;
}
public String getProductName() {
	return productName;
}
public void setProductName(String productName) {
	this.productName = productName;
}
public int getMainPrice() {
	return mainPrice;
}
public void setMainPrice(int mainPrice) {
	this.mainPrice = mainPrice;
}
public String getThumbImg() {
	return thumbImg;
}
public void setThumbImg(String thumbImg) {
	this.thumbImg = thumbImg;
}
public String getOptionName() {
	return optionName;
}
public void setOptionName(String optionName) {
	this.optionName = optionName;
}
public String getOptionPrice() {
	return optionPrice;
}
public void setOptionPrice(String optionPrice) {
	this.optionPrice = optionPrice;
}
public String getOptionNum() {
	return optionNum;
}
public void setOptionNum(String optionNum) {
	this.optionNum = optionNum;
}
public int getTotalPrice() {
	return totalPrice;
}
public void setTotalPrice(int totalPrice) {
	this.totalPrice = totalPrice;
}
public int getCartIdx() {
	return cartIdx;
}
public void setCartIdx(int cartIdx) {
	this.cartIdx = cartIdx;
}
public int getMaxIdx() {
	return maxIdx;
}
public void setMaxIdx(int maxIdx) {
	this.maxIdx = maxIdx;
}
}
