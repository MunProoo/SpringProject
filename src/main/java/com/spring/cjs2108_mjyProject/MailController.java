package com.spring.cjs2108_mjyProject;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mail")
public class MailController {
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value="pwdFindSend/{email}/{content}/")
	public String pwdFindSendGet(@PathVariable String email, @PathVariable String content) {
		try {
			String fromMail = "mjy5178@gmail.com";
			String title = ">> 임시 비밀번호가 발급되었습니다.";
			String pwd = content;
			content = "MUSINSA 회원님께 임시 비밀번호가 발급되었습니다. \n사이트에 접속하신 후 비밀번호를 변경해주시기 바랍니다.\n";
			
			// 메세지를 변환시켜서 메세지헬퍼에 저장하기 위한 준비
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true,"UTF-8");
			
			// 메일보관함에 회원이 보낸 메세지를 모두 저장?
			messageHelper.setFrom(fromMail);
			messageHelper.setTo(email);
			messageHelper.setSubject(title);
			
			// 메세지 내용 편집후 보관함에 저장처리
			content = content.replace("\n", "<br>");
			content += "<br><hr><h3>임시비밀번호 : <font color='red'>"+pwd+"</font></h3><hr><br>";			
			content += "Have a Good Time!!!";
			messageHelper.setText(content, true);
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/pwdFindSendOk";
	}
	
	
	
	
}
