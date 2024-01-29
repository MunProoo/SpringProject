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
	 * @return the wDate
	 */
	public String getwDate() {
		return wDate;
	}
	/**
	 * @param wDate the wDate to set
	 */
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	/**
	 * @return the readNum
	 */
	public int getReadNum() {
		return readNum;
	}
	/**
	 * @param readNum the readNum to set
	 */
	public void setReadNum(int readNum) {
		this.readNum = readNum;
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
	 * @return the oriContent
	 */
	public String getOriContent() {
		return oriContent;
	}
	/**
	 * @param oriContent the oriContent to set
	 */
	public void setOriContent(String oriContent) {
		this.oriContent = oriContent;
	}
}
