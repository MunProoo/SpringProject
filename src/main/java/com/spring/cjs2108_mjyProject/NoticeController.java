package com.spring.cjs2108_mjyProject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.cjs2108_mjyProject.service.NoticeService;
import com.spring.cjs2108_mjyProject.vo.NoticeVO;

@Controller
@RequestMapping(value="/notice")
public class NoticeController {
	
	String msgFlag = "";
	
	@Autowired
	NoticeService noticeService;
	
	// 공지사항 리스트 페이지 호출
	@RequestMapping(value="/noticeList")
	public String noticeListGet(
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			Model model
			) {
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int totRecCnt = noticeService.totRecCnt();		// 전체자료 갯수 검색
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
	  
	  List<NoticeVO> vos = noticeService.getNoticeList(startIndexNo, pageSize);
	  
	  
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo); 
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "notice/noticeList";
	}
	
	// 공지사항 등록하기 호출
	@RequestMapping(value="/noticeInput")
	public String noticeInputGet() {
		return "notice/noticeInput";
	}
	
	// 공지사항 저장하기
	@RequestMapping(value="/noticeInput", method = RequestMethod.POST)
	public String noticeInputPOST(NoticeVO vo) {
		//이미지파일 업로드시에는 ckeditor폴더에서 notice폴더로 복사작업처리
		noticeService.imgCheck(vo.getContent());
		
		// 이미지 복사작업이 종료되면 실제로 저장된 notice폴더명을 DB에 저장시켜줘야 한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/notice/"));
		
		// 이미지 작업과 실제저장폴더를 set처리후, 잘 정비된 vo를 DB에 저장한다.
		noticeService.setNoticeInput(vo);
		
		return "redirect:/msg/noticeInputOk";
	}
	
	// 공지사항 내용보기 폼 호출
	@RequestMapping(value="/noticeContent")
	public String noticeContentGet(int idx, int pag, int pageSize, Model model) {
		// 조회수 증가시키기
		noticeService.addReadNum(idx);
		
		// 내용각져오기
		NoticeVO vo = noticeService.getNoticeContent(idx);
		
		// 이전글, 다음글 가져오기
		List<NoticeVO> pnVos = noticeService.getPreNext(idx);
		
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "notice/noticeContent";
	}
	
	// 공지사항 삭제하기
	@RequestMapping(value="/noticeDelete")
	public String noticeDeleteGet(int idx, int pag, int pageSize) {
		// 게시글에 사진이 존재한다면 실제 서버파일시스템에서 사진파일을 삭제처리한다.
		NoticeVO vo = noticeService.getNoticeContent(idx);
		
		if(vo.getContent().indexOf("src=\"/") != -1)	noticeService.imgDelete(vo.getContent());
		
		// DB에서 실제 게시글을 삭제처리한다.
		noticeService.setNoticeDelete(idx);
		
		msgFlag = "noticeDeleteOk$pag="+pag+"&pageSize="+pageSize;
		
		return "redirect:/msg/"+msgFlag;
	}
	
	// 공지사항 수정하기
	@RequestMapping(value="/noticeUpdate",method = RequestMethod.GET)
	public String noticeUpdateGet(Model model, int idx, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		
		NoticeVO vo = noticeService.getNoticeContent(idx);
		
		// 수정작업 처리전에 그림파일이 존재한다면 원본파일을 ckeditor폴더로 복사 시켜둔다.
		if(vo.getContent().indexOf("src=\"/") != -1)	noticeService.imgCheckUpdate(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "notice/noticeUpdate";
	}
	
	// 수정된내용 DB에 저장하기
	@RequestMapping(value="/noticeUpdate",method = RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		
		// 원본파일들을 notice폴더에서 삭제처리한다.
		if(vo.getOriContent().indexOf("src=\"/") != -1)	noticeService.imgDelete(vo.getOriContent());
		
		// 원본파일을 수정폼에 들어올때 notice폴더에서 ckeditor폴더로 복사해두고, notice폴더의 파일은 지웠기에, 아래의 복사처리전에 원본파일위치를 vo.content안의 파일경로를 notice폴더에서 ckeditor폴더로 변경처리해줘야한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/notice/", "/data/ckeditor/"));
		
		// 수정된 그림파일을 다시 복사처리한다.(수정된 그림파일의 정보는 content필드에 담겨있다.)('/ckeditor'폴더 -> '/ckeditor/notice'폴더로복사) : 처음파일 입력작업과 같은 작업이기에 아래는 처음 입력시의 메소드를 호출했다.
		noticeService.imgCheck(vo.getContent());
		
		// 필요한 파일을 notice폴더로 복사했기에 vo.content의 내용도 변경한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/notice/"));
		
		// 잘 정비된 vo값만을 DB에 저장시킨다.
		noticeService.setNoticeUpdate(vo);
		
		msgFlag = "noticeUpdateOk$idx="+vo.getIdx()+"&pag="+pag+"&pageSize="+pageSize;
		return "redirect:/msg/" + msgFlag;
	}	
	
	@RequestMapping(value="/qna")
	public String qnaGet() {
		return "notice/qna";
	}
	
	
}
