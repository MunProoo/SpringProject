package com.spring.cjs2108_mjyProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_mjyProject.vo.BoardVO;

public interface BoardDAO {

	public List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("lately") int lately);

	public int totRecCnt(@Param("lately") int lately);

	public void setBoardInput(@Param("vo") BoardVO vo);

	public void addReadNum(@Param("idx") int idx);

	public List<BoardVO> getPreNext(@Param("idx") int idx);

	public void addGood(@Param("idx") int idx);

	public List<BoardVO> getBoardReply(@Param("idx") int idx);

	public String maxLevelOrder(@Param("boardIdx") int boardIdx);

	public void setReplyInsert(@Param("rVo") BoardVO rVo);

	public void levelOrderPlusUpdate(@Param("rVo") BoardVO rVo);

	public void setReplyInsert2(@Param("rVo") BoardVO rVo);

	public void setReplyDelete(@Param("replyIdx") int replyIdx);

	public BoardVO getBoardContent(@Param("idx") int idx);

	public void setBoardDelete(@Param("idx") int idx);

	public void setBoardUpdate(@Param("vo") BoardVO vo);

	public void deleteBoardList(@Param("array") String[] idx);

	public List<BoardVO> getBoardContentList(@Param("array") String[] idx);

	public int totRecCntSearch(@Param("lately") int lately, @Param("searchString") String searchString, @Param("search") String search);

	public List<BoardVO> getBoardListSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, 
			@Param("lately") int lately, @Param("searchString") String searchString, @Param("search") String search);


}
