package com.spring.cjs2108_mjyProject.service;

import java.util.List;

import com.spring.cjs2108_mjyProject.vo.MemberVO;
import com.spring.cjs2108_mjyProject.vo.SalesVO;

public interface AdminService {

	public int getNewMember();

	public int totRecCnt(int level);

	public int totRecCntMid(String mid);

	public List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);

	public List<MemberVO> getMemberListMid(int startIndexNo, int pageSize, String mid);

	public void setLevelUpdate(int idx, int level);

	public MemberVO getMember(int idx);

	public int imgDelete(String uploadPath, String flag);

	public int getMembersCnt(String flag);

	public int getProductCnt(String flag);

	public int getSales();

	public List<SalesVO> getSalesList();

	public List<SalesVO> getSalesPrice();

	public List<SalesVO> getSalesDate();

	public List<MemberVO> getMemberListDel(int startIndexNo, int pageSize, String userDel);

}
