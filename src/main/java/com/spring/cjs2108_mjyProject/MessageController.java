package com.spring.cjs2108_mjyProject;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}" )
	public String msgGet(@PathVariable String msgFlag, Model model, HttpSession session) {
		
		String nickName = session.getAttribute("sNickName") == null ? "" : (String)session.getAttribute("sNickName");
		String strLevel = session.getAttribute("sStrLevel") == null ? "" : (String)session.getAttribute("sStrLevel");
		
		if(msgFlag.equals("memLoginOk")) {
			model.addAttribute("msg", nickName + "님("+strLevel+") 로그인 되셨습니다.");
			model.addAttribute("url", "/home");
		}
		else if(msgFlag.equals("memLoginNo")) {
			model.addAttribute("msg",  "아이디 혹은 비밀번호를 잘못 입력하셨습니다.");
			model.addAttribute("url", "/member/memLogin");
		}
		else if(msgFlag.equals("memLogout")) {
			session.invalidate();
			model.addAttribute("msg",  nickName +"님 로그아웃 되었습니다.");
			model.addAttribute("url", "/home");
		}
		else if(msgFlag.equals("memIdCheckNo")) {
			model.addAttribute("msg",  "아이디가 중복되었습니다.");
			model.addAttribute("url", "/member/memJoin");
		}
		else if(msgFlag.equals("memNickNameCheckNo")) {
			model.addAttribute("msg",  "닉네임이 중복되었습니다.");
			model.addAttribute("url", "/member/memJoin");
		}
		else if(msgFlag.equals("memInputNo")) {
			model.addAttribute("msg",  "회원가입에 실패하였습니다.");
			model.addAttribute("url", "/member/memJoin");
		}
		else if(msgFlag.equals("memInputOk")) {
			model.addAttribute("msg",  "회원가입 되었습니다.");
			model.addAttribute("url", "/member/memLogin");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("msg",  "비밀번호가 틀립니다.");
			model.addAttribute("url", "/member/memPwdCheck");
		}
		else if(msgFlag.equals("memUpdateOk")) {
			model.addAttribute("msg",  "회원정보가 수정되었습니다");
			model.addAttribute("url", "/home");
		}
		else if(msgFlag.equals("memUpdateNo")) {
			model.addAttribute("msg",  "회원 정보 수정 실패!");
			model.addAttribute("url", "/member/memUpdate");
		}
		else if(msgFlag.equals("idFindNo")) {
			model.addAttribute("msg",  "조건에 맞는 아이디가 없습니다!");
			model.addAttribute("url", "/member/idFind");
		}
		else if(msgFlag.equals("pwdFindNo")) {
			model.addAttribute("msg",  "존재하지 않는 회원입니다.");
			model.addAttribute("url", "/member/pwdFind");
		}
		else if(msgFlag.equals("pwdFindSendOk")) {
			model.addAttribute("msg",  "가입된 이메일로 임시 비밀번호가 발급되었습니다.");
			model.addAttribute("url", "/member/memLogin");
		}
		else if(msgFlag.equals("memDeleteOk")) {
			model.addAttribute("msg",  "정상적으로 탈퇴되었습니다.");
			model.addAttribute("url", "/member/memLogin");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg",  "상품이 등록되었습니다.");
			model.addAttribute("url", "/product/productInput");
		}
		else if(msgFlag.equals("optionInputOk")) {
			model.addAttribute("msg",  "상품옵션이 등록되었습니다.");
			model.addAttribute("url", "/product/productOption");
		}
		else if(msgFlag.equals("colorInputNo")) {
			model.addAttribute("msg",  "이미 있는 색상입니다.");
			model.addAttribute("url", "/product/productOption");
		}
		else if(msgFlag.equals("productDeleteOk")) {
			model.addAttribute("msg",  "상품이 삭제되었습니다.");
			model.addAttribute("url", "/product/productDelete");
		}
		else if(msgFlag.equals("inquiryInputOk")) {
			model.addAttribute("msg",  "문의가 등록되었습니다.");
			model.addAttribute("url", "/inquiry/inquiryList");
		}
		else if(msgFlag.equals("answerInputOk")) {
			model.addAttribute("msg",  "문의답변이 등록되었습니다.");
			model.addAttribute("url", "/inquiry/inquiryAns");
		}
		else if(msgFlag.equals("cartInputOK")) {
			model.addAttribute("msg",  "장바구니에 추가되었습니다.");
			model.addAttribute("url", "/product/cartList");
		}
		else if(msgFlag.equals("orderInputOk")) {
			model.addAttribute("msg",  "주문이 완료되었습니다.");
			model.addAttribute("url", "/product/orderConfirm");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg",  "게시글이 작성되었습니다.");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg",  "로그인하시고 이용해주세요.");
			model.addAttribute("url", "/member/memLogin");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg",  "관리자 전용 기능입니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("productUpdateOK")) {
			model.addAttribute("msg",  "상품이 수정되었습니다.");
			model.addAttribute("url", "/product/productDelete");
		}
		
		
		
		
		
		
		else if(msgFlag.equals("noticeInputOk")) {
			model.addAttribute("msg",  "공지사항 등록이 완료되었습니다.");
			model.addAttribute("url", "/notice/noticeList");
		}
		else if(msgFlag.substring(0,11).equals("imgDeleteOk")) {     // else if 조건을 지나면서도 바운스에러가 뜨네?
			String ms = msgFlag.substring(11);
			model.addAttribute("msg",  "임시 그림파일이("+ms+"개) 모두 삭제되었습니다.");
			model.addAttribute("url", "/admin/tempFileDelete");
		}
		else if(msgFlag.substring(0,13).equals("boardDeleteOk")) {     // else if 조건을 지나면서도 바운스에러가 뜨네?
			String ms = msgFlag.substring(14);
			model.addAttribute("msg",  "게시글이 삭제되었습니다.");
			model.addAttribute("url", "/board/boardList?"+ms);
		}
		else if(msgFlag.substring(0,13).equals("boardUpdateOk")) {     // else if 조건을 지나면서도 바운스에러가 뜨네?
			String ms = msgFlag.substring(14);
			model.addAttribute("msg",  "게시글이 수정되었습니다.");
			model.addAttribute("url", "/board/boardContent?"+ms);
		}
		else if(msgFlag.substring(0,14).equals("noticeUpdateOk")) {
			model.addAttribute("msg",  "공지사항이 수정되었습니다.");
			model.addAttribute("url", "/notice/noticeList?"+msgFlag.substring(15));
		}
		else if(msgFlag.substring(0,14).equals("noticeDeleteOk")) {
			model.addAttribute("msg",  "공지사항이 삭제되었습니다.");
			model.addAttribute("url", "/notice/noticeList?"+msgFlag.substring(15));
		}
		

		
		
		return "include/message";
	}
}
