package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class InquiryVO {
	private int idx;
	private String nickName;
	private String category;
	private String title;
	private String status;
	private String iDate;
	private String content;
	
	private int diffTime; //시간계산을 위해 저장한 변수(sql에서 시간단위로 계산해서 넘어온값을 저장)
	
	private int inquiryIdx;
	private String ansContent;
	private String rDate;
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
	 * @return the category
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * @param category the category to set
	 */
	public void setCategory(String category) {
		this.category = category;
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
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the iDate
	 */
	public String getiDate() {
		return iDate;
	}
	/**
	 * @param iDate the iDate to set
	 */
	public void setiDate(String iDate) {
		this.iDate = iDate;
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
	 * @return the diffTime
	 */
	public int getDiffTime() {
		return diffTime;
	}
	/**
	 * @param diffTime the diffTime to set
	 */
	public void setDiffTime(int diffTime) {
		this.diffTime = diffTime;
	}
	/**
	 * @return the inquiryIdx
	 */
	public int getInquiryIdx() {
		return inquiryIdx;
	}
	/**
	 * @param inquiryIdx the inquiryIdx to set
	 */
	public void setInquiryIdx(int inquiryIdx) {
		this.inquiryIdx = inquiryIdx;
	}
	/**
	 * @return the ansContent
	 */
	public String getAnsContent() {
		return ansContent;
	}
	/**
	 * @param ansContent the ansContent to set
	 */
	public void setAnsContent(String ansContent) {
		this.ansContent = ansContent;
	}
	/**
	 * @return the rDate
	 */
	public String getrDate() {
		return rDate;
	}
	/**
	 * @param rDate the rDate to set
	 */
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	
}
