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
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getiDate() {
		return iDate;
	}
	public void setiDate(String iDate) {
		this.iDate = iDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getDiffTime() {
		return diffTime;
	}
	public void setDiffTime(int diffTime) {
		this.diffTime = diffTime;
	}
	public int getInquiryIdx() {
		return inquiryIdx;
	}
	public void setInquiryIdx(int inquiryIdx) {
		this.inquiryIdx = inquiryIdx;
	}
	public String getAnsContent() {
		return ansContent;
	}
	public void setAnsContent(String ansContent) {
		this.ansContent = ansContent;
	}
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	
}
