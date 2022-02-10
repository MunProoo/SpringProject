package com.spring.cjs2108_mjyProject.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_mjyProject.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getIdCheck(@Param("mid") String mid);

	public MemberVO getNickNameCheck(@Param("nickName") String nickName);

	public int setMemInput(@Param("vo") MemberVO vo);

	public int setMemUpdate(@Param("vo") MemberVO vo);

	public ArrayList<MemberVO> getIdFind(@Param("email") String email);

	public MemberVO getPwdFind(@Param("mid") String mid , @Param("email") String email);

	public void setPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	public void setMemDelete(@Param("mid") String mid);

	public void setPointUpdate(@Param("point") int point ,@Param("mid") String mid);

	public void deleteMember(@Param("idx") String idx);


}
