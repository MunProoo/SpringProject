package com.spring.cjs2108_mjyProject;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_mjyProject.service.BoardService;
import com.spring.cjs2108_mjyProject.vo.BoardVO;
import com.spring.cjs2108_mjyProject.vo.NoticeVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	String msgFlag = "";
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value="/boardList")
	public String boardListGet(Model model,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately
			) {
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int totRecCnt = boardService.totRecCnt(lately);		// 전체자료 갯수 검색
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
		
		List<BoardVO> vos = boardService.getBoardList(startIndexNo, pageSize, lately);
		
		for(BoardVO vo : vos) {
			if(vo.getContent().indexOf("img") != -1 )vo.setImgCheck("ON");
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo); 
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("lately", lately);
		return "board/boardList";
	}
	
	// 게시판 등록 호출
	@RequestMapping(value="/boardInput")
	public String boardInputGet(Model model) {
		return "board/boardInput";
	}
	
	//게시글 저장하기
	@RequestMapping(value="/boardInput", method = RequestMethod.POST)
	public String noticeInputPOST(BoardVO vo) {
		
		//이미지파일 업로드시에는 ckeditor폴더에서 board폴더로 복사작업처리
		boardService.imgCheck(vo.getContent());
		// 이미지 복사작업이 종료되면 실제로 저장된 board폴더명을 DB에 저장시켜줘야 한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));
		// 이미지 작업과 실제저장폴더를 set처리후, 잘 정비된 vo를 DB에 저장한다.
		boardService.setBoardInput(vo);
		
		return "redirect:/msg/boardInputOk";
	}
	
	// 게시글 내용보기
	@RequestMapping(value="/boardContent")
	public String boContentGet(int idx, int pag, int pageSize, int lately, Model model, HttpSession session) {
		
		// 세션배열을 만들어서 좋아요 중복처리배제하기
		List<String> sReadNum = (ArrayList)session.getAttribute("sReadNum");
		
		if(sReadNum == null) {    // List는 isEmpty()로 null체크하던데 (서버에서 데이터 가져올때) 세션값은 null 그대로 받는듯
			sReadNum = new ArrayList<String>();
			session.setAttribute("sReadNum", sReadNum);
		}
		String tempReadNumIdx = "board_Read" + idx + "_" + session.getId(); // 동시에 같은 게시물을 보는것을 가려내기위해 session.getId()추가
		
		if(!sReadNum.contains(tempReadNumIdx)) {
			sReadNum.add(tempReadNumIdx);
			// 조회수 증가시키기
			boardService.addReadNum(idx);
		}
		
		// 내용각져오기
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 이전글, 다음글 가져오기
		List<BoardVO> pnVos = boardService.getPreNext(idx);
		
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("lately", lately);
		
		// 댓글 가져오기
		List<BoardVO> rVos = boardService.getBoardReply(idx);
		model.addAttribute("rVos", rVos);
		
		return "board/boardContent";
	}
	
	// 좋아요 처리 (세션으로 중복방지)
	@ResponseBody
	@RequestMapping(value="/boardGood", method = RequestMethod.POST)
	public String boardGoodPost(int idx, HttpSession session) {
		
		// 세션배열을 만들어서 좋아요 중복처리배제하기
		List<String> sGoodIdx = (ArrayList)session.getAttribute("sGoodIdx");
		
		if(sGoodIdx == null) {    // List는 isEmpty()로 null체크하던데 (서버에서 데이터 가져올때) 세션값은 null 그대로 받는듯
			sGoodIdx = new ArrayList<String>();
			session.setAttribute("sGoodIdx", sGoodIdx);
		}
		String tempGoodIdx = "board_" + idx + "_" + session.getId(); // 동시에 같은 게시물을 보는것을 가려내기위해 session.getId()추가
		
		if(!sGoodIdx.contains(tempGoodIdx)) {
			sGoodIdx.add(tempGoodIdx);
			boardService.addGood(idx);
			return "";
		}
		else {
			return "1";
		}
		
	}
	
	
	// 댓글달기
	@ResponseBody
	@RequestMapping(value="/boardReplyInsert", method = RequestMethod.POST)
	public String boardReplyInsertPost(BoardVO rVo) {
		int levelOrder = 0;
		String strLevelOrder = boardService.maxLevelOrder(rVo.getBoardIdx()); 
		if(strLevelOrder != null) levelOrder = Integer.parseInt(strLevelOrder) + 1;
		rVo.setLevelOrder(levelOrder);
		
		boardService.setReplyInsert(rVo);
		return "";
	}
	
	// 대댓글 달기
	@ResponseBody
	@RequestMapping(value="/boardReplyInsert2", method = RequestMethod.POST)
	public String boardReplyInsert2Post(BoardVO rVo) {
		boardService.levelOrderPlusUpdate(rVo);  // 부모댓글의 levelOrder값보다 큰 모든 댓글의 lovelOrder값을 +1 시켜준다.
		//rVo.setLevel(rVo.getLevel()+1);						// 자신의 level은 부모 level 보다 +1 해준다.
		rVo.setLevel(1);    // 대댓글까지만. 대대대대댓글 보기 좀 그럼
		rVo.setLevelOrder(rVo.getLevelOrder()+1); // 자신의 levelOrder은 부모 levelOrder 보다 +1 해준다.
		
		boardService.setReplyInsert2(rVo);
		return "";
	}
	
	//댓글 삭제처리
	@ResponseBody
	@RequestMapping(value="/boardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(int replyIdx) {
		boardService.setReplyDelete(replyIdx);
		return "";
	}
	
	//게시글 삭제
	@RequestMapping(value="/boardDelete")
	public String boardDeleteGet(int idx, int pag, int pageSize, int lately) {
		// 게시글에 사진이 있다면 서버에서 사진삭제
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1)	boardService.imgDelete(vo.getContent());
		
	  // DB에서 실제 게시글을 삭제처리한다.
		boardService.setBoardDelete(idx);
		msgFlag = "boardDeleteOk$pag="+pag+"&pageSize="+pageSize+"&lately="+lately;
		return "redirect:/msg/" + msgFlag;
	}
	
	

	@RequestMapping(value="/boardUpdate")
	public String boardUpdateGet(Model model, int idx, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately
			) {
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 수정작업 처리전에 그림파일이 존재한다면 원본파일을 ckeditor폴더로 복사 시켜둔다.
		if(vo.getContent().indexOf("src=\"/") != -1)	boardService.imgCheckUpdate(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("lately", lately);
		
		return "board/boardUpdate";
	}
	
	//수정된내용 DB에 저장하기
	@RequestMapping(value="/boardUpdate",method = RequestMethod.POST)
	public String boardUpdatePost(BoardVO vo, int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately) {
		
		// 원본파일들을 board폴더에서 삭제처리한다.
		if(vo.getOriContent().indexOf("src=\"/") != -1)	boardService.imgDelete(vo.getOriContent());
		
		// 원본파일을 수정폼에 들어올때 board폴더에서 ckeditor폴더로 복사해두고, board폴더의 파일은 지웠기에, 아래의 복사처리전에 db의 vo.content안의 파일경로를 board폴더에서 ckeditor폴더로 변경처리해줘야한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/board/", "/data/ckeditor/"));
		
		// 수정된 그림파일을 다시 복사처리한다.(수정된 그림파일의 정보는 content필드에 담겨있다.)('/ckeditor'폴더 -> '/ckeditor/board'폴더로복사) : 처음파일 입력작업과 같은 작업이기에 아래는 처음 입력시의 메소드를 호출했다.
		boardService.imgCheck(vo.getContent());
		
		// 필요한 파일을 board폴더로 복사했기에 vo.content의 내용도 변경한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/board/"));
		
		// 잘 정비된 vo값만을 DB에 저장시킨다.
		boardService.setBoardUpdate(vo);
		
		msgFlag = "boardUpdateOk$idx="+vo.getIdx()+"&pag="+pag+"&pageSize="+pageSize+"&lately="+lately;
		return "redirect:/msg/" + msgFlag;
	}
	
	// boardList 검색기능
	@RequestMapping(value="/boardSearch" , method = RequestMethod.GET)
	public String boardSearchPost(Model model, String searchString, 
			@RequestParam(name="search", defaultValue = "nickName", required = false) String search,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="360", required=false) int lately
			) {
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int totRecCnt = boardService.totRecCntSearch(lately, searchString, search);		// 전체자료 갯수 검색
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
		
		List<BoardVO> vos = boardService.getBoardListSearch(startIndexNo, pageSize, lately, searchString, search);
		
		for(BoardVO vo : vos) {
			if(vo.getContent().indexOf("src=\"/") != -1 )vo.setImgCheck("ON");
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo); 
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("lately", lately);
		
		
		return "board/boardList";
	}
	
	// boardList (관리자용) 검색기능
	@RequestMapping(value="/adBoardSearch" , method = RequestMethod.POST)
	public String adBoardSearchPost(Model model, String searchString, String search,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="lately", defaultValue="0", required=false) int lately
			) {
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
		int totRecCnt = boardService.totRecCntSearch(lately, searchString, search);		// 전체자료 갯수 검색
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStrarNo = totRecCnt - startIndexNo;
		int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
		int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
		int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		/* 블록페이징처리 끝 */
		
		List<BoardVO> vos = boardService.getBoardListSearch(startIndexNo, pageSize, lately, searchString, search);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo); 
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("lately", lately);
		
		return "admin/board/adBoardList";
	}
	
	
	
}
