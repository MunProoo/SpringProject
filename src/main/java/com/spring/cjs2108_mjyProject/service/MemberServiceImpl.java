package com.spring.cjs2108_mjyProject.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_mjyProject.dao.MemberDAO;
import com.spring.cjs2108_mjyProject.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getIdCheck(String mid) {
		return memberDAO.getIdCheck(mid);
	}

	@Override
	public MemberVO getNickNameCheck(String nickName) {
		return memberDAO.getNickNameCheck(nickName);
	}

	@Override
	public int setMemInput(MemberVO vo) {
		return memberDAO.setMemInput(vo);
	}

	@Override
	public int setMemUpdate(MemberVO vo) {
		return memberDAO.setMemUpdate(vo);
	}

	@Override
	public ArrayList<MemberVO> getIdFind(String email) {
		return memberDAO.getIdFind(email);
	}

	@Override
	public MemberVO getPwdFind(String mid, String email) {
		return memberDAO.getPwdFind(mid, email);
	}

	@Override
	public void setPwdChange(String mid, String pwd) {
		memberDAO.setPwdChange(mid, pwd);
	}

	@Override
	public void setMemDelete(String mid) {
		memberDAO.setMemDelete(mid);
	}

	@Override
	public void setPointUpdate(int point, String mid) {
		memberDAO.setPointUpdate(point, mid);
	}

	@Override
	public void deleteMember(String idx) {
		memberDAO.deleteMember(idx);
	}

	
	
	
}
