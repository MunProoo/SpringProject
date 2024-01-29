package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class BaesongVO {
	private int idx;
	private int oIdx;
	private String orderIdx;
	private int orderTotalPrice;
	private String mid;
	private String name;
	private String address;
	private String tel;
	private String email;
	private String message;
	private String payment;
	private String orderStatus;
	
	// 아래는 주문테이블에서 사용된 필드리스트이다.
	private int productIdx;
	private String orderDate;
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
	 * @return the oIdx
	 */
	public int getOIdx() {
		return oIdx;
	}
	/**
	 * @param oIdx the oIdx to set
	 */
	public void setOIdx(int oIdx) {
		this.oIdx = oIdx;
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
	 * @return the orderTotalPrice
	 */
	public int getOrderTotalPrice() {
		return orderTotalPrice;
	}
	/**
	 * @param orderTotalPrice the orderTotalPrice to set
	 */
	public void setOrderTotalPrice(int orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
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
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the tel
	 */
	public String getTel() {
		return tel;
	}
	/**
	 * @param tel the tel to set
	 */
	public void setTel(String tel) {
		this.tel = tel;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * @return the payment
	 */
	public String getPayment() {
		return payment;
	}
	/**
	 * @param payment the payment to set
	 */
	public void setPayment(String payment) {
		this.payment = payment;
	}
	/**
	 * @return the orderStatus
	 */
	public String getOrderStatus() {
		return orderStatus;
	}
	/**
	 * @param orderStatus the orderStatus to set
	 */
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
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
}
