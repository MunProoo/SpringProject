package com.spring.cjs2108_mjyProject.service;

import java.util.List;

import com.spring.cjs2108_mjyProject.vo.BoardVO;

public interface BoardService {

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, int lately);

	public int totRecCnt(int lately);

	public void imgCheck(String content);

	public void setBoardInput(BoardVO vo);

	public void addReadNum(int idx);

	public List<BoardVO> getPreNext(int idx);

	public void addGood(int idx);

	public List<BoardVO> getBoardReply(int idx);

	public String maxLevelOrder(int boardIdx);

	public void setReplyInsert(BoardVO rVo);

	public void levelOrderPlusUpdate(BoardVO rVo);

	public void setReplyInsert2(BoardVO rVo);

	public void setReplyDelete(int replyIdx);

	public BoardVO getBoardContent(int idx);

	public void imgDelete(String content);

	public void setBoardDelete(int idx);

	public void imgCheckUpdate(String content);

	public void setBoardUpdate(BoardVO vo);

	public void deleteBoardList(String[] idx);

	public List<BoardVO> getBoardContentList(String[] idx);

	public int totRecCntSearch(int lately, String searchString, String search);

	public List<BoardVO> getBoardListSearch(int startIndexNo, int pageSize, int lately, String searchString,
			String search);

}
