package com.spring.cjs2108_mjyProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_mjyProject.vo.NoticeVO;

public interface NoticeDAO {

	public int totRecCnt();

	public List<NoticeVO> getNoticeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public void setNoticeInput(@Param("vo") NoticeVO vo);

	public void addReadNum(@Param("idx") int idx);

	public NoticeVO getNoticeContent(@Param("idx") int idx);

	public List<NoticeVO> getPreNext(@Param("idx") int idx);

	public void setNoticeDelete(@Param("idx") int idx);

	public void setNoticeUpdate(@Param("vo") NoticeVO vo);

	
}
