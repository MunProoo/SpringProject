package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int idx;
	private String orderIdx;
	private int productIdx;
	private int rating;
	private String mid;
	private String title;
	private String content;
	
	
	/* productContent에서 보여주기 위해서 */
	private String productName;
	private String nickName;
	private String optionName;
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
	 * @return the rating
	 */
	public int getRating() {
		return rating;
	}
	/**
	 * @param rating the rating to set
	 */
	public void setRating(int rating) {
		this.rating = rating;
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
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
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
	 * @return the nickName
	 */
	public String getNickName() {
		return nickName;
	}
	/**
	 * @param nickName the nickName to set
	 */
	public void setNickName(String nickName) {
		this.nickName = nickName;
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
	
}
