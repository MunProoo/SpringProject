package com.spring.cjs2108_mjyProject.service;

import java.util.List;

import com.spring.cjs2108_mjyProject.vo.NoticeVO;

public interface NoticeService {

	public int totRecCnt();

	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize);

	public void imgCheck(String content);

	public void setNoticeInput(NoticeVO vo);

	public void addReadNum(int idx);

	public NoticeVO getNoticeContent(int idx);

	public List<NoticeVO> getPreNext(int idx);

	public void imgDelete(String content);

	public void setNoticeDelete(int idx);

	public void imgCheckUpdate(String content);

	public void setNoticeUpdate(NoticeVO vo);

}
