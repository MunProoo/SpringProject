package com.spring.cjs2108_mjyProject.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_mjyProject.dao.ProductDAO;
import com.spring.cjs2108_mjyProject.vo.BaesongVO;
import com.spring.cjs2108_mjyProject.vo.CartListVO;
import com.spring.cjs2108_mjyProject.vo.CategoryVO;
import com.spring.cjs2108_mjyProject.vo.OrderVO;
import com.spring.cjs2108_mjyProject.vo.ProductOptionVO;
import com.spring.cjs2108_mjyProject.vo.ProductVO;
import com.spring.cjs2108_mjyProject.vo.ReviewVO;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDAO productDAO;

	@Override
	public List<CategoryVO> getCategoryMains() {
		return productDAO.getCategoryMains();
	}

	@Override
	public List<CategoryVO> getCategoryMiddles() {
		return productDAO.getCategoryMiddles();
	}

	@Override
	public CategoryVO getCategoryMain(String categoryMainCode) {
		return productDAO.getCategoryMain(categoryMainCode);
	}

	@Override
	public void setCategoryMain(String categoryMainCode, String categoryMainName) {
		productDAO.setCategoryMain(categoryMainCode, categoryMainName);
	}

	@Override
	public CategoryVO getCategoryMiddle(String categoryCode) {
		return productDAO.getCategoryMiddle(categoryCode);
	}

	@Override
	public void setCategoryMiddle(String categoryMainCode, String categoryMiddleCode, String categoryMiddleName) {
		productDAO.setCategoryMiddle(categoryMainCode, categoryMiddleCode, categoryMiddleName);
	}

	@Override
	public void delCategoryMain(String categoryMainCode) {
		productDAO.delCategoryMain(categoryMainCode);
	}

	@Override
	public void delCategoryMiddle(String categoryMiddleCode) {
		productDAO.delCategoryMiddle(categoryMiddleCode);
	}

	@Override
	public List<CategoryVO> getCategoryMiddleName(String categoryMainCode) {
		return productDAO.getCategoryMiddleName(categoryMainCode);
	}
	
	// 이미지 경로 옮기고 상품등록하기
	@SuppressWarnings("deprecation")
	@Override
	public void imgCheckProductInput(MultipartFile file, ProductVO vo, String flag) {
		// 먼저 썸네일을 shop/product폴더에 저장한다.
		try {
			String originalFilename = file.getOriginalFilename();
			System.out.println("Thumbnail File Name : " + originalFilename);
			if(originalFilename != "" && originalFilename != null) {
				
				// 상품 썸네일 업로드 처리 (중복파일명 처리와 업로드처리)
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
				String saveFileName = sdf.format(date) + "_" + originalFilename;
				writeFile(file, saveFileName);     // 이미지를 서버에 업로드
				vo.setFName(originalFilename);     // 원래이름저장
				vo.setFSName(saveFileName);				 // 서버에 저장되는 파일명저장
			}
			else {
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 상품 상세설명 이미지가 기존과 일치하는지 or 바뀌었는지를 구분할 필요성이 있는데..?
		
		// ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 shop/product폴더로 복사작업처리 시켜준다.
		String content = vo.getContent();
		if(content.indexOf("src=\"/") != -1) {    // content에 그림이 없으면 return한다. (그림이 없으면 등록을 안하네?) 그림없어도 등록시키자
			
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");
			
			// 디버깅 <-> 배포 환경에서 경로가 달라지므로 ckeditor content로부터 이미지 이름 가져오는 로직 변경
			// 정규표현식 패턴
			Pattern pattern = Pattern.compile("src=\"/data/shop/([^\\s\"]+)\"");
			// Pattern pattern = Pattern.compile("src=\"/cjs2108_mjyProject/data/shop/([^\\s\"]+)\"");
			Matcher matcher = pattern.matcher(content);

			// 매칭된 파일명 출력
			while (matcher.find()) {
				String fileName = matcher.group(1);
				System.out.println("Copy) File Name: " + fileName);

				if(fileName.contains("product")) {
					// 기존에 등록된 파일이므로 수정X
					continue;
				}

				String copyFilePath = "";
				String oriFilePath = uploadPath + fileName;	// 원본 그림이 들어있는 '경로명+파일명'
				
				copyFilePath = uploadPath + "product/" + fileName;	// 복사가 될 '경로명+파일명'
				
				fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
				fileDelete(oriFilePath);   // 복사후 남아있는 원본은 삭제
			}

			/*
			int position = 35;
			String nextImg = content.substring(content.indexOf("src=\"/") + position);    // nexImg = 이름.jpg
			
			//System.out.println("nextImg : " + nextImg);
			
			boolean sw = true;
			
			while(sw) {
				String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
				
				//확인작업
				//System.out.println("imgFile : " + imgFile);
				
				String copyFilePath = "";
				String oriFilePath = uploadPath + imgFile;   //  현재 경로명+파일명
				
				copyFilePath = uploadPath + "product/" + imgFile;
				
				fileCopyCheck(oriFilePath, copyFilePath); // 파일의 원본위치를 복사될 위치로 이동해주는 메서드
				fileDelete(oriFilePath);   // 복사후 남아있는 원본은 삭제
				
				
				if(nextImg.indexOf("src=\"/") == -1) sw = false;       // 이미지가 더 없으면 처리종료.
				else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
			*/
		}
		
		// 이미지 복사작업이 종료되면 실제로 저장된 폴더명을 vo에 set
		vo.setContent(vo.getContent().replace("/data/shop/", "/data/shop/product/"));
		
		// 파일 복사작업이 모두 끝나면 vo에 담긴 내용을 db에 저장
		// productCode 만들어주기 (대분류코드+중분류코드 + 상품고유번호) -> 고유번호 : idx
		int maxIdx = 0;
		ProductVO maxVo = productDAO.getProductMaxIdx();
		if(maxVo != null) maxIdx = maxVo.getIdx();
		vo.setProductCode(vo.getCategoryMainCode()+vo.getCategoryMiddleCode()+maxIdx);
		
		if(flag.equals("insert")) productDAO.setProductInput(vo);
		
	}
	
	// 파일 삭제처리
	private void fileDelete(String oriFilePath) {
		File delFile = new File(oriFilePath);
		if(delFile.exists()) delFile.delete();
	}

	// 실제파일을 (data/shop) 에서 (data/shop/product)로 옮기기
	// 상품 썸네일 이미지 서버에 저장하기
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/product/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}
	
	// 이미지파일을 폴더로 copyFilePath로 복사처리하는 메서드
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oriFile);
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
	public List<ProductVO> getProductName() {
		return productDAO.getProductName();
	}

	@Override
	public ProductVO getProductInfor(String productName, String categoryMainCode, String categoryMiddleCode) {
		return productDAO.getProductInfor(productName,categoryMainCode,categoryMiddleCode);
	}

	@Override
	public List<ProductVO> getProductListMain(String categoryMainCode) {
		return productDAO.getProductListMain(categoryMainCode);
	}

	@Override
	public ProductVO getProduct(int idx) {
		return productDAO.getProduct(idx);
	}

	@SuppressWarnings("deprecation")
	@Override
	// 상품 삭제처리 위해 이미지 삭제
	public void imgDelete(String fsName, String content) {
		//	 					 0         1         2         3         4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_mjyProject/data/shop/220117183353_2.jpg"
		// <img alt="" src="/cjs2108_mjyProject/data/shop/product/220117183353_2.jpg"
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/shop/product/");
		
		// 썸네일 이미지 삭제
		System.out.println("Thumb Delete ) fsName : " + fsName);
		String thumbnailPath = uploadPath + fsName;

		System.out.println("Thumb Delete ) thumbnailPath : " + thumbnailPath);
		fileDelete(thumbnailPath);
		
		
		if(content.indexOf("src=\"/") == -1) return;
		
		// 디버깅 <-> 배포 환경에서 경로가 달라지므로 ckeditor content로부터 이미지 이름 가져오는 로직 변경
		// 정규표현식 패턴
		 Pattern pattern = Pattern.compile("src=\"/data/shop/product/([^\\s\"]+)\"");
//		Pattern pattern = Pattern.compile("src=\"/cjs2108_mjyProject/data/shop/product/([^\\s\"]+)\"");
		Matcher matcher = pattern.matcher(content);

		 // 매칭된 파일명 출력
        while (matcher.find()) {
            String fileName = matcher.group(1);
            System.out.println("Delete) File Name: " + fileName);

			String oriFilePath = uploadPath + fileName;	// 원본 그림이 들어있는 '경로명+파일명'
			
			fileDelete(oriFilePath);	// 원본그림을 삭제처리하는 메소드
        }
		/*
		// 컨텐츠에 들어간 이미지 삭제 (상품 상세내용)
		int position = 43;
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
	
	@SuppressWarnings("deprecation")
	@Override
	public void imgDelete(String content) {   // 수정할때 썸네일 냅둘경우.
		System.out.println("Product Img Delete(No Thumbnail) : ....");

		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/shop/product/");
		
		if(content.indexOf("src=\"/") == -1) return;
				
			// 컨텐츠에 들어간 이미지 삭제 (상품 상세내용)

			// 디버깅 <-> 배포 환경에서 경로가 달라지므로 ckeditor content로부터 이미지 이름 가져오는 로직 변경
			// 정규표현식 패턴
			Pattern pattern = Pattern.compile("src=\"/data/shop/product/([^\\s\"]+)\"");
			// Pattern pattern = Pattern.compile("src=\"/cjs2108_mjyProject/data/shop/product/([^\\s\"]+)\"");
			Matcher matcher = pattern.matcher(content);

			// 매칭된 파일명 출력
			while (matcher.find()) {
				String fileName = matcher.group(1);
				System.out.println("Delete) File Name: " + fileName);

				String oriFilePath = uploadPath + fileName;	// 원본 그림이 들어있는 '경로명+파일명'
				
				fileDelete(oriFilePath);	// 원본그림을 삭제처리하는 메소드
			}
			/*
			int position = 43;
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
	
	@Override
	public void delProduct(int idx) {
		productDAO.delProduct(idx);
	}

	@Override
	public CartListVO cartListSearch(String mid, String productName) {
		return productDAO.cartListSearch(mid, productName);
	}

	@Override
	public void cartUpdate(CartListVO vo) {
		productDAO.cartUpdate(vo);
	}

	@Override
	public void setCartList(CartListVO vo) {
		productDAO.setCartList(vo);
	}

	@Override
	public List<CartListVO> getCartList(String mid) {
		return productDAO.getCartList(mid);
	}

	@Override
	public List<ProductOptionVO> getColor(int idx) {
		return productDAO.getColor(idx);
	}

	@Override
	public void setColor(ProductOptionVO vo) {
		productDAO.setColor(vo);
	}

	@Override
	public void delColor(int colorIdx) {
		productDAO.delColor(colorIdx);
	}

	@Override
	public List<ProductOptionVO> getSize(int productIdx, int colorIdx) {
		return productDAO.getSize(productIdx, colorIdx);
	}

	@Override
	public void setSize(ProductOptionVO vo) {
		productDAO.setSize(vo);
	}

	@Override
	public void delSize(int sizeIdx) {
		productDAO.delSize(sizeIdx);
	}

	@Override
	public void delCart(int cartIdx) {
		productDAO.delCart(cartIdx);
	}

	@Override
	public CartListVO getCartIdx(String idx) {
		return productDAO.getCartIdx(idx);
	}

	@Override
	public OrderVO getOrderMaxIdx() {
		return productDAO.getOrderMaxIdx();
	}

	@Override
	public void setOrder(OrderVO vo) {
		productDAO.setOrder(vo);
	}

	@Override
	public int getOrderIdx(String orderIdx) {
		return productDAO.getOrderIdx(orderIdx);
	}

	@Override
	public void setBaesong(BaesongVO baesongVo) {
		productDAO.setBaesong(baesongVo);
	}

	@Override
	public List<BaesongVO> getBaesong(String mid) {
		return productDAO.getBaesong(mid);
	}

	@Override
	public List<BaesongVO> getOrderBaesong(String orderIdx) {
		return productDAO.getOrderBaesong(orderIdx);
	}

	@Override
	public int totRecCnt(String mid) {
		return productDAO.totRecCnt(mid);
	}

	@Override
	public List<BaesongVO> getMyOrder(int startIndexNo, int pageSize, String mid) {
		return productDAO.getMyOrder(startIndexNo, pageSize, mid);
	}

	@Override
	public int totRecCntOrderCondition(String mid, int conditionDate) {
		return productDAO.totRecCntOrderCondition(mid, conditionDate);
	}

	@Override
	public List<BaesongVO> orderCondition(int startIndexNo, int pageSize, String mid, int conditionDate) {
		return productDAO.orderCondition(startIndexNo, pageSize, mid, conditionDate);
	}

	@Override
	public int totRecCntDateConditionStatus(String mid, String startJumun, String endJumun, String dateOrderStatus) {
		return productDAO.totRecCntDateConditionStatus(mid, startJumun, endJumun, dateOrderStatus);
	}

	@Override
	public List<BaesongVO> orderDateConditionStatus(int startIndexNo, int pageSize, String mid, String startJumun, String endJumun, String orderStatus) {
		return productDAO.orderDateConditionStatus(startIndexNo, pageSize, mid, startJumun, endJumun, orderStatus);
	}

	@Override
	public int totRecCntAdmin() {
		return productDAO.totRecCntAdmin();
	}

	@Override
	public List<BaesongVO> adminOrderList(int startIndexNo, int pageSize) {
		return productDAO.adminOrderList(startIndexNo, pageSize);
	}

	@Override
	public int totRecCntAdminDateStatus(String startJumun, String endJumun, String orderStatus) {
		return productDAO.totRecCntAdminDateStatus(startJumun, endJumun, orderStatus);
	}

	@Override
	public List<BaesongVO> adminOrderListDateStatus(int startIndexNo, int pageSize, String startJumun, String endJumun, String orderStatus) {
		return productDAO.adminOrderListDateStatus(startIndexNo,pageSize, startJumun, endJumun, orderStatus);
	}

	@Override
	public void setOrderStatusUpdate(String orderIdx, String orderStatus) {
		productDAO.setOrderStatusUpdate(orderIdx, orderStatus);
	}

	@Override
	public void deleteCartList(String[] idx) {
		productDAO.deleteCartList(idx);
	}

	@Override
	public List<ProductVO> productKeywordSearch(String keyword) {
		return productDAO.productKeywordSearch(keyword);
	}

	@Override
	public List<ProductVO> getProductListArr(String[] idx) {
		return productDAO.getProductListArr(idx);
	}

	@Override
	public List<ProductVO> getProductList(String part) {
		return productDAO.getProductList(part);
	}

	@Override
	public List<CategoryVO> getCategoryMiddleList(String categoryMainCode) {
		return productDAO.getCategoryMiddleList(categoryMainCode);
	}

	@Override
	public List<ProductVO> getProductListMainMiddle(String categoryMainCode, String categoryMiddleCode) {
		return productDAO.getProductListMainMiddle(categoryMainCode, categoryMiddleCode);
	}

	@Override
	public List<ProductVO> getProductListName(String productName) {
		return productDAO.getProductListName(productName);
	}

	@Override
	public List<ProductVO> getProductListMiddle(String middle) {
		return productDAO.getProductListMiddle(middle);
	}

	@Override
	public void setRecoProduct(String idx) {
		productDAO.setRecoProduct(idx);
	}

	@Override
	public int totRecCntReco() {
		return productDAO.totRecCntReco();
	}

	@Override
	public List<ProductVO> getRecoProductList() {
		return productDAO.getRecoProductList();
	}

	@Override
	public void deleteReco(String idx) {
		productDAO.deleteReco(idx);
	}

	@Override
	public List<ProductVO> getNewProductList() {
		return productDAO.getNewProductList();
	}

	@Override
	public OrderVO getOrderProduct(String orderIdx, String productIdx) {
		return productDAO.getOrderProduct(orderIdx, productIdx) ;
	}

	@Override
	public void setReview(ReviewVO vo) {
		productDAO.setReview(vo);
	}

	@Override
	public ReviewVO getReviewToIdx(String orderIdx, String productIdx) {
		return productDAO.getReviewToIdx(orderIdx, productIdx);
	}

	@Override
	public void updateReview(ReviewVO vo) {
		productDAO.updateReview(vo);
	}

	@Override
	public void deleteReview(ReviewVO vo) {
		productDAO.deleteReview(vo);
	}

	@Override
	public List<ReviewVO> getProductReview(int idx) {
		return productDAO.getProductReview(idx);
	}

	@Override
	public List<ReviewVO> getAllReview(String nickName) {
		return productDAO.getAllReview(nickName);
	}

	@Override
	public void delReviewToAdmin(String idx) {
		productDAO.delReviewToAdmin(idx);
	}

	@Override
	public List<ProductVO> getPopProductList() {
		return productDAO.getPopProductList();
	}

	@Override
	public List<ReviewVO> getReViewToProduct(int productIdx) {
		return productDAO.getReViewToProduct(productIdx);
	}

	// 업데이트에 들어가게되면 혹시 모를 일에 대비해 원본 이미지들을 복사해놓는다 (임시파일)
	@SuppressWarnings("deprecation")
	@Override
	public void imgCheckUpdate(ProductVO vo) {
		//						 0         1         2       2 3   3     4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/cjs2108_mjyProject/data/shop/211229124318_4.jpg"
		// <img alt="" src="/cjs2108_mjyProject/data/shop/product/211229124318_4.jpg"
		
		String fsName = vo.getFSName(); 
		String content = vo.getContent();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getRealPath("/resources/data/shop/product/");
		// 썸네일 복사
		String oriFilePathThumb = uploadPath + fsName;	// 원본 그림이 들어있는 '경로명+파일명'
		String copyFilePathThumb = request.getRealPath("/resources/data/shop/") + fsName;	// 복사가 될 '경로명+파일명'
		fileCopyCheck(oriFilePathThumb, copyFilePathThumb);
		
		// 컨텐츠파일 복사
		if(content.indexOf("src=\"/") == -1) return;
		
		// 디버깅 <-> 배포 환경에서 경로가 달라지므로 ckeditor content로부터 이미지 이름 가져오는 로직 변경
		// 정규표현식 패턴
		Pattern pattern = Pattern.compile("src=\"/data/shop/product/([^\\s\"]+)\"");
		// Pattern pattern = Pattern.compile("src=\"/cjs2108_mjyProject/data/shop/product/([^\\s\"]+)\"");
		Matcher matcher = pattern.matcher(content);

		 // 매칭된 파일명 출력
        while (matcher.find()) {
            String fileName = matcher.group(1);
            System.out.println("Update) File Name: " + fileName);

			String oriFilePath = uploadPath + fileName;	// 원본 그림이 들어있는 '경로명+파일명'
			String copyFilePath = request.getRealPath("/resources/data/shop/")  + fileName;
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
        }

		/*
		int position = 43;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String oriFilePathContent = uploadPath + imgFile;
			String copyFilePathContent = request.getRealPath("/resources/data/shop/" + imgFile);
			
			fileCopyCheck(oriFilePathContent, copyFilePathContent);	// 원본그림을 복사될 위치로 복사작업처리하는 메소드
			
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
	public void setProductUpdate(ProductVO vo, String fname) {
		productDAO.setProductUpdate(vo,fname);
	}
	
	// 썸네일없이 content만 수정할 때 사용
	@Override
	public void imgCheckProductInput(ProductVO vo, String flag) {
		
			//   					 0         1         2         3         4         5
			//             012345678901234567890123456789012345678901234567890
			// <img alt="" src="/cjs2108_mjyProject/data/shop/211229124318_4.jpg"
			// <img alt="" src="/cjs2108_mjyProject/data/shop/product/211229124318_4.jpg"
			
			// ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 shop/product폴더로 복사작업처리 시켜준다.
			String content = vo.getContent();
			if(content.indexOf("src=\"/") != -1) {    // content에 그림이 없으면 return한다. (그림이 없으면 등록을 안하네?) 그림없어도 등록시키자
				
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/shop/");
				
				// 디버깅 <-> 배포 환경에서 경로가 달라지므로 ckeditor content로부터 이미지 이름 가져오는 로직 변경
				// 정규표현식 패턴
				Pattern pattern = Pattern.compile("src=\"/data/shop/([^\\s\"]+)\"");
				// Pattern pattern = Pattern.compile("src=\"/cjs2108_mjyProject/data/shop/([^\\s\"]+)\"");
				Matcher matcher = pattern.matcher(content);

				// 매칭된 파일명 출력
				while (matcher.find()) {
					String fileName = matcher.group(1);
					System.out.println("Update) File Name: " + fileName);

					if(fileName.contains("product")) {
						// 기존에 등록된 파일이므로 수정X
						continue;
					}

					String oriFilePath = uploadPath + fileName;	// 원본 그림이 들어있는 '경로명+파일명'
					String copyFilePath = uploadPath + "product/" + fileName;
					
					fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
					fileDelete(oriFilePath);   // 복사후 남아있는 원본은 삭제
				}
				/*
				int position = 35;
				String nextImg = content.substring(content.indexOf("src=\"/") + position);    // nexImg = 이름.jpg
				
				//System.out.println("nextImg : " + nextImg);
				
				boolean sw = true;
				
				while(sw) {
					String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
					
					//확인작업
					//System.out.println("imgFile : " + imgFile);
					
					String copyFilePath = "";
					String oriFilePath = uploadPath + imgFile;   //  현재 경로명+파일명
					
					copyFilePath = uploadPath + "product/" + imgFile;
					
					fileCopyCheck(oriFilePath, copyFilePath); // 파일의 원본위치를 복사될 위치로 이동해주는 메서드
					fileDelete(oriFilePath);   // 복사후 남아있는 원본은 삭제
					
					
					if(nextImg.indexOf("src=\"/") == -1) sw = false;       // 이미지가 더 없으면 처리종료.
					else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
				}
				*/
			}
			
			// 이미지 복사작업이 종료되면 실제로 저장된 폴더명을 vo에 set
			vo.setContent(vo.getContent().replace("/data/shop/", "/data/shop/product/"));
			
			// 파일 복사작업이 모두 끝나면 vo에 담긴 내용을 db에 저장
			// productCode 만들어주기 (대분류코드+중분류코드 + 상품고유번호) -> 고유번호 : idx
			int maxIdx = 0;
			ProductVO maxVo = productDAO.getProductMaxIdx();
			if(maxVo != null) maxIdx = maxVo.getIdx();
			vo.setProductCode(vo.getCategoryMainCode()+vo.getCategoryMiddleCode()+maxIdx);
			
			if(flag.equals("insert")) productDAO.setProductInput(vo);
	}

	@Override
	public void delOrder(String productIdx, String orderIdx) {
		productDAO.delOrder(productIdx, orderIdx);
	}


}
