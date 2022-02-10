package com.spring.cjs2108_mjyProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_mjyProject.vo.BaesongVO;
import com.spring.cjs2108_mjyProject.vo.CartListVO;
import com.spring.cjs2108_mjyProject.vo.CategoryVO;
import com.spring.cjs2108_mjyProject.vo.OrderVO;
import com.spring.cjs2108_mjyProject.vo.ProductOptionVO;
import com.spring.cjs2108_mjyProject.vo.ProductVO;
import com.spring.cjs2108_mjyProject.vo.ReviewVO;

public interface ProductDAO {

	public List<CategoryVO> getCategoryMains();

	public List<CategoryVO> getCategoryMiddles();

	public CategoryVO getCategoryMain(@Param("categoryMainCode") String categoryMainCode);

	public void setCategoryMain(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMainName") String categoryMainName);

	public CategoryVO getCategoryMiddle(@Param("categoryMiddleCode") String categoryMiddleCode);

	public void setCategoryMiddle(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode, 
			@Param("categoryMiddleName") String categoryMiddleName);

	public void delCategoryMain(@Param("categoryMainCode") String categoryMainCode);

	public void delCategoryMiddle(@Param("categoryMiddleCode") String categoryMiddleCode);

	public List<CategoryVO> getCategoryMiddleName(@Param("categoryMainCode") String categoryMainCode);

	public ProductVO getProductMaxIdx();

	public void setProductInput(@Param("vo") ProductVO vo);

	public List<ProductVO> getProductName();

	public ProductVO getProductInfor(@Param("productName") String productName, @Param("categoryMainCode") String categoryMainCode,
			@Param("categoryMiddleCode") String categoryMiddleCode);

	public List<ProductVO> getProductListMain(@Param("categoryMainCode") String categoryMainCode);

	public ProductVO getProduct(@Param("idx") int idx);

	public void delProduct(@Param("idx") int idx);

	public CartListVO cartListSearch(@Param("mid") String mid, @Param("productName") String productName);

	public void cartUpdate(@Param("vo") CartListVO vo);

	public void setCartList(@Param("vo") CartListVO vo);

	public List<CartListVO> getCartList(@Param("mid") String mid);

	public List<ProductOptionVO> getColor(@Param("idx") int idx);

	public List<ProductOptionVO> getSize(@Param("productIdx") int productIdx, @Param("colorIdx") int colorIdx);
	
	public void setColor(@Param("vo") ProductOptionVO vo);

	public void delColor(@Param("colorIdx") int colorIdx);

	public void setSize(@Param("vo") ProductOptionVO vo);

	public void delSize(@Param("sizeIdx") int sizeIdx);

	public void delCart(@Param("idx") int cartIdx);

	public CartListVO getCartIdx(@Param("idx") String idx);

	public OrderVO getOrderMaxIdx();

	public void setOrder(@Param("vo") OrderVO vo);

	public int getOrderIdx(@Param("orderIdx") String orderIdx);

	public void setBaesong(@Param("vo") BaesongVO baesongVo);

	public List<BaesongVO> getBaesong(@Param("mid") String mid);

	public List<BaesongVO> getOrderBaesong(@Param("orderIdx") String orderIdx);

	public int totRecCnt(@Param("mid") String mid);

	public List<BaesongVO> getMyOrder(@Param("startIndexNo") int startIndexNo,@Param("pageSize") int pageSize,@Param("mid") String mid);

	public int totRecCntOrderCondition(@Param("mid") String mid, @Param("conditionDate") int conditionDate);

	public List<BaesongVO> orderCondition(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, 
																				@Param("mid") String mid, @Param("conditionDate") int conditionDate);

	public int totRecCntDateConditionStatus(@Param("mid") String mid, @Param("startJumun") String startJumun, 
																					@Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public List<BaesongVO> orderDateConditionStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize,
																								  @Param("mid") String mid, @Param("startJumun") String startJumun, 
																					        @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public int totRecCntAdmin();

	public List<BaesongVO> adminOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCntAdminDateStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public List<BaesongVO> adminOrderListDateStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, 
																									@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, 
																									@Param("orderStatus") String orderStatus);

	public void setOrderStatusUpdate(@Param("orderIdx") String orderIdx, @Param("orderStatus") String orderStatus);

	public void deleteCartList(@Param("array") String[] idx);

	public List<ProductVO> productKeywordSearch(@Param("keyword") String keyword);

	public List<ProductVO> getProductListArr(@Param("array") String[] idx);

	public List<ProductVO> getProductList(@Param("part") String part);

	public List<CategoryVO> getCategoryMiddleList(@Param("categoryMainCode") String categoryMainCode);

	public List<ProductVO> getProductListMainMiddle(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode);

	public List<ProductVO> getProductListName(@Param("productName") String productName);

	public List<ProductVO> getProductListMiddle(@Param("middle") String middle);

	public void setRecoProduct(@Param("idx") String idx);

	public int totRecCntReco();

	public List<ProductVO> getRecoProductList();

	public void deleteReco(@Param("idx") String idx);

	public List<ProductVO> getNewProductList();

	public OrderVO getOrderProduct(@Param("orderIdx") String orderIdx, @Param("productIdx") String productIdx);

	public void setReview(@Param("vo") ReviewVO vo);

	public ReviewVO getReviewToIdx(@Param("orderIdx") String orderIdx, @Param("productIdx") String productIdx);

	public void updateReview(@Param("vo") ReviewVO vo);

	public void deleteReview(@Param("vo") ReviewVO vo);

	public List<ReviewVO> getProductReview(@Param("idx") int idx);

	public List<ReviewVO> getAllReview(@Param("nickName") String nickName);

	public void delReviewToAdmin(@Param("idx") String idx);

	public List<ProductVO> getPopProductList();

	public List<ReviewVO> getReViewToProduct(@Param("productIdx") int productIdx);

	public void setProductUpdate(@Param("vo") ProductVO vo, @Param("fname") String fname);

	public void delOrder(@Param("productIdx") String productIdx, @Param("orderIdx") String orderIdx);

	


}
