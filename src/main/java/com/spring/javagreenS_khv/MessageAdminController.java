package com.spring.javagreenS_khv;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageAdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(MessageAdminController.class);
	
	@RequestMapping(value="/msgAdmin/{msgFlag}", method=RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, 
		@RequestParam(name="levelName", defaultValue="", required=false) String levelName,
		@RequestParam(name="customGrade", defaultValue="", required=false) String customGrade,
		@RequestParam(name="overFlg", defaultValue="NONE", required=false) String overFlg,
		Model m, HttpSession session) {
		logger.info("********************************************************************************");
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		logger.info("msgFlag = " + msgFlag);
		
		String sLevelName = (String)session.getAttribute("sLevelName");
		
    if (msgFlag.equals("LoginNo")) { 
    	m.addAttribute("msg", "로그인 실패"); 			
    	m.addAttribute("url", "admin/adminLogin");
  	} else if (msgFlag.equals("LoginOk")) { 
    	m.addAttribute("msg", sLevelName + "님 로그인됬습니다");
    	m.addAttribute("url", "admin/adminIndex");
  	} else if (msgFlag.equals("LogoutOk")) { 
    	m.addAttribute("msg", levelName + "님 로그아웃됬습니다"); 
    	m.addAttribute("url", "admin/adminLogin");
    } else if (msgFlag.equals("CompGradeUpdateOk")) { 
  		m.addAttribute("customGrade", customGrade);
    	m.addAttribute("msg", "고객등급을 수정했습니다"); 
    	m.addAttribute("url", "admin/customCompGradeUpdateList");
    } else if (msgFlag.equals("CompGradeUpdateNo")) { 
  		m.addAttribute("customGrade", customGrade);
    	m.addAttribute("msg", "고객등급 수정 실패"); 
    	m.addAttribute("url", "admin/customCompGradeUpdateList");
    } else if (msgFlag.equals("PersonGradeUpdateOk")) { 
  		m.addAttribute("customGrade", customGrade);
    	m.addAttribute("msg", "고객등급을 수정했습니다"); 
    	m.addAttribute("url", "admin/customPersonGradeUpdateList");
    } else if (msgFlag.equals("PersonGradeUpdateNo")) { 
  		m.addAttribute("customGrade", customGrade);
    	m.addAttribute("msg", "고객등급 수정 실패"); 
    	m.addAttribute("url", "admin/customPersonGradeUpdateList");
    } else if (msgFlag.equals("CompDeleteOk")) { 
  		m.addAttribute("overFlg", overFlg);
    	m.addAttribute("msg", "기업회원DB에서 회원을 삭제했습니다"); 
    	m.addAttribute("url", "admin/customCompDeletePracList");
    } else if (msgFlag.equals("CompDeleteNo")) { 
  		m.addAttribute("overFlg", overFlg);
    	m.addAttribute("msg", "기업회원DB에서 회원 삭제 실패"); 
    	m.addAttribute("url", "admin/customCompDeletePracList");
    } else if (msgFlag.equals("PersonDeleteOk")) { 
  		m.addAttribute("overFlg", overFlg);
    	m.addAttribute("msg", "개인회원DB에서 회원을 삭제했습니다"); 
    	m.addAttribute("url", "admin/customPersonDeletePracList");
    } else if (msgFlag.equals("PersonDeleteNo")) { 
  		m.addAttribute("overFlg", overFlg);
    	m.addAttribute("msg", "개인회원DB에서 회원 삭제 실패"); 
    	m.addAttribute("url", "admin/customPersonDeletePracList");
  	}
    
		logger.info("********************************************************************************");
		return "msg/message";
	}
}