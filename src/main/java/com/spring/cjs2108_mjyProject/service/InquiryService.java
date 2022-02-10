package com.spring.cjs2108_mjyProject.service;

import java.util.List;

import com.spring.cjs2108_mjyProject.vo.InquiryVO;

public interface InquiryService {

	public void setInquiry(InquiryVO vo);

	public List<InquiryVO> getInquiryList(String nickName);

	public List<InquiryVO> getAllInquiryList(String reply);

	public void updateInquiryStatus(int inquiryIdx);

	public void setInquiryAnswer(String ansContent, int inquiryIdx);

	public InquiryVO getAnswer(int inquiryIdx);

	public void deleteInquiry(String[] idx);

	public void deleteInquiryAns(String[] idx);

	public int getNewInquiry();

	public void inquiryContentUpdate(String idx, String content);

	public void inquiryAnsUpdate(String inquiryIdx, String ansContent);

}
