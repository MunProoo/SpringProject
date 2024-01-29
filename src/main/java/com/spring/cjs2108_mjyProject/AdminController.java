package com.spring.cjs2108_mjyProject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_mjyProject.service.AdminService;
import com.spring.cjs2108_mjyProject.service.BoardService;
import com.spring.cjs2108_mjyProject.service.InquiryService;
import com.spring.cjs2108_mjyProject.service.MemberService;
import com.spring.cjs2108_mjyProject.service.ProductService;
import com.spring.cjs2108_mjyProject.vo.BoardVO;
import com.spring.cjs2108_mjyProject.vo.CategoryVO;
import com.spring.cjs2108_mjyProject.vo.MemberVO;
import com.spring.cjs2108_mjyProject.vo.ProductVO;
import com.spring.cjs2108_mjyProject.vo.SalesVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	String msgFlag = "";
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ProductService productService;
	
	@RequestMapping(value="/adMenu")
	public String adMenuGet() {
		return "admin/adMenu";
	}
	
	@RequestMapping(value="/adLeft")
	public String adTopGet() {
		return "admin/adLeft";
	}
	
	@RequestMapping(value="/adContent")
	public String adContentGet(Model model) {
		int totRecCnt = adminService.totRecCnt(99);
		int newMember = adminService.getNewMember();
		int newInquiry = inquiryService.getNewInquiry();
		int members = adminService.getMembersCnt("NO"); 
		int delMembers = adminService.getMembersCnt("OK");
		int products = adminService.getProductCnt("전체");
		int orderCnt = adminService.getProductCnt("판매");
		int sales = adminService.getSales();
		
		model.addAttribute("totRecCnt",totRecCnt);
		model.addAttribute("newMember",newMember);
		model.addAttribute("newInquiry",newInquiry);
		model.addAttribute("members",members);
		model.addAttribute("delMembers",delMembers);
		model.addAttribute("products",products);
		model.addAttribute("orderCnt",orderCnt);
		model.addAttribute("sales",sales);
		
		return "admin/adContent";
	}
	
	@RequestMapping(value="/adMemberList")
	public String adMemberListGet(
			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
			@RequestParam(name="level", defaultValue="99", required = false) int level,
			@RequestParam(name="mid", defaultValue="", required = false) String mid,
			@RequestParam(name="userDel", defaultValue="NO", required = false) String userDel,
			Model model ) {
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int pageSize = 5;
	  int totRecCnt = 0;
	  if(mid.equals("")) {
	  	totRecCnt = adminService.totRecCnt(level);// 전체자료 갯수 검색(level처리)
	  }
	  else {
	  	totRecCnt = adminService.totRecCntMid(mid);	// 개별자료 검색
	  }
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
	  
	  List<MemberVO> vos = new ArrayList<MemberVO>();
	  
	  if(userDel.equals("OK")){
		  vos = adminService.getMemberListDel(startIndexNo, pageSize, userDel);
	  }
	  else if(mid.equals("")) { // 전체 회원 리스트
	  	vos = adminService.getMemberList(startIndexNo, pageSize, level);
	  }
	  else { // 검색한 회원리스트
	  	vos = adminService.getMemberListMid(startIndexNo, pageSize, mid);
	  	System.out.println("여기 오는거 맞나?");
	  }
	  
	  model.addAttribute("vos", vos);
	  model.addAttribute("pag", pag);
	  model.addAttribute("totPage", totPage);
	  model.addAttribute("curScrStrarNo", curScrStrarNo);
	  model.addAttribute("blockSize", blockSize);
	  model.addAttribute("curBlock", curBlock);
	  model.addAttribute("lastBlock", lastBlock);
		
	  model.addAttribute("level", level);
	  model.addAttribute("mid", mid);
	  model.addAttribute("totRecCnt", totRecCnt);
		
		return "admin/member/adMemberList";
	}
	
	// 회원 레벨 변경
	@ResponseBody
	@RequestMapping(value="/adMemberLevel", method = RequestMethod.POST)
	public String adMemberLevelPost(int idx, int level) {
		adminService.setLevelUpdate(idx,level);
		return "";
	}
	
	// 회원 정보 보기
	@RequestMapping(value="adMemberInfo")
	public String adMemberInfoGet(int idx, Model model) {
		MemberVO vo = adminService.getMember(idx);
		model.addAttribute("vo", vo);
		return "admin/member/adMemberInfo"; 
	}
	
	// 임시파일 삭제 페이지
	@RequestMapping(value="/tempFileDelete")
	public String tempFileDeleteGet() {
		return "admin/file/tempFileDelete";
	}
	
	// 공지사항 임시파일 삭제
	@SuppressWarnings("deprecation")
	@RequestMapping(value="/noticeTempDelete")
	public String noticeTempDeleteGet(HttpServletRequest request) {
		// 공지사항 작업시 생성된 data/ckeditor/ 폴더의 모든 그림파일들 삭제처리
		String uploadPath = request.getRealPath("/resources/data/ckeditor/");
		String flag = "ckeditor";
		int fileCnt = adminService.imgDelete(uploadPath,flag);
		msgFlag = "imgDeleteOk+" + fileCnt;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 상품 임시파일 삭제
	@SuppressWarnings("deprecation")
	@RequestMapping(value="/productTempDelete")
	public String productTempDeleteGet(HttpServletRequest request) {
		// 공지사항 작업시 생성된 data/ckeditor/ 폴더의 모든 그림파일들 삭제처리
		String uploadPath = request.getRealPath("/resources/data/shop/");
		String flag = "shop";
		int fileCnt = adminService.imgDelete(uploadPath,flag);
		msgFlag = "imgDeleteOk+" + fileCnt;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 게시판 임시파일 삭제
	@SuppressWarnings("deprecation")
	@RequestMapping(value="/boardTempDelete")
	public String boardTempDeleteGet(HttpServletRequest request) {
		// 공지사항 작업시 생성된 data/ckeditor/ 폴더의 모든 그림파일들 삭제처리
		String uploadPath = request.getRealPath("/resources/data/ckeditor/");
		String flag = "ckeditor";
		int fileCnt = adminService.imgDelete(uploadPath,flag);
		msgFlag = "imgDeleteOk+" + fileCnt;
		return "redirect:/msg/" + msgFlag;
	}
	
	// 게시판 관리페이지
	@RequestMapping(value="/adBoardList")
	public String adBoardListGet(Model model,
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
		
		return "admin/board/adBoardList";
	}
	
	//게시글 삭제 
	@ResponseBody
	@RequestMapping(value="/boardDelete" , method = RequestMethod.POST)
	public String boardDeletePost(String idx) {
		int boardIdx = Integer.parseInt(idx);
		// 게시글에 사진이 있다면 서버에서 사진삭제
		BoardVO vo = boardService.getBoardContent(boardIdx);
		if(vo.getContent().indexOf("src=\"/") != -1)	boardService.imgDelete(vo.getContent());
		
		// DB에서 실제 게시글을 삭제처리한다.
		boardService.setBoardDelete(boardIdx);
		return "";
	}
	
	// 선택한 게시글들 삭제 (admin)
	@ResponseBody
	@RequestMapping(value="/deleteBoardList" , method = RequestMethod.POST)
	public String deleteBoardListPost(String idxArr) {
		String[] idx = idxArr.split("/");
		
		// 게시글에 사진이 있다면 서버에서 사진삭제
		List<BoardVO> vos = boardService.getBoardContentList(idx);
		
		for(BoardVO vo : vos) {
			if(vo.getContent().indexOf("src=\"/") != -1)	boardService.imgDelete(vo.getContent());
			// DB에서 실제 게시글을 삭제처리한다.
			boardService.setBoardDelete(vo.getIdx());
		}
		
		boardService.deleteBoardList(idx);
		return "";
	}
	
	// 데이터 시각화(구글차트)
	@RequestMapping(value="/chart")
	public String chartGet(Model model) {
		//카테고리별 판매량
		List<SalesVO> sales = adminService.getSalesList();
		
		String strSales ="[";
		strSales +="['카테고리' , '판매량'] ,";
		int num =0;
		for(SalesVO vo : sales){
			strSales +="['";
			strSales += vo.getMainCategory();
			strSales +="' , ";
			strSales += vo.getSales();
			strSales +=" ]";
			
			num ++;
			
			if(num<sales.size()){
				strSales +=",";
			}		
		}
		strSales += "]";
		
		// 상품별 판매량
		List<SalesVO> salesPrice = adminService.getSalesPrice();
		
		String strSalesPrice ="[";
		strSalesPrice +="['제품 이름' , '판매 금액'] ,";
		num =0;
		for(SalesVO vo : salesPrice){
			strSalesPrice +="['";
			strSalesPrice += vo.getProductName();
			strSalesPrice +="' , ";
			strSalesPrice += vo.getTotalPrice();
			strSalesPrice +=" ]";
			
			num ++;
			
			if(num<salesPrice.size()){
				strSalesPrice +=",";
			}		
		}
		strSalesPrice += "]";
		
		// 월별 매출금액
		List<SalesVO> salesDate = adminService.getSalesDate();
		
		String strSalesDate = "[";
		strSalesDate += "['날짜' , '판매 금액'] ,";
		num =0;
		for(SalesVO vo : salesDate){
			strSalesDate +="['";
			strSalesDate += vo.getDate();
			strSalesDate +="' , ";
			strSalesDate += vo.getTotalPrice();
			strSalesDate +=" ]";
			
			num ++;
			
			if(num<salesDate.size()){
				strSalesDate +=",";
			}		
		}
		strSalesDate += "]";
		
		model.addAttribute("strSales", strSales);
		model.addAttribute("strSalesPrice", strSalesPrice);
		model.addAttribute("strSalesDate", strSalesDate);
		
		return "admin/sales/chart";
	}
	
	@RequestMapping(value="/productUpdate")
	public String productUpdateGet(Model model,int idx) {
		// 상품정보 가져오기
		ProductVO vo = productService.getProduct(idx);
		String categoryMain = vo.getProductCode().substring(0,1);
		String categoryMiddle = vo.getProductCode().substring(1, 3);
		
		List<CategoryVO> categoryMainVos = productService.getCategoryMains(); 
		List<CategoryVO> categoryMiddleVos = productService.getCategoryMiddleList(categoryMain); 
		
		// 원본 이미지를 ckeditor폴더로 복사해놓는다. 단지 안전성을 위해서. 혹시나 실수해서 수정전 사진을 가져와야 할지도 모르니깐
		productService.imgCheckUpdate(vo);
		
		model.addAttribute("vo", vo);
		model.addAttribute("categoryMainVos", categoryMainVos);
		model.addAttribute("categoryMiddleVos", categoryMiddleVos);
		model.addAttribute("categoryMain", categoryMain);
		model.addAttribute("categoryMiddle", categoryMiddle);
		
		return "admin/product/productUpdate";
	}
	
	@SuppressWarnings("unlikely-arg-type")
	@RequestMapping(value="/productUpdate", method = RequestMethod.POST)
	public String productUpdatePost(MultipartFile file, ProductVO vo) {
		
		String fname = file.getOriginalFilename();
		System.out.println("productUpdatePost");
		
		if(fname == "") { // 썸네일 변경 없을시 (fName, fsName 업데이트 x)
			productService.imgDelete(vo.getOriContent()); //원본 폴더에서 썸네일은 변경사항 없고 content 이미지는 삭제.
			// 에러가 중간에 떠버리면 완전 망치는 것이므로 그때그때 데이터를 변경해주자!
			vo.setContent(vo.getContent().replace("/data/shop/product/", "/data/shop/"));
			// 이미지파일 업로드했을경우 경로폴더를 /data/shop 에서 /data/shop/product 로 옮기기(상품 등록과 동일한 작업)
			System.out.println("2-1.vo.content : " + vo.getContent());
			productService.imgCheckProductInput(vo,"update");
		}
		else { // 썸네일을 새로 올렸으면
			productService.imgDelete(vo.getFSName(), vo.getOriContent()); //원래 저장되어있던 썸네일과 content 이미지는 삭제.
			vo.setContent(vo.getContent().replace("/data/shop/product/", "/data/shop/"));
			System.out.println("2-2.vo.content : " + vo.getContent());
			productService.imgCheckProductInput(file,vo,"update");
		}
		
		System.out.println("3.vo.content : " + vo.getContent());
		
		System.out.println("vo : " + vo);
		productService.setProductUpdate(vo,fname);
		
		msgFlag = "productUpdateOK";
		
		return "redirect:/msg/"+msgFlag;
		//return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/adMemberDelete")
	public String adMemberDeletePost(String idx) {
		memberService.deleteMember(idx);
		
		return "";
	}
	
}
