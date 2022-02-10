package com.spring.cjs2108_mjyProject.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.cjs2108_mjyProject.dao.BoardDAO;
import com.spring.cjs2108_mjyProject.vo.BoardVO;
import com.spring.cjs2108_mjyProject.vo.NoticeVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;
	
	@Override
	public int totRecCnt(int lately) {
		return boardDAO.totRecCnt(lately);
	}

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, int lately) {
		return boardDAO.getBoardList(startIndexNo, pageSize, lately);
	}

	
	//ckEditor폴더의 그림을 notice폴더로 복사처리
	@SuppressWarnings("deprecation")
	@Override
	public void imgCheck(String content) {
		//             0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/board/211229124318_4.jpg"
		
		if(content.indexOf("src=\"/") == -1) return; // 이미지 없으면 리턴
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/ckeditor/");
		int position = 39;   //서버에 저장한 경로에서 파일 이름까지의 길이
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			
			copyFilePath = uploadPath + "board/" + imgFile;	// 복사가 될 '경로명+파일명'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	//실제 파일(ckeditor폴더)을 board폴더로 복사처리하는곳 
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream  fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void setBoardInput(BoardVO vo) {
		boardDAO.setBoardInput(vo);
	}

	@Override
	public void addReadNum(int idx) {
		boardDAO.addReadNum(idx);
	}

	@Override
	public List<BoardVO> getPreNext(int idx) {
		return boardDAO.getPreNext(idx);
	}

	@Override
	public void addGood(int idx) {
		boardDAO.addGood(idx);
	}

	@Override
	public List<BoardVO> getBoardReply(int idx) {
		return boardDAO.getBoardReply(idx);
	}

	@Override
	public String maxLevelOrder(int boardIdx) {
		return boardDAO.maxLevelOrder(boardIdx);
	}

	@Override
	public void setReplyInsert(BoardVO rVo) {
		boardDAO.setReplyInsert(rVo);
	}

	@Override
	public void levelOrderPlusUpdate(BoardVO rVo) {
		boardDAO.levelOrderPlusUpdate(rVo);
	}

	@Override
	public void setReplyInsert2(BoardVO rVo) {
		boardDAO.setReplyInsert2(rVo);
	}

	@Override
	public void setReplyDelete(int replyIdx) {
		boardDAO.setReplyDelete(replyIdx);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}
	
	@SuppressWarnings("deprecation")
	@Override
	public void imgDelete(String content) {
		//  					 0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/board/211229124318_4.jpg"
		
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/ckeditor/board/");
		
		int position = 45;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			
			fileDelete(oriFilePath);	// 원본그림을 삭제처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	//원본이미지를 삭제처리하는곳(board폴더에서 삭제처리한다.)
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void setBoardDelete(int idx) {
		boardDAO.setBoardDelete(idx);
	}
	
	// 업데이트 처리시 이미지파일이 바뀔 수도 있으므로 원본파일 복사?
	@SuppressWarnings("deprecation")
	@Override
	public void imgCheckUpdate(String content) {
		//	 					 0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/board/211229124318_4.jpg"
		
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/ckeditor/board/");
		
		int position = 45;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			String copyFilePath = request.getRealPath("/resources/data/ckeditor/" + imgFile);	// 복사가 될 '경로명+파일명'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림을 복사될 위치로 복사작업처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	@Override
	public void setBoardUpdate(BoardVO vo) {
		boardDAO.setBoardUpdate(vo);
	}

	@Override
	public void deleteBoardList(String[] idx) {
		boardDAO.deleteBoardList(idx);
	}

	@Override
	public List<BoardVO> getBoardContentList(String[] idx) {
		return boardDAO.getBoardContentList(idx);
	}

	@Override
	public int totRecCntSearch(int lately, String searchString, String search) {
		return boardDAO.totRecCntSearch(lately, searchString, search);
	}

	@Override
	public List<BoardVO> getBoardListSearch(int startIndexNo, int pageSize, int lately, String searchString,
			String search) {
		return boardDAO.getBoardListSearch(startIndexNo, pageSize, lately, searchString, search);
	}
	

}
