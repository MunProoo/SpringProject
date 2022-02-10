package com.spring.cjs2108_mjyProject.service;

import java.util.ArrayList;

import com.spring.cjs2108_mjyProject.vo.MemberVO;

// 메서드에 public 쓰기
public interface MemberService {

	public MemberVO getIdCheck(String mid);

	public MemberVO getNickNameCheck(String nickName);

	public int setMemInput(MemberVO vo);

	public int setMemUpdate(MemberVO vo);

	public ArrayList<MemberVO> getIdFind(String email);

	public MemberVO getPwdFind(String mid, String email);

	public void setPwdChange(String mid, String pwd);

	public void setMemDelete(String mid);

	public void setPointUpdate(int point, String mid);

	public void deleteMember(String idx);

}
