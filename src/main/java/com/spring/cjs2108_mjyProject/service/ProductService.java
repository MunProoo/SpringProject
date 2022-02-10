package com.spring.cjs2108_mjyProject.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_mjyProject.vo.BaesongVO;
import com.spring.cjs2108_mjyProject.vo.CartListVO;
import com.spring.cjs2108_mjyProject.vo.CategoryVO;
import com.spring.cjs2108_mjyProject.vo.OrderVO;
import com.spring.cjs2108_mjyProject.vo.ProductOptionVO;
import com.spring.cjs2108_mjyProject.vo.ProductVO;
import com.spring.cjs2108_mjyProject.vo.ReviewVO;

public interface ProductService {

	public List<CategoryVO> getCategoryMains();

	public List<CategoryVO> getCategoryMiddles();

	public CategoryVO getCategoryMain(String categoryMainCode);

	public void setCategoryMain(String categoryMainCode, String categoryMainName);

	public CategoryVO getCategoryMiddle(String categoryCode);

	public void setCategoryMiddle(String categoryMainCode, String categoryMiddleCode, String categoryMiddleName);

	public void delCategoryMain(String categoryMainCode);

	public void delCategoryMiddle(String categoryMiddleCode);

	public List<CategoryVO> getCategoryMiddleName(String categoryMainCode);

	public void imgCheckProductInput(MultipartFile file, ProductVO vo, String flag);

	public List<ProductVO> getProductName();

	public ProductVO getProductInfor(String productName,String categoryMainCode, String categoryMiddleCode);

	public List<ProductVO> getProductListMain(String categoryMainCode);

	public ProductVO getProduct(int idx);

	public void imgDelete(String fsName, String content);

	public void delProduct(int idx);

	public CartListVO cartListSearch(String mid, String productName);

	public void cartUpdate(CartListVO vo);

	public void setCartList(CartListVO vo);

	public List<CartListVO> getCartList(String mid);

	public List<ProductOptionVO> getColor(int idx);

	public void setColor(ProductOptionVO vo);

	public void delColor(int colorIdx);

	public List<ProductOptionVO> getSize(int productIdx, int colorIdx);

	public void setSize(ProductOptionVO vo);

	public void delSize(int sizeIdx);

	public void delCart(int cartIdx);

	public CartListVO getCartIdx(String idx);

	public OrderVO getOrderMaxIdx();

	public void setOrder(OrderVO vo);

	public int getOrderIdx(String orderIdx);

	public void setBaesong(BaesongVO baesongVo);

	public List<BaesongVO> getBaesong(String mid);

	public List<BaesongVO> getOrderBaesong(String orderIdx);

	public int totRecCnt(String mid);

	public List<BaesongVO> getMyOrder(int startIndexNo, int pageSize, String mid);

	public int totRecCntOrderCondition(String mid, int conditionDate);

	public List<BaesongVO> orderCondition(int startIndexNo, int pageSize, String mid, int conditionDate);

	public int totRecCntDateConditionStatus(String mid, String startJumun, String endJumun, String orderStatus);

	public List<BaesongVO> orderDateConditionStatus(int startIndexNo, int pageSize, String mid, String startJumun, String endJumun,
			String orderStatus);

	public int totRecCntAdmin();

	public List<BaesongVO> adminOrderList(int startIndexNo, int pageSize);

	public int totRecCntAdminDateStatus(String startJumun, String endJumun, String orderStatus);

	public List<BaesongVO> adminOrderListDateStatus(int startIndexNo, int pageSize, String startJumun, String endJumun, String orderStatus);

	public void setOrderStatusUpdate(String orderIdx, String orderStatus);

	public void deleteCartList(String[] idx);

	public List<ProductVO> productKeywordSearch(String keyword);

	public List<ProductVO> getProductListArr(String[] idx);

	public List<ProductVO> getProductList(String part);

	public List<CategoryVO> getCategoryMiddleList(String categoryMainCode);

	public List<ProductVO> getProductListMainMiddle(String categoryMainCode, String categoryMiddleCode);

	public List<ProductVO> getProductListName(String productName);

	public List<ProductVO> getProductListMiddle(String middle);

	public void setRecoProduct(String idx);

	public int totRecCntReco();

	public List<ProductVO> getRecoProductList();

	public void deleteReco(String idx);

	public List<ProductVO> getNewProductList();

	public OrderVO getOrderProduct(String orderIdx, String productIdx);

	public void setReview(ReviewVO vo);

	public ReviewVO getReviewToIdx(String orderIdx, String productIdx);

	public void updateReview(ReviewVO vo);

	public void deleteReview(ReviewVO vo);

	public List<ReviewVO> getProductReview(int idx);

	public List<ReviewVO> getAllReview(String nickName);

	public void delReviewToAdmin(String idx);

	public List<ProductVO> getPopProductList();

	public List<ReviewVO> getReViewToProduct(int productIdx);

	public void imgCheckUpdate(ProductVO vo);

	public void setProductUpdate(ProductVO vo, String fname);

	public void imgDelete(String oriContent);

	public void imgCheckProductInput(ProductVO vo, String flag);

	public void delOrder(String productIdx, String orderIdx);




}
