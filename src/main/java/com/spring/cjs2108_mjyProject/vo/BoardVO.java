package com.spring.cjs2108_mjyProject.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String nickName;
	private String title;
	private String content;
	private String wDate;
	private int readNum;
	private String hostIp;
	private int good;
	private String mid;
	
	private int diffTime;		// 시간계산을 위해 저장한 변수(sql에서 시간단위로 계산해서 넘어온값을 저장)
	private String oriContent; // 원본 content의 내용을 저장시켜두기위한 필드
	
	// 이전글/다음글을 위한 변수
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	// 댓글개수를 위한 변수
	private int replyCnt;
	private int replyCount;
	
	// 댓글관련 변수
	private int boardIdx;
	private int level;
	private int levelOrder;
	
	// 그림이 있으면 제목에 이미지표시하는 변수
	private String imgCheck;

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
	 * @return the hostIp
	 */
	public String getHostIp() {
		return hostIp;
	}

	/**
	 * @param hostIp the hostIp to set
	 */
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}

	/**
	 * @return the good
	 */
	public int getGood() {
		return good;
	}

	/**
	 * @param good the good to set
	 */
	public void setGood(int good) {
		this.good = good;
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

	/**
	 * @return the preIdx
	 */
	public int getPreIdx() {
		return preIdx;
	}

	/**
	 * @param preIdx the preIdx to set
	 */
	public void setPreIdx(int preIdx) {
		this.preIdx = preIdx;
	}

	/**
	 * @return the nextIdx
	 */
	public int getNextIdx() {
		return nextIdx;
	}

	/**
	 * @param nextIdx the nextIdx to set
	 */
	public void setNextIdx(int nextIdx) {
		this.nextIdx = nextIdx;
	}

	/**
	 * @return the preTitle
	 */
	public String getPreTitle() {
		return preTitle;
	}

	/**
	 * @param preTitle the preTitle to set
	 */
	public void setPreTitle(String preTitle) {
		this.preTitle = preTitle;
	}

	/**
	 * @return the nextTitle
	 */
	public String getNextTitle() {
		return nextTitle;
	}

	/**
	 * @param nextTitle the nextTitle to set
	 */
	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}

	/**
	 * @return the replyCnt
	 */
	public int getReplyCnt() {
		return replyCnt;
	}

	/**
	 * @param replyCnt the replyCnt to set
	 */
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	/**
	 * @return the replyCount
	 */
	public int getReplyCount() {
		return replyCount;
	}

	/**
	 * @param replyCount the replyCount to set
	 */
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	/**
	 * @return the boardIdx
	 */
	public int getBoardIdx() {
		return boardIdx;
	}

	/**
	 * @param boardIdx the boardIdx to set
	 */
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}

	/**
	 * @return the level
	 */
	public int getLevel() {
		return level;
	}

	/**
	 * @param level the level to set
	 */
	public void setLevel(int level) {
		this.level = level;
	}

	/**
	 * @return the levelOrder
	 */
	public int getLevelOrder() {
		return levelOrder;
	}

	/**
	 * @param levelOrder the levelOrder to set
	 */
	public void setLevelOrder(int levelOrder) {
		this.levelOrder = levelOrder;
	}

	/**
	 * @return the imgCheck
	 */
	public String getImgCheck() {
		return imgCheck;
	}

	/**
	 * @param imgCheck the imgCheck to set
	 */
	public void setImgCheck(String imgCheck) {
		this.imgCheck = imgCheck;
	}
}
