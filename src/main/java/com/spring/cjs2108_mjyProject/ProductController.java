package com.spring.cjs2108_mjyProject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_mjyProject.service.MemberService;
import com.spring.cjs2108_mjyProject.service.ProductService;
import com.spring.cjs2108_mjyProject.vo.BaesongVO;
import com.spring.cjs2108_mjyProject.vo.CartListVO;
import com.spring.cjs2108_mjyProject.vo.CategoryVO;
import com.spring.cjs2108_mjyProject.vo.MemberVO;
import com.spring.cjs2108_mjyProject.vo.OrderVO;
import com.spring.cjs2108_mjyProject.vo.ProductOptionVO;
import com.spring.cjs2108_mjyProject.vo.ProductVO;
import com.spring.cjs2108_mjyProject.vo.ReviewVO;

@Controller
@RequestMapping("/product")
public class ProductController {
	String msgFlag = "";
	
	@Autowired
	ProductService productService;
	
	@Autowired
	MemberService memberService;
	
	// 모든 카테고리 출력(카테고리 입력페이지 호출)
	@RequestMapping(value="/categoryInput")
	public String categoryInputGet(Model model) {
		List<CategoryVO> mainVos = productService.getCategoryMains();
		List<CategoryVO> middleVos = productService.getCategoryMiddles();
		
		model.addAttribute("mainVos", mainVos);
		model.addAttribute("middleVos", middleVos);
		
		return "admin/product/categoryInput";
	}
	
	// 대분류 등록
	@ResponseBody
	@RequestMapping(value="/categoryMainInput", method = RequestMethod.POST)
	public String categoryMainInputPost(String categoryMainCode, String categoryMainName) {
		String data = "";
		String code = categoryMainCode;
		String name = categoryMainName;
		CategoryVO vo = productService.getCategoryMain(code);
		
		if(vo != null) data = "0";
		else if(code.length() != 1 && Pattern.matches("^[A-Z]*$", code)) data = "1";
		else {
			productService.setCategoryMain(code, name);
		}
		
		return data;
	}
	
	// 중분류 등록
	@ResponseBody
	@RequestMapping(value="/categoryMiddleInput", method = RequestMethod.POST)
	public String categoryMiddleInputPost(String categoryMainCode, String categoryMiddleCode, String categoryMiddleName) {
		
		String data = "";

		CategoryVO vo = productService.getCategoryMiddle(categoryMiddleCode);
		
		if(vo != null) data = "0";
		else {
			productService.setCategoryMiddle(categoryMainCode, categoryMiddleCode, categoryMiddleName);
		}
		
		return data;
	}
	
	// 대분류 삭제
	@ResponseBody
	@RequestMapping(value = "/delCategoryMain", method = RequestMethod.POST)
	public String delCategoryMainPost(String categoryMainCode) {
		String data = "";
		
		List<CategoryVO> vos = productService.getCategoryMiddleName(categoryMainCode); // 하위 카테고리가 있는 대분류인지 확인
		
		
		if(vos.isEmpty()) productService.delCategoryMain(categoryMainCode);
		else {
			data = "0";
		}
		
		return data;
	}
	
	// 중분류 삭제
	@ResponseBody
	@RequestMapping(value = "/delCategoryMiddle", method = RequestMethod.POST)
	public String delCategoryMiddlePost(String categoryMiddleCode) {
		productService.delCategoryMiddle(categoryMiddleCode);
		return "";
	}
	
	
	//대분류 선택시 중분류명 가져오기
	@ResponseBody
	@RequestMapping(value="/getCategoryMiddleName", method = RequestMethod.POST)
	public List<CategoryVO> getCategoryMiddleNamePost(String categoryMainCode){
		return productService.getCategoryMiddleName(categoryMainCode);
	}
	
	// 상품등록페이지
	@RequestMapping(value="/productInput")
	public String productInputGet(Model model) {
		List<CategoryVO> mainVos = productService.getCategoryMains();
		model.addAttribute("mainVos", mainVos);
		return "admin/product/productInput";
	}
	
	// ckeditor에서 이미지를 올린다면 서버 파일 시스템에 저장시킨다.
	@ResponseBody
	@RequestMapping(value="/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception{
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		byte[] bytes = upload.getBytes();
		// ckeditor에서 올린 파일을 서버 파일 시스템에 저장시킨다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);     // 서버에 업로드시킨 그림파일이 저장된다. (기본 경로)
		
		// 서버 파일시스템에 저장된 파일을 화면(textarea)에 출력하기
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/shop/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\", \"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
	
	// 상품 등록시키기
	@RequestMapping(value="/productInput", method = RequestMethod.POST)
	public String productInputPost(MultipartFile file, ProductVO vo) {
		
		// 이미지파일 업로드했을경우 경로폴더를 /data/shop 에서 /data/shop/product로 옮긴다. 착각말것 : file은 애초에 업로드를 product로 했음 이동은 ck만
		productService.imgCheckProductInput(file,vo,"insert");
		msgFlag = "productInputOk";
		return "redirect:/msg/"+msgFlag;
	}
	
	// 상품 옵션추가 페이지(get)
	@RequestMapping(value="/productOption")
	public String productOptionGet(Model model) {
		List<ProductVO> vos = productService.getProductName();
		model.addAttribute("vos", vos);
		return "admin/product/productOption";
	}
	
	// 상품 선택시 상품 정보 가져오기
	@ResponseBody
	@RequestMapping(value="/getProductInfor", method = RequestMethod.POST)
	public ProductVO getProductInforPost(String productName, String categoryMainCode, String categoryMiddleCode){
		ProductVO vo = productService.getProductInfor(productName,categoryMainCode,categoryMiddleCode);
		
		return vo;
	}
	
	// 컬러 조회하기
	@ResponseBody
	@RequestMapping(value="/getColor", method = RequestMethod.POST)
	public List<ProductOptionVO> getColorPost(String productIdx) {
		int idx = Integer.parseInt(productIdx);
		return productService.getColor(idx);
	}
	
	// 컬러 삭제하기
	@ResponseBody
	@RequestMapping(value="/delColor", method = RequestMethod.POST)
	public String delColorPost(String idx) {
		int colorIdx = Integer.parseInt(idx);
		productService.delColor(colorIdx);
		return "";
	}
	
	// 컬러만 등록하기
	@ResponseBody
	@RequestMapping(value="/colorInput", method = RequestMethod.POST)
	public String colorOptionPost(ProductOptionVO vo) {
		String data = "";
		
		List<ProductOptionVO> vos =	productService.getColor(vo.getProductIdx());
		if(!vos.isEmpty()) {     // List 형식은 무조건 isEmpty로 NULL 판단!!
			for(ProductOptionVO poVo : vos) {
				if(poVo.getColorName().equals(vo.getColorName())) {
					data = "1"; // 이미 있는 이름이다.
					return data;
				}
			}
			data = "0" ; // 성공적으로 등록되었다.
			productService.setColor(vo);
		}
		else {	// 상품에 대해 첨으로 넣는 컬러다.
			data = "0" ; // 성공적으로 등록되었다.
			productService.setColor(vo);
		}
		return data;
	}
	
	// 사이즈만 옵션 등록하기
	@ResponseBody
	@RequestMapping(value="/sizeInput", method = RequestMethod.POST)
	public String sizeInputPost(ProductOptionVO vo) {
		String data = "";
		List<ProductOptionVO> vos =	productService.getSize(vo.getProductIdx(),vo.getColorIdx());
		
		if(!vos.isEmpty()) {
			for(ProductOptionVO poVo : vos) {
				if(poVo.getSizeName().equals(vo.getSizeName())) {
					data = "1"; // 이미 있는 이름이다.
					return data;
				}
			}
			data = "0" ; // 성공적으로 등록되었다.
			productService.setSize(vo);
		}
		else {    // 상품에 대해 처음으로 넣는 사이즈다.
			data = "0" ; // 성공적으로 등록되었다.
			productService.setSize(vo);
		}
		return data;
	}
	
	//사이즈값 조회해서 불러오기
	@ResponseBody
	@RequestMapping(value="/bringSize", method = RequestMethod.POST )
	public List<ProductOptionVO> bringSizePost(String productIdx, String colorIdx){
		int pIdx = Integer.parseInt(productIdx);
		int cIdx = Integer.parseInt(colorIdx);
		return productService.getSize(pIdx,cIdx);
	}
	
	// 사이즈 옵션 삭제하기
	@ResponseBody
	@RequestMapping(value="/delSize",method = RequestMethod.POST)
	public String delSizePost(String idx) {
		int sizeIdx = Integer.parseInt(idx);
		productService.delSize(sizeIdx);
		return "";
	}
	
	// 상품 리스트 출력하기 (part = 'A')
	@RequestMapping(value="/productList")
	public String productListGet(
			@RequestParam(name="main", defaultValue="전체", required=false) String main,
			@RequestParam(name="middle", defaultValue="전체", required=false) String middle,
			Model model
			) {
		String categoryMainName = "";
		List<ProductVO> vos = new ArrayList<ProductVO>();
		if(middle.equals("전체")) {
			vos = productService.getProductList(main);
		}
		else {
			vos = productService.getProductListMiddle(middle);
		}
		if(!vos.isEmpty()) categoryMainName = vos.get(0).getCategoryMainName();
		
		model.addAttribute("categoryMainName", categoryMainName);
		model.addAttribute("vos", vos);
		
		return "shop/productList";
	}
	
	// 검색창으로 상품 검색하기
	@RequestMapping(value="/keywordSearch")
	public String keywordSearchGet(String keyword, Model model) {
		List<ProductVO> vos = productService.productKeywordSearch(keyword);
		model.addAttribute("categoryMainName", keyword);
		model.addAttribute("vos", vos);
		return "shop/productList";
	}
	
	// 상품 상세보기
	@RequestMapping(value="/productContent")
	public String productContentGet(int idx, Model model) {
		ProductVO productVo = productService.getProduct(idx);
		List<ProductOptionVO> colorVos = productService.getColor(idx);
		List<ReviewVO> reVos = productService.getProductReview(idx); 
		
		model.addAttribute("productVo" , productVo);
		model.addAttribute("colorVos", colorVos);
		model.addAttribute("reVos", reVos);
		return "shop/productContent";
	}
	
	// 선택상품 장바구니로 보내기
	@RequestMapping(value="/productContent", method =RequestMethod.POST)
	public String productContentPost(CartListVO vo) {
	// 구매한 상품과 상품의 옵션 정보를 읽어온다. 
	//이때, 기존에 구매했었던 제품이 장바구니에 담겨있었다면 지금 상품을 기존 장바구니에 'update'시키고, 처음 구매한 장바구니이면 새로담긴 품목을 장바구니 테이블에 'insert'시켜준다.
		
		//System.out.println("vo : " + vo);    // option 잘 받는지 확인. myform에 없는데 잘 받넹 ... 
		
		CartListVO resVo = productService.cartListSearch(vo.getMid(), vo.getProductName());   //상품과 아이디가 같은 장바구니가 있으면 가져와.
		CartListVO newVo = null;
		
		if(resVo != null) {   // 기존에 넣어둔 장바구니가 있다면
			String voNames = vo.getOptionName();
			String voNums = vo.getOptionNum();
			String voPrices = vo.getOptionPrice();
			String resNames = resVo.getOptionName();
			String resNums = resVo.getOptionNum();
			String resPrices = resVo.getOptionPrice();
			
			String[] voOptionNames = voNames.split(",");
			String[] voOptionNums = voNums.split(","); // BLACK/S 옵션이 몇개인지 WHITE/M 이 몇개인지 등  (1,2,3)
			String[] voOptionPrices = voPrices.split(",");    // 옵션 별 가격
			String[] resOptionNames = resNames.split(",");
			String[] resOptionNums = resNums.split(","); 
			String[] resOptionPrices = resPrices.split(",");
			
			// 중복 옵션 합칠시 사용
			String exOptionNames = "";
			String exOptionNums = "";
			String exOptionPrices = "";
			int sw = 0;    // 중복 있으면 1, 없으면 0
			// 새로운 옵션 추가시 사용
			String newOptionNames = "";
			String newOptionNums = "";
			String newOptionPrices = "";
			
			// 중복 옵션은 수량 추가하고 없던 옵션은 추가.
			if(voOptionNames.length > resOptionNames.length) {     // 새로운 장바구니가 더 크므로 새로운 장바구니를 기준으로.
				newVo = vo;
				for(int i=0; i<resOptionNames.length; i++) {       // 기존 장바구니가 더 작으므로 바운드오류 안뜨려면 기존 장바구니 길이만큼 돌리는게 맞다.
					if(voNames.contains(resOptionNames[i])) { // 새로운 장바구니에 중복 옵션이 있으면  (sw = 1)
						sw = 1;
						
						for(int j=0; j<voOptionNames.length; j++) {          // 수량 추가
							if(voOptionNames[j].equals(resOptionNames[i])) {
								int tmp = Integer.parseInt(voOptionNums[j])  + Integer.parseInt(resOptionNums[i]);  
								String tmp2 = String.valueOf(tmp);
								voOptionNums[j] = tmp2;
							}
						}
					}
					else {           // 없던 옵션들 추가.
						newOptionNames = newOptionNames + "," + resOptionNames[i];
						newOptionNums = newOptionNums + "," + resOptionNums[i];
						newOptionPrices = newOptionPrices + "," + resOptionPrices[i];
					}
				}
				for(int j=0; j<voOptionNames.length; j++) {   // 중복됐던 옵션들은 모두 합쳐서 나중에 편하게 문자열로 만든다.
					exOptionNames = exOptionNames + ","+ voOptionNames[j];
					exOptionNums = exOptionNums + "," + voOptionNums[j];
					exOptionPrices = exOptionPrices + "," + voOptionPrices[j];
				}
			}
			else {       // 기존 장바구니가 더 크므로 기존 장바구니를 기준으로 삼는다. -> 추가장바구니걸로 바꿔줘야 할것들 : totalPrice, cartDate
				newVo = resVo;
				newVo.setTotalPrice(vo.getTotalPrice());
				for(int i=0; i<voOptionNames.length; i++) {
					if(resNames.contains(voOptionNames[i])) { // 추가 장바구니의 옵션이 기존에도 있으면
						sw = 1;
						
						for(int j=0; j<resOptionNames.length; j++) {          // 수량 추가
							if(resOptionNames[j].equals(voOptionNames[i])) {
								int tmp = Integer.parseInt(voOptionNums[i])  + Integer.parseInt(resOptionNums[j]);  
								String tmp2 = String.valueOf(tmp);
								resOptionNums[j] = tmp2;
							}
						}
					}
					else {           // 없던 옵션들 추가.
						newOptionNames = newOptionNames + "," + voOptionNames[i];
						newOptionNums = newOptionNums + "," + voOptionNums[i];
						newOptionPrices = newOptionPrices + "," + voOptionPrices[i];
					}
				}
				for(int j=0; j<resOptionNames.length; j++) {   // 중복됐던 옵션들은 모두 합쳐서 배열을 문자열로 돌린다.
					exOptionNames = exOptionNames + ","+ resOptionNames[j];
					exOptionNums = exOptionNums + "," + resOptionNums[j];
					exOptionPrices = exOptionPrices + "," + resOptionPrices[j];
				}
			}
			// ,black/s,asd     이러면 내가 원하는건 첫번쨰 ,만 빼버리는거..
			if(sw == 0) {   // 중복 없으면 기존 + 없던 옵션들 추가
				newOptionNames = newVo.getOptionName() + newOptionNames;
				newOptionNums = newVo.getOptionNum() + newOptionNums;
				newOptionPrices = newVo.getOptionPrice() + newOptionPrices;
			}
			else { // 중복 있으면 수량 고친 exOption들 + 없던 옵션 추가
				newOptionNames = exOptionNames.substring(1) + newOptionNames; 
				newOptionNums = exOptionNums.substring(1) + newOptionNums; 
				newOptionPrices = exOptionPrices.substring(1) + newOptionPrices;
			}
		// 장바구니 업데이트 
			newVo.setOptionName(newOptionNames);
			newVo.setOptionNum(newOptionNums);       
			newVo.setOptionPrice(newOptionPrices);
			productService.cartUpdate(newVo);   // DB 저장 
		}
			
		else {   // 기존 장바구니 없으면 그대로 저장
			productService.setCartList(vo);
		}
		
		msgFlag = "cartInputOK";
		return "redirect:/msg/" + msgFlag;
	}
	
	// 선택 상품 바로 주문하기
	@RequestMapping(value="/orderPage" , method = RequestMethod.POST)
	public String productOrderPost(HttpSession session, String mid, OrderVO orderVo, Model model) {
		int orderTotalPrice = 0;
		List<OrderVO> orderVos = new ArrayList<OrderVO>();
		orderVos.add(orderVo);
		
		// 장바구니안가고 바로 주문페이지로 가므로 배송비를 따로 계산해서 추가해준다.
		if(orderVo.getTotalPrice() < 50000) {
			orderTotalPrice = orderVo.getTotalPrice() + 2500;
		}
		else {
			orderTotalPrice = orderVo.getTotalPrice();
		}
		
		// 주문고유번호(idx) 만들기(기존 DB의 고유번호(idx) 최대값 보다 +1 시켜서 만든다) 
		OrderVO maxIdx = productService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx()+1;
		
		//System.out.println(idx);
		
		// 주문번호(orderIdx) 만들기  날짜_idx
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) +"_"+ idx;
		MemberVO memberVo = memberService.getIdCheck(mid);
		
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("orderIdx", orderIdx);
		model.addAttribute("orderTotalPrice", orderTotalPrice);
		session.setAttribute("orderVos", orderVos); // 세션에 넣어주면 작업이 편리
		
		return "shop/orderPage";
//		return "redirect:/product/orderPage";
	}
	
	// 장바구니 리스트 페이지
	@RequestMapping(value= "/cartList", method = RequestMethod.GET)
	public String cartListGet(HttpSession session, Model model, CartListVO vo) {
		String mid = (String) session.getAttribute("sMid");
		List<CartListVO> cartListVos = productService.getCartList(mid);
		model.addAttribute("cartListVos" , cartListVos);
		return "member/mypage/cartList";
	}
	
	// 장바구니 삭제하기
	@ResponseBody
	@RequestMapping(value="/cartDel", method = RequestMethod.POST)
	public String cartDelPost(String idx) {
		int cartIdx = Integer.parseInt(idx);
		productService.delCart(cartIdx);
		return "";
	}
	
	// 선택한 장바구니 전부 삭제하기
	@ResponseBody
	@RequestMapping(value="/deleteCartList", method = RequestMethod.POST)
	public String deleteCartListPost(String idxArr) {
		String[] idx = idxArr.split("/");
		productService.deleteCartList(idx);
		return "";
	}
	
	
	
	// 장바구니 리스트에서 주문하기로
	@RequestMapping(value="/cartList", method = RequestMethod.POST)
	public String cartListPost(String mid, int orderTotalPrice, OrderVO vo, Model model, HttpServletRequest request, HttpSession session) {
		String[] idxChecked = request.getParameterValues("idxChecked");
		CartListVO cartVo = new CartListVO();
		List<OrderVO> orderVos = new ArrayList<OrderVO>();
		
		for(String idx : idxChecked) { // 체크한만큼 카트 담자
			OrderVO orderVo = new OrderVO();
			cartVo = productService.getCartIdx(idx);
			orderVo.setProductIdx(cartVo.getProductIdx());
			orderVo.setProductName(cartVo.getProductName());
			orderVo.setMainPrice(cartVo.getMainPrice());
			orderVo.setThumbImg(cartVo.getThumbImg());
			orderVo.setOptionName(cartVo.getOptionName());
			orderVo.setOptionNum(cartVo.getOptionNum());
			orderVo.setOptionPrice(cartVo.getOptionPrice());
			orderVo.setTotalPrice(cartVo.getTotalPrice());
			orderVo.setCartIdx(cartVo.getIdx());      // 주문이 들어가면 장바구니에서는 없앤다. 
			orderVo.setMid(mid);
		
			orderVos.add(orderVo);
		}
		
		session.setAttribute("orderVos", orderVos); // 주문에서 보여준후 다시 그대로를 담아서 결제창으로 보내기에 session처리했다.
		MemberVO memberVo = memberService.getIdCheck(mid); // 주문자 인적사항
		
		// 주문고유번호(idx) 만들기(기존 DB의 고유번호(idx) 최대값 보다 +1 시켜서 만든다) 
		OrderVO maxIdx = productService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx()+1;
		
		//System.out.println(idx);
		
		// 주문번호(orderIdx) 만들기  날짜_idx
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) +"_"+ idx;
		
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("orderIdx", orderIdx);
		model.addAttribute("orderTotalPrice", orderTotalPrice);
		
		return "shop/orderPage";
	}
	
	// 주문내용 저장하기
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/orderInput", method = RequestMethod.POST)
	public String orderInputPost(HttpSession session, OrderVO orderVo, BaesongVO baesongVo, String usingPoint) {
		
		List<OrderVO> orderVos = (List<OrderVO>) session.getAttribute("orderVos");
		for(OrderVO vo : orderVos) {
			vo.setIdx(Integer.parseInt(baesongVo.getOrderIdx().substring(9))); // 주문테이블에 고유번호를 셋팅한다. 이렇게한다면 나중에 데이터가 지워져도 idx간의 간격이 1차이라는거 말고는 굳이..?
			vo.setOrderIdx(baesongVo.getOrderIdx());
			
			productService.setOrder(vo);                  // 주문내용 저장
			productService.delCart(vo.getCartIdx());  // 주문이 완료되면 카트삭제
		}
		baesongVo.setOIdx(productService.getOrderIdx(baesongVo.getOrderIdx()));     // 이제막 만들어진 주문데이터(장바구니)중 idx가 큰거 가져오기
		
		productService.setBaesong(baesongVo);    //배송테이블 저장
		
		// 사용한 포인트 및 적립된 포인트 적용
		int point = (int)(baesongVo.getOrderTotalPrice()*0.01) - Integer.parseInt(usingPoint);
		memberService.setPointUpdate(point, baesongVo.getMid());
		
		msgFlag = "orderInputOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	//주문 확인하기
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/orderConfirm")
	public String orderConfirmGet(HttpSession session, Model model) {
		List<OrderVO> orderVos = (List<OrderVO>) session.getAttribute("orderVos");
		List<BaesongVO> baesongVos = productService.getBaesong(orderVos.get(0).getMid()); // 첫번째 장바구니 vo 의 mid.. 씬박하네
		
		model.addAttribute("orderVos", orderVos);
		model.addAttribute("baesongVos", baesongVos.get(0));   // 왜 첫번째거만 가져가지? 애초에 왜 mid로 가져오지? 테스트해보고 orderIdx로 가져오자
		session.removeAttribute("orderVos");    //테스트 다하면 코드 살리기.
		
		return "shop/orderConfirm";
	}
	
	// 배송지조회
	@RequestMapping(value="/orderBaesong")
	public String orderBaesongGet(String orderIdx, Model model) {
		List<BaesongVO> vos = productService.getOrderBaesong(orderIdx);
		
		model.addAttribute("vo", vos.get(0)); //하나의 주문에는 같은 배송지니깐
		
		return "shop/orderBaesong";
	}
	
	
	// 주문내역 조회
	@SuppressWarnings("static-access")
	@RequestMapping(value="/purchaseHistory")
	public String purchaseHistoryGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue="1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required = false) int pageSize,
			@RequestParam(name="orderStatus", defaultValue="전체", required = false) String orderStatus,
			@RequestParam(name="conditionDate", defaultValue="0", required = false) int conditionDate,
			@RequestParam(name="startJumun", defaultValue="", required = false) String startJumun,
			@RequestParam(name="endJumun", defaultValue="", required = false) String endJumun
			) {
		System.out.println("일단 컨트롤러 이곳에 들어오는가");
		String mid = (String)session.getAttribute("sMid");
		int totRecCnt;
		int totPage;
		int startIndexNo;
		int curScrStrarNo;
		int blockSize;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
		int curBlock;		// 현재페이지의 블록위치
		int lastBlock;
		List<BaesongVO> orderVos = new ArrayList<BaesongVO>();
		
		// 조건없이 전체조회
		if(orderStatus.equals("전체") && conditionDate==0 && startJumun.equals("") && endJumun.equals("")) {   
			/* 페이징처리 변수지정 */
			totRecCnt = productService.totRecCnt(mid);
			totPage = (totRecCnt % pageSize) == 0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStrarNo = totRecCnt - startIndexNo;
			blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
			curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
			lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
			/* 블록페이징처리 끝 */
			
			orderVos = productService.getMyOrder(startIndexNo, pageSize, mid);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(cal.YEAR, -1);
			startJumun = sdf.format(cal.getTime());     // 시작날짜는 1년전으로
			
			Date today = new Date();
			String dd = sdf.format(today);
			endJumun = dd;             // 마지막날짜는 오늘로
			
		}
		
		// 날짜가지고 조회
		else if(conditionDate != 0) {
			orderStatus = "전체";  // 날짜로만 조회한다면 조건을 전체로 초기화해주자
			
			totRecCnt = productService.totRecCntOrderCondition(mid, conditionDate);
			totPage = (totRecCnt % pageSize) == 0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStrarNo = totRecCnt - startIndexNo;
			blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
			curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
			lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
			/* 블록페이징처리 끝 */
			orderVos = productService.orderCondition(startIndexNo, pageSize, mid, conditionDate);
			
		// 아래는 1일/일주일/6달/전체 조회시에 startJumun과 endJumun을 넘겨주는 부분(view에서 시작날짜와 끝날짜를 지정해서 출력시켜주기위해 startJumun과 endJumun값을 구해서 넘겨준다.)
			Calendar startDateJumun = Calendar.getInstance();
			Calendar endDateJumun = Calendar.getInstance();
			startDateJumun.setTime(new Date());  // 오늘날짜로 셋팅
			endDateJumun.setTime(new Date());    // 오늘날짜로 셋팅
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			startJumun = "";
			endJumun = "";
			
			switch (conditionDate) {
				case 1:
					startDateJumun.add(Calendar.DATE, -1);
					break;
				case 7:
					startDateJumun.add(Calendar.DATE, -7);
					break;
				case 30:
					startDateJumun.add(Calendar.MONTH, -1);
					break;
				case 180:
					startDateJumun.add(Calendar.MONTH, -6);
					break;
				case 99999:
					//startDateJumun.set(2021, 00, 01);
					startDateJumun.add(Calendar.YEAR, -1);
					break;
				default:
					startJumun = null;
					endJumun = null;
			}
			if(endJumun != null) {
				startJumun = sdf.format(startDateJumun.getTime());
				endJumun = sdf.format(endDateJumun.getTime());
			}
			
		}
		else {
			totRecCnt = productService.totRecCntDateConditionStatus(mid, startJumun, endJumun, orderStatus);
			totPage = (totRecCnt % pageSize) == 0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStrarNo = totRecCnt - startIndexNo;
			blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
			curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
			lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
			/* 블록페이징처리 끝 */
			orderVos = productService.orderDateConditionStatus(startIndexNo, pageSize, mid, startJumun, endJumun, orderStatus);
			
		}
		
	    model.addAttribute("orderVos", orderVos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("orderStatus", orderStatus);
		
		return "shop/purchaseHistory";
	}
	
	
	// 주문관리    나중에 시간되면 admincontroller로 이동
	@SuppressWarnings("static-access")
	@RequestMapping(value="/orderManagement")
	public String dbOrderProcessGet(Model model,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			@RequestParam(name="orderStatus", defaultValue="전체", required = false) String orderStatus,
			@RequestParam(name="startJumun", defaultValue="", required = false) String startJumun,
			@RequestParam(name="endJumun", defaultValue="", required = false) String endJumun
			) {
		
		int totRecCnt;
		int totPage;
		int startIndexNo;
		int curScrStrarNo;
		int blockSize;
		int curBlock;
		int lastBlock;
		List<BaesongVO> orderVos = new ArrayList<BaesongVO>();
		
		// 처음 불러올때의 상황 ( * 시작 날짜를 1년전으로 바꿀것.)
		if(orderStatus.equals("전체") && startJumun.equals("") && endJumun.equals("")) {
			/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
			totRecCnt = productService.totRecCntAdmin();
			totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStrarNo = totRecCnt - startIndexNo;
			blockSize = 3;
			curBlock = (pag - 1) / blockSize;
			lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
			/* 블록페이징처리 끝 */
			
			orderVos = productService.adminOrderList(startIndexNo, pageSize);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(cal.YEAR, -1);
			startJumun = sdf.format(cal.getTime());     // 시작날짜는 1년전으로
			
			Date today = new Date();
			String dd = sdf.format(today);
			endJumun = dd;             // 마지막날짜는 오늘로
			
		}
		
		// 조건이 있을시
		else {
			/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
			totRecCnt = productService.totRecCntAdminDateStatus(startJumun, endJumun, orderStatus);
			totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
			startIndexNo = (pag - 1) * pageSize;
			curScrStrarNo = totRecCnt - startIndexNo;
			blockSize = 3;
			curBlock = (pag - 1) / blockSize;
			lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
			/* 블록페이징처리 끝 */
			
			orderVos = productService.adminOrderListDateStatus(startIndexNo, pageSize, startJumun, endJumun, orderStatus);
			
		}
		
		model.addAttribute("orderVos", orderVos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("orderStatus", orderStatus);
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
			
		return "admin/product/orderManagement";
	}
	
	// 주문상태 변경
	@ResponseBody
	@RequestMapping(value="/orderStatusChange" , method = RequestMethod.POST)
	public String orderStatusChangePost(String orderIdx, String orderStatus) {
		productService.setOrderStatusUpdate(orderIdx, orderStatus);
		return "";
	}
	
	//상품삭제 페이지
	@RequestMapping(value="/productDelete")
	public String productDeleteGet(Model model) {
		List<ProductVO> vos = productService.getProductName();
		List<CategoryVO> mainVos = productService.getCategoryMains();
		
		model.addAttribute("vos", vos);
		model.addAttribute("mainVos", mainVos);
		return "admin/product/productDelete";
	}
	
	// 상품 삭제하기
	@ResponseBody
	@RequestMapping(value="/delProduct", method = RequestMethod.POST)
	public String delProductPost(int idx) {
		
		ProductVO vo = productService.getProduct(idx);
		productService.imgDelete(vo.getFSName(), vo.getContent());
		
		// db에서 삭제
		productService.delProduct(idx);
		
		msgFlag = "productDeleteOk";
		
		return "redirect:/msg/" + msgFlag;
	}
	
	//상품 삭제하기
	@ResponseBody
	@RequestMapping(value="/deleteProductList", method = RequestMethod.POST)
	public String deleteProductListPost(String idxArr) {
		String[] idx = idxArr.split("/");
		
		List<ProductVO> vos = productService.getProductListArr(idx);
		for(ProductVO vo : vos) {
			// 이미지 삭제작업
			productService.imgDelete(vo.getFSName(), vo.getContent());
			// db에서 삭제
			productService.delProduct(vo.getIdx());
		}
		
		msgFlag = "productDeleteOk";
		
		return "redirect:/msg/" + msgFlag;
	}
	
	// 대분류별 조회
	@RequestMapping(value="/categoryMainSearch")
	public String categoryMainSearchGet(Model model, String categoryMainCode) {
		List<ProductVO> vos = productService.getProductListMain(categoryMainCode);
		List<CategoryVO> mainVos = productService.getCategoryMains();
		List<CategoryVO> middleVos = productService.getCategoryMiddleList(categoryMainCode);
		
		//System.out.println("vo.getRating : " + vos.get(0).getRatingAvg());
		
		model.addAttribute("vos", vos);
		model.addAttribute("mainVos", mainVos);
		model.addAttribute("categoryMainCode", categoryMainCode);
		model.addAttribute("middleVos", middleVos);
		
		return "admin/product/productDelete";
	}
	
	// 대분류+중분류 선택하여 조회
	@RequestMapping(value="/categoryMiddleSearch")
	public String categoryMiddleSearchGet(Model model, String categoryMainCode ,String categoryMiddleCode) {
		
		List<ProductVO> vos = productService.getProductListMainMiddle(categoryMainCode,categoryMiddleCode);
		List<CategoryVO> mainVos = productService.getCategoryMains();
		List<CategoryVO> middleVos = productService.getCategoryMiddleList(categoryMainCode);
		
		model.addAttribute("vos", vos);
		model.addAttribute("mainVos", mainVos);
		model.addAttribute("middleVos", middleVos);
		model.addAttribute("categoryMainCode", categoryMainCode);
		model.addAttribute("categoryMiddleCode", categoryMiddleCode);
		return "admin/product/productDelete";
	}
	
	@RequestMapping(value="/productNameSearch")
	public String productNameSearchGet(Model model, String productName) {
		
		List<ProductVO> vos = productService.getProductListName(productName);
		List<CategoryVO> mainVos = productService.getCategoryMains();
		
		model.addAttribute("vos", vos);
		model.addAttribute("mainVos", mainVos);
		model.addAttribute("productName", productName);
		return "admin/product/productDelete";
	}
	
	// 추천상품관리
	@RequestMapping(value="/recoManagement")
	public String recoManagementGet(Model model) {
		List<ProductVO> vos = productService.getProductName();
		List<ProductVO> recoVos = new ArrayList<ProductVO>();
		List<ProductVO> reco = productService.getRecoProductList();
		for(ProductVO vo : reco) {
			int idx = vo.getProductIdx();
			recoVos.add(productService.getProduct(idx));
		}
		
		model.addAttribute("vos", vos);
		model.addAttribute("recoVos", recoVos);
		return "admin/product/recoManagement";
	}
	
	//추천상품 변경
	@ResponseBody
	@RequestMapping(value="/recoChange", method = RequestMethod.POST)
	public String recoChangePost(String idx) {
		// 추천상품의 자리가 가득 찼을때.
		int tot = productService.totRecCntReco();
		if(tot == 4) return "1";
		
		// 동일한 상품을 넣었을 때
		List<ProductVO> reco = productService.getRecoProductList();
		for(ProductVO vo : reco) {
			int productIdx = vo.getProductIdx();
			if(productIdx == Integer.parseInt(idx)) return "2";
		}
		
		productService.setRecoProduct(idx);
		return "0";
	}
	
	// 추천상품 삭제
	@ResponseBody
	@RequestMapping(value="/recoDelete", method = RequestMethod.POST)
	public String recoDeletePost(String idx) {
		productService.deleteReco(idx);
		return "";
	}
	
	// 구매후기 페이지
	@RequestMapping(value="/review")
	public String reviewGet(Model model, String orderIdx, String productIdx) {
		OrderVO vo = productService.getOrderProduct(orderIdx, productIdx);
		ReviewVO reVo = productService.getReviewToIdx(orderIdx,productIdx);
		model.addAttribute("vo", vo);
		model.addAttribute("reVo", reVo);

		
		return "member/mypage/review";
	}
	
	// 구매후기 저장하기 (Get방식으로 orderIdx랑 productIdx를 보내서 그런가 값이 남아있는데 중복되서 나오는 값이 있다.. 그래서 form에서 hidden빼버림)
	@ResponseBody
	@RequestMapping(value="/review" , method = RequestMethod.POST)
	public String reviewPost(ReviewVO vo) {
		productService.setReview(vo);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/reviewUpdate", method = RequestMethod.POST)
	public String reviewUpdatePost(ReviewVO vo) {
		productService.updateReview(vo);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/reviewDelete", method = RequestMethod.POST)
	public String reviewDeletePost(ReviewVO vo) {
		productService.deleteReview(vo);
		return "";
	}
	
	@RequestMapping(value="/productReview")
	public String productReviewGet(Model model,
			@RequestParam(name="productIdx", defaultValue="0", required=false) int productIdx,
			@RequestParam(name="nickName", defaultValue="전체", required = false) String nickName
			) {
		
		List<ReviewVO> reviewVos = new ArrayList<ReviewVO>();
		
		if(productIdx != 0) {
			reviewVos = productService.getReViewToProduct(productIdx);
		}
		else{
			reviewVos = productService.getAllReview(nickName);
		}
		
		List<ProductVO> productVos = productService.getProductName();
		
		model.addAttribute("reviewVos",reviewVos);
		model.addAttribute("productVos",productVos);
		model.addAttribute("productIdx", productIdx);
		model.addAttribute("nickName", nickName);
		
		return "admin/product/productReview";
	}
	
	@ResponseBody
	@RequestMapping(value="/delReview", method = RequestMethod.POST)
	public String delReviewPost(String idx) {
		productService.delReviewToAdmin(idx);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/delOrder" , method = RequestMethod.POST)
	public String delOrderPost(String productIdx, String orderIdx) {
		// productIdx는 int로 바꾸는게 정석이지만 string으로도 잘 검색되므로 그냥 string으로 간다.
		productService.delOrder(productIdx, orderIdx);
		return "";
	}
	
}
