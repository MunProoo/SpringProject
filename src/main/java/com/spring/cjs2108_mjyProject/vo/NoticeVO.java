package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class NoticeVO {
	private int idx;
	private String nickName;
	private String title;
	private String content;
	private String wDate;
	private int readNum;
	private String mid;
	
	private int diffTime; //시간계산을 위해 저장한 변수(sql에서 시간단위로 계산해서 넘어온값을 저장)
	private String oriContent;// 원본 content의 내용을 저장시켜두기위한 필드
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
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public int getReadNum() {
		return readNum;
	}
	public void setReadNum(int readNum) {
		this.readNum = readNum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getDiffTime() {
		return diffTime;
	}
	public void setDiffTime(int diffTime) {
		this.diffTime = diffTime;
	}
	public String getOriContent() {
		return oriContent;
	}
	public void setOriContent(String oriContent) {
		this.oriContent = oriContent;
	}
}
