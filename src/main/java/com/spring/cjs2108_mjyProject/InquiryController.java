package com.spring.cjs2108_mjyProject;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_mjyProject.service.InquiryService;
import com.spring.cjs2108_mjyProject.vo.InquiryVO;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	
	String msgFlag = "";
	
	@Autowired
	InquiryService inquiryService;
	
	@RequestMapping(value="/inquiryList")
	public String inquiryListGet(HttpSession session, Model model) {
		String nickName = (String)session.getAttribute("sNickName");
		List<InquiryVO> vos = inquiryService.getInquiryList(nickName);
		model.addAttribute("vos", vos);
		return "/member/inquiry/inquiryList";
	}
	
	@RequestMapping(value="/inquiryInput")
	public String inquiryInputGet() {
		return "/member/inquiry/inquiryInput";
	}
	
	@RequestMapping(value="/inquiryInput", method = RequestMethod.POST)
	public String inquiryInputPost(InquiryVO vo) {
		inquiryService.setInquiry(vo);
		
		msgFlag = "inquiryInputOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	@RequestMapping(value="/inquiryAns")
	public String inquiryAnsGet( 
			@RequestParam(name="reply", defaultValue="전체", required=false) String reply,
			Model model) {
		
		List<InquiryVO> inquiryVos = inquiryService.getAllInquiryList(reply);
		model.addAttribute("reply", reply);
		model.addAttribute("inquiryVos", inquiryVos);
		
		return "admin/inquiry/inquiryAns";
	}
	
	// 답변이 있으면 가져오기
	@ResponseBody
	@RequestMapping(value="/inquiryAns", method = RequestMethod.POST)
	public InquiryVO inquiryAnswerPost(String idx) {
		int inquiryIdx = Integer.parseInt(idx);
		return inquiryService.getAnswer(inquiryIdx);
	}
	
	// 답변등록
	@RequestMapping(value="/answerInput", method = RequestMethod.POST)
	public String answerInputPost(String ansContent, String idx) {
		int inquiryIdx = Integer.parseInt(idx);
		
		inquiryService.updateInquiryStatus(inquiryIdx);
		inquiryService.setInquiryAnswer(ansContent,inquiryIdx);
		
		msgFlag = "answerInputOk";
		
		return "redirect:/msg/" + msgFlag;
	}
	
	// 문의 삭제
	@ResponseBody
	@RequestMapping(value="/deleteInquiry" , method = RequestMethod.POST)
	public String deleteInquiryPost(String idxArr) {
		String[] idx = idxArr.split("/");
//		for(int i=0; i<idx.length; i++) {
//			System.out.println("idx : " + idx[i]);
//		}
		
		// 답변삭제
		inquiryService.deleteInquiryAns(idx);
		// 문의삭제
		inquiryService.deleteInquiry(idx);
		
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/inquiryUpdate", method = RequestMethod.POST)
	public String inquiryUpdatePost(String idx, String content) {
		inquiryService.inquiryContentUpdate(idx, content);
		
		return "";
	}
	@ResponseBody
	@RequestMapping(value="/inquiryAnsUpdate", method = RequestMethod.POST)
	public String inquiryAnsUpdatePost(String inquiryIdx, String ansContent) {
		inquiryService.inquiryAnsUpdate(inquiryIdx,ansContent);
		
		return "";
	}
	
}
