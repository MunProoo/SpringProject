package com.spring.cjs2108_mjyProject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_mjyProject.vo.InquiryVO;

public interface InquiryDAO {

	public void setInquiry(@Param("vo") InquiryVO vo);

	public List<InquiryVO> getInquiryList(@Param("nickName") String nickName);

	public List<InquiryVO> getAllInquiryList(@Param("reply") String reply);

	public void updateInquiryStatus(@Param("inquiryIdx") int inquiryIdx);

	public void setInquiryAnswer(@Param("ansContent") String ansContent, @Param("inquiryIdx") int inquiryIdx);

	public InquiryVO getAnswer(@Param("inquiryIdx") int inquiryIdx);

	public void deleteInquiryAns(@Param("array") String[] idx);

	public void deleteInquiry(@Param("array") String[] idx);

	public int getNewInquiry();

	public void inquiryContentUpdate(@Param("idx") String idx, @Param("content") String content);

	public void inquiryAnsUpdate(@Param("inquiryIdx") String inquiryIdx, @Param("ansContent") String ansContent);

}
