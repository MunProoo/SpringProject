package com.spring.cjs2108_mjyProject.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_mjyProject.dao.AdminDAO;
import com.spring.cjs2108_mjyProject.vo.MemberVO;
import com.spring.cjs2108_mjyProject.vo.SalesVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public int getNewMember() {
		return adminDAO.getNewMember();
	}

	@Override
	public int totRecCnt(int level) {
		return adminDAO.totRecCnt(level);
	}

	@Override
	public int totRecCntMid(String mid) {
		return adminDAO.totRecCntMid(mid);
	}

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getMemberList(startIndexNo, pageSize, level);
	}

	@Override
	public List<MemberVO> getMemberListMid(int startIndexNo, int pageSize, String mid) {
		return adminDAO.getMemberListMid(startIndexNo, pageSize, mid);
	}

	@Override
	public void setLevelUpdate(int idx, int level) {
		adminDAO.setLevelUpdate(idx, level);
	}

	@Override
	public MemberVO getMember(int idx) {
		return adminDAO.getMember(idx);
	}

	@Override
	public int imgDelete(String uploadPath, String flag) {
		File path = new File(uploadPath);
		
		// 파일객체를 통해서 uploadPath 경로안의 모든 파일의 정보를 배열로 저장
		File[] fileList = path.listFiles();
		int fileCnt = fileList.length - 1;
		if(flag.equals("ckeditor")) fileCnt += -1; // 폴더까지 파일로 잡혀버리고 ckeditor에는 폴더가 2개니까 -1 한번 더 해준다.
		
		for(int i=0; i<fileCnt; i++) {
			fileList[i].delete();
		}
		
		return fileCnt;
	}

	@Override
	public int getMembersCnt(String flag) {
		return adminDAO.getMembersCnt(flag);
	}

	@Override
	public int getProductCnt(String flag) {
		return adminDAO.getProductCnt(flag);
	}

	@Override
	public int getSales() {
		return adminDAO.getSales();
	}

	@Override
	public List<SalesVO> getSalesList() {
		return adminDAO.getSalesList();
	}

	@Override
	public List<SalesVO> getSalesPrice() {
		return adminDAO.getSalesPrice();
	}

	@Override
	public List<SalesVO> getSalesDate() {
		return adminDAO.getSalesDate();
	}

	@Override
	public List<MemberVO> getMemberListDel(int startIndexNo, int pageSize, String userDel) {
		return adminDAO.getMemberListDel(startIndexNo, pageSize, userDel);
	}

}
