package com.spring.cjs2108_mjyProject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_mjyProject.dao.InquiryDAO;
import com.spring.cjs2108_mjyProject.vo.InquiryVO;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Autowired
	InquiryDAO inquiryDAO;

	@Override
	public void setInquiry(InquiryVO vo) {
		inquiryDAO.setInquiry(vo);
	}

	@Override
	public List<InquiryVO> getInquiryList(String nickName) {
		return inquiryDAO.getInquiryList(nickName);
	}

	@Override
	public List<InquiryVO> getAllInquiryList(String reply) {
		return inquiryDAO.getAllInquiryList(reply);
	}
	@Override
	public void updateInquiryStatus(int inquiryIdx) {
		inquiryDAO.updateInquiryStatus(inquiryIdx);
	}
	@Override
	public void setInquiryAnswer(String ansContent, int inquiryIdx) {
		inquiryDAO.setInquiryAnswer(ansContent, inquiryIdx);
	}
	@Override
	public InquiryVO getAnswer(int inquiryIdx) {
		return inquiryDAO.getAnswer(inquiryIdx);
	}

	@Override
	public void deleteInquiry(String[] idx) {
		inquiryDAO.deleteInquiry(idx);
	}

	@Override
	public void deleteInquiryAns(String[] idx) {
		inquiryDAO.deleteInquiryAns(idx);
	}

	@Override
	public int getNewInquiry() {
		return inquiryDAO.getNewInquiry();
	}

	@Override
	public void inquiryContentUpdate(String idx, String content) {
		inquiryDAO.inquiryContentUpdate(idx, content);
	}

	@Override
	public void inquiryAnsUpdate(String inquiryIdx, String ansContent) {
		inquiryDAO.inquiryAnsUpdate(inquiryIdx, ansContent);
	}

	
	
}
