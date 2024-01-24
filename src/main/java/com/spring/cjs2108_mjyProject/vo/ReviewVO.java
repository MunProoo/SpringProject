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
	public int getProductIdx() {
		return productIdx;
	}
	public void setProductIdx(int productIdx) {
		this.productIdx = productIdx;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getOptionName() {
		return optionName;
	}
	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}
	
}
