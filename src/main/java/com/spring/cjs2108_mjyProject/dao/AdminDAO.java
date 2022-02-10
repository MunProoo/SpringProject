package com.spring.cjs2108_mjyProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_mjyProject.vo.MemberVO;
import com.spring.cjs2108_mjyProject.vo.SalesVO;

public interface AdminDAO {

	public int getNewMember();

	public int totRecCnt(@Param("level") int level);

	public int totRecCntMid(@Param("mid") String mid);

	public List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	public List<MemberVO> getMemberListMid(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public void setLevelUpdate(@Param("idx") int idx, @Param("level") int level);

	public MemberVO getMember(@Param("idx") int idx);

	public int getMembersCnt(@Param("flag") String flag);

	public int getProductCnt(@Param("flag") String flag);

	public int getSales();

	public List<SalesVO> getSalesList();

	public List<SalesVO> getSalesPrice();

	public List<SalesVO> getSalesDate();

	public List<MemberVO> getMemberListDel(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("userDel") String userDel);

}
