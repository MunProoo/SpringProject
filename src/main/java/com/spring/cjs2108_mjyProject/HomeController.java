package com.spring.cjs2108_mjyProject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_mjyProject.service.ProductService;
import com.spring.cjs2108_mjyProject.vo.ProductVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@Autowired
	ProductService productService;
	
	@RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
	public String home(Model model) {
		
		// 추천상품
		List<ProductVO> recoVos = new ArrayList<ProductVO>();
		List<ProductVO> reco = productService.getRecoProductList(); // pIdx만 가져올것임
		for(ProductVO vo : reco) {
			int idx = vo.getProductIdx();
			recoVos.add(productService.getProduct(idx));
		}
		// 신규상품
		List<ProductVO> newVos = productService.getNewProductList();
		// 인기상품
		List<ProductVO> popularVos = new ArrayList<ProductVO>();
		List<ProductVO> pop = productService.getPopProductList();   // review에서 pIdx, rating 뽑음
		for(ProductVO vo : pop) {
			int productIdx = vo.getProductIdx();
			double ratingAvg = vo.getRatingAvg();
			
			ProductVO popVo = productService.getProduct(productIdx);
			popVo.setRatingAvg(ratingAvg);
			
			popularVos.add(popVo);
		}
		
		model.addAttribute("recoVos", recoVos);
		model.addAttribute("newVos", newVos);
		model.addAttribute("popularVos", popularVos);
		
		return "home"; // 그냥 views폴더 안의 파일이니까 "/"가 필요없이 그냥 home쓰면 되고,, 다른 폴더안에 있는거면 /폴더/파일.jsp로 가는게 맞다.
	}
	
	
	//게시판의 글 작성시, ckeditor에서 글올릴때 이미지와 함께 올린다면 이곳에서 서버 파일시스템에 저장시켜준다.
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		// ckeditor에서 올린 파일을 서버 파일시스템에 저장시켜준다.
		String filePath = File.separator + "resources" + File.separator + "data" + File.separator + "ckeditor" ;
		String uploadPath = request.getSession().getServletContext().getRealPath(filePath)+File.separator;
//		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);		// 서버에 업로드시킨 그림파일이 저장된다.
		
		// 서버 파일시스템에 저장된 파일을 화면(textarea)에 출력하기
		PrintWriter out = response.getWriter();
//		String fileUrl = request.getContextPath() + File.separator + "data" 
//				+ File.separator + "ckeditor" + File.separator + originalFilename;    // servlet-context.xml에서 data안해서 안됐었나? 그러네..
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + originalFilename;    // servlet-context.xml에서 data안해서 안됐었나? 그러네..
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");       /* "atom":"12.jpg","uploaded":1,"": */
		
		out.flush();
		outStr.close();
	}
	
	@RequestMapping(value="/introduction")
	public String introductionGet() {
		return "intro/introduction";
	}
	
	@RequestMapping(value="/map")
	public String mapGet() {
		return "intro/map";
	}
	
}
