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

import com.spring.cjs2108_mjyProject.dao.NoticeDAO;
import com.spring.cjs2108_mjyProject.vo.NoticeVO;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeDAO noticeDAO;

	@Override
	public int totRecCnt() {
		return noticeDAO.totRecCnt();
	}

	@Override
	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize) {
		return noticeDAO.getNoticeList(startIndexNo, pageSize);
	}
	
	// ckEditor폴더의 그림을 notice폴더로 복사처리
	@SuppressWarnings("deprecation")
	@Override
	public void imgCheck(String content) {
		//             0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/notice/211229124318_4.jpg"
		
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/ckeditor/");

		// 디버깅 <-> 배포 환경에서 경로가 달라지므로 ckeditor content로부터 이미지 이름 가져오는 로직 변경
		// 정규표현식 패턴
		Pattern pattern = Pattern.compile("src=\"/data/ckeditor/([^\\s\"]+)\"");
		Matcher matcher = pattern.matcher(content);

		 // 매칭된 파일명 출력
        while (matcher.find()) {
            String fileName = matcher.group(1);
            System.out.println("Copy) File Name: " + fileName);

			String copyFilePath = "";
			String oriFilePath = uploadPath + fileName;	// 원본 그림이 들어있는 '경로명+파일명'
			
			copyFilePath = uploadPath + "notice/" + fileName;	// 복사가 될 '경로명+파일명'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
        }

		// content : <p><img alt="" src="/data/ckeditor/240128155501_test.png" style="height:744px; width:1316px" /></p>
		/*
		int position = 39;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		// nextImg =  ng" style="height:744px; width:1316px" /></p>

		
		boolean sw = true;
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			
			copyFilePath = uploadPath + "notice/" + imgFile;	// 복사가 될 '경로명+파일명'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		*/
	}
	
	//실제 파일(ckeditor폴더)을 notice폴더로 복사처리하는곳 
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
	public void setNoticeInput(NoticeVO vo) {
		noticeDAO.setNoticeInput(vo);
	}

	@Override
	public void addReadNum(int idx) {
		noticeDAO.addReadNum(idx);
	}

	@Override
	public NoticeVO getNoticeContent(int idx) {
		return noticeDAO.getNoticeContent(idx);
	}

	@Override
	public List<NoticeVO> getPreNext(int idx) {
		return noticeDAO.getPreNext(idx);
	}
	
	@SuppressWarnings("deprecation")
	@Override
	public void imgDelete(String content) {
		//             0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/notice/211229124318_4.jpg"
		
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/ckeditor/notice/");

		// 디버깅 <-> 배포 환경에서 경로가 달라지므로 ckeditor content로부터 이미지 이름 가져오는 로직 변경
		// 정규표현식 패턴
		Pattern pattern = Pattern.compile("src=\"/data/ckeditor/notice/([^\\s\"]+)\"");
		Matcher matcher = pattern.matcher(content);

		 // 매칭된 파일명 출력
        while (matcher.find()) {
            String fileName = matcher.group(1);
            System.out.println("Delete) File Name: " + fileName);

			String oriFilePath = uploadPath + fileName;	// 원본 그림이 들어있는 '경로명+파일명'
			
			fileDelete(oriFilePath);	// 원본그림을 삭제처리하는 메소드
        }

		/*
		int position = 46;
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
		*/
		
	}
	//원본이미지를 삭제처리하는곳(board폴더에서 삭제처리한다.)
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public void setNoticeDelete(int idx) {
		noticeDAO.setNoticeDelete(idx);
	}

//업데이트처리시 먼저 원본파일들을 복사시켜둔다.('ckeditor/board' -> 'ckeditor/')
	@SuppressWarnings("deprecation")
	@Override
	public void imgCheckUpdate(String content) {
		//   					 0         1         2       2 3   3     4     4   5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_mjyProject/data/ckeditor/notice/211229124318_4.jpg"
		
		if(content.indexOf("src=\"/") == -1) return;
		
		System.out.println("update ) content : " + content);
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/ckeditor/notice/");

		// 디버깅 <-> 배포 환경에서 경로가 달라지므로 ckeditor content로부터 이미지 이름 가져오는 로직 변경
		// 정규표현식 패턴
		Pattern pattern = Pattern.compile("src=\"/data/ckeditor/notice/([^\\s\"]+)\"");
		Matcher matcher = pattern.matcher(content);

		 // 매칭된 파일명 출력
        while (matcher.find()) {
            String fileName = matcher.group(1);
            System.out.println("Update) File Name: " + fileName);

			String oriFilePath = uploadPath + fileName;	// 원본 그림이 들어있는 '경로명+파일명'
			String copyFilePath = request.getRealPath("/resources/data/ckeditor/") + fileName;
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
        }
		
		/*
		int position = 46;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			String copyFilePath = request.getRealPath("/resources/data/ckeditor/" + imgFile);	// 복사가 될 '경로명+파일명'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
		*/
	}

	@Override
	public void setNoticeUpdate(NoticeVO vo) {
		noticeDAO.setNoticeUpdate(vo);
	}
	


	
}
