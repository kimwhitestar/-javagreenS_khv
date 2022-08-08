package com.spring.javagreenS_khv;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.dto.CustomGradeDTO;
import com.spring.javagreenS_khv.dto.CustomKindDTO;
import com.spring.javagreenS_khv.dto.CustomPersonDTO;
import com.spring.javagreenS_khv.dto.CustomPersonLoginDTO;
import com.spring.javagreenS_khv.service.CustomGradeService;
import com.spring.javagreenS_khv.service.CustomKindService;
import com.spring.javagreenS_khv.service.CustomPersonService;
import com.spring.javagreenS_khv.vo.CustomKindVO;
import com.spring.javagreenS_khv.vo.CustomPersonEntryUpdateFormVO;

//개인고객회원관리Controller
@Controller
@RequestMapping("/customPerson")
public class CustomPersonController {

	private static final Logger logger = LoggerFactory.getLogger(CustomPersonController.class);

	@Autowired
	public CustomPersonService customPersonService;
	
	@Autowired
	public CustomKindService customKindService;
	
	@Autowired
	public CustomGradeService customGradeService;
	
	//로그인화면 이동
	@RequestMapping(value="/customPersonLogin", method=RequestMethod.GET)
	public String customPersonLoginGet(HttpServletRequest request) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		Cookie[] cookies = request.getCookies();
		if (null != cookies) {
			String cLoginId = "";
			for (int i=0; i<cookies.length; i++) {
				if (cookies[i].getName().equals("cLoginId")) {
					cLoginId = cookies[i].getValue();
					request.setAttribute("loginId", cLoginId);
					break;
				}
			}
		}
		return "custom/person/customPersonLogin";
	}

	
	
	//로그인 
	@RequestMapping(value="/customPersonLogin", method=RequestMethod.POST)
	public String customPersonLoginPost(HttpSession session, HttpServletRequest request, HttpServletResponse response,
		@RequestParam("loginId") String loginId,
		@RequestParam("encryptPwd") String encryptPwd,
		@RequestParam(name="idSave", defaultValue="", required=false) String idSave,
		Model model) {//Model쓸때는 RedirectAttribute를 같이 쓸 수 없다
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		// --------------------------------------------------
		// 로그인 성공시  내용
		// --------------------------------------------------
		// 1.오늘방문횟수, 전체방문횟수 1씩 증가 
		// 2.포인터 증가(1일 10회까지 방문시마다 100포인트씩 증가)
		// 3.주요자료 세션 저장 
		// 4.아이디 저장유무에 따라 쿠키 저장
		// --------------------------------------------------
		CustomPersonLoginDTO loginDto = customPersonService.searchLogin(loginId, encryptPwd);
		if (null == loginDto) {
			return "custom/person/customPsersonLogin";
		}
		
		//로그인정보 세션저장
		setLoginSession(request, response, session, loginDto, idSave);
		
		return "redirect:/msgCustomPerson/LoginOk";
	}
	
	private void setLoginSession(HttpServletRequest request, HttpServletResponse response, HttpSession session, 
		CustomPersonLoginDTO loginDto, String idSave) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		//로그인 아이디,비밀번호로 회원조회가 됬을 경우, HttpSession에 조회된 회원정보 설정
		session.setAttribute("sLoginId", loginDto.getLogin_id());
		session.setAttribute("sGradeCode", loginDto.getCustom_grade());//고객등급
		session.setAttribute("sGradeName", loginDto.getGrade_name());//고객등급명
		session.setAttribute("sCustomId", loginDto.getCustom_id());//고객ID -- SEQ로 바꾸자
		session.setAttribute("sCustomName", loginDto.getCustom_nm());//고객명
		session.setAttribute("sLoginDate", loginDto.getLogin_date());//로그인날짜
		
		// --------------------------------------------------
		// DB 저장 : 오늘방문횟수, 전체방문횟수, 포인터 100씩 증가
		// --------------------------------------------------
		//최종방문일과 오늘날짜 비교해서 다른 경우, 오늘방문횟수(todayCnt)값을 0으로 초기화
    String todayYmdhms = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
    String todayYmd = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		if (null == loginDto.getLogin_date() || ! loginDto.getLogin_date().substring(0, 10).equals(todayYmd)) {
			customPersonService.updateTodayCnt(loginDto.getLogin_id(), loginDto.getCustom_id());//DB저장(오늘방문횟수 '0', 로그인날짜 default now())
			loginDto.setToday_cnt(0);
			loginDto.setLogin_date(todayYmdhms);
		}
		//1.오늘방문횟수, 전체방문횟수 1씩 증가 
		customPersonService.updateVisitCntAndTodayCnt(loginDto.getLogin_id(), loginDto.getCustom_id());//DB 방문횟수 증가
		loginDto.setToday_cnt(loginDto.getToday_cnt() + 1);
		loginDto.setVisit_cnt(loginDto.getVisit_cnt() + 1);
		if (10 >= loginDto.getToday_cnt()) {
			//2.포인터 100씩 증가(방문시마다 100포인트씩 증가<DB저장>, 1일 10회 이하)
			customPersonService.updatePoint(loginDto.getLogin_id(), loginDto.getCustom_id());//DB 포인트 100포인트 증가
			loginDto.setPoint(loginDto.getPoint() + 100);
		}
		// --------------------------------------------------
		// 세션 저장(Mypage 회원전용방 출력용) : 오늘방문횟수, 전체방문횟수, 포인트
		// --------------------------------------------------
		session.setAttribute("sTodayVCnt", loginDto.getToday_cnt());
		session.setAttribute("sVCnt", loginDto.getVisit_cnt());
		session.setAttribute("sPoint", loginDto.getPoint());
		
		//idSave체크시 : 쿠키에 아이디(id)를 저장 checkbox checked 클릭 여부 - on/null
		//id저장
		if (idSave.equals("on")) {
			Cookie cookie = new Cookie("cLoginId", loginDto.getLogin_id());
			cookie.setMaxAge(60*60*24*7); //쿠키저장기간 : 7일(단위:초)
			response.addCookie(cookie);
		} else {
			Cookie[] cookies = request.getCookies();
			for (int i=0; i<cookies.length; i++) {
				if (cookies[i].getName().equals("cLoginId")) {
					cookies[i].setMaxAge(0); //쿠키저장기간 : 0일(단위:초) -> 삭제
					response.addCookie(cookies[i]);
					break;
				}
			}
		}
	}
	
	//회원전용방
	@RequestMapping(value="/customPersonMain", method=RequestMethod.GET)
	public String customPersonMainGet(HttpSession session, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		String sLoginId = (String)session.getAttribute("sLoginId");
		String sGradeCode = (String)session.getAttribute("sGradeCode");
		
		if ((null == sLoginId || 0 == sLoginId.trim().length()) 
			&& (null == sGradeCode || 0 == sGradeCode.trim().length())) {
			//비회원 화면
			return "redirect:/msgCustomPerson/LoginNo";
		}
		
		return "custom/person/customPersonMain";
	}

	//회원탈퇴(기업고객로그인테이블) - 30일 회원정보유지, 회원로그인정보 임시삭제(delete_date=탈퇴날짜(회원탈퇴))
	@RequestMapping(value="/customPersonDeletePract", method=RequestMethod.GET)
	public String customPersonDeletePractGet(HttpServletRequest request) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		HttpSession session = request.getSession();
		String sLoginId = (String) session.getAttribute("sLoginId");
		int sCustomId = (int) session.getAttribute("sCustomId");
		
		//회원탈퇴 - 1달간은 회원정보유지, deleteDate와 logoutDate를 now()로 수정
		customPersonService.updateCustomPersonLoginUserDel(sLoginId, sCustomId);
		
//		if (1 == res) {
			return "redirect:/msgcustomPerson/DeletePractOk";
//		} else {
//			return "redirect:/msgCustomPerson/DeletePractNo";
//		}
	}

	//로그아웃
	@RequestMapping(value="/customPersonLogout", method=RequestMethod.GET)
	public String customPersonLogoutGet(HttpServletRequest request, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		HttpSession session = request.getSession();
		String sLoginId = (String)session.getAttribute("sLoginId");
		int sCustomId = (int) session.getAttribute("sCustomId");
		String sCustomName = (String) session.getAttribute("sCustomName");
		
		customPersonService.updateLogout(sLoginId, sCustomId);//DB 로그아웃정보 수정
//		if (1 == res) {
			session.invalidate();//세션삭제
			model.addAttribute("customName", sCustomName);
			return "redirect:/msgCustomPerson/LogoutOk";
//		} else {
//			return "redirect:/msgCustomPerson/LogoutNo";
//		}
	}

	//회원가입화면 이동
	@RequestMapping(value="/customPersonEntry", method=RequestMethod.GET)
	public String customPersonEntryGet(Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		//기업고객고분코드 목록조회 
		List<CustomKindDTO> customKindDtoList = customKindService.searchCustomKindList();
		List<CustomKindVO> customKindVoList = new ArrayList<>();
		CustomKindVO customKindVo = null;
		for (CustomKindDTO customKindDto : customKindDtoList) {
			customKindVo = new CustomKindVO();
			customKindVo.setCustomKindCode(customKindDto.getCustom_kind_cd());
			customKindVo.setCustomKindName(customKindDto.getCustom_kind_nm());
			customKindVoList.add(customKindVo);
		}
		//기업고객고분코드 화면표시값 설정 
		model.addAttribute("customKindList", customKindVoList);
		return "custom/person/customPersonEntry";
	}
	
	//회원가입화면
	@RequestMapping(value="/customPersonEntry", method=RequestMethod.POST)
	public String customPersonEntryPost(Model model, CustomPersonEntryUpdateFormVO customPersonVo, BindingResult bindRes) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		System.out.println("customPersonVo.getPostcode() = " + customPersonVo.getPostcode());			
		System.out.println("customPersonVo.getValidatingPostcode() = " + customPersonVo.getValidatingPostcode());			
		System.out.println("customPersonVo.getGender() = " + customPersonVo.getGender());			
		
		CustomPersonLoginDTO loginDto = new CustomPersonLoginDTO();
		CustomPersonDTO personDto = new CustomPersonDTO();

		//개인고객아이디 발급
		//CUSTOM_ID 구성 : 3자리(100~999) 'CUSTOM_KIND_CD' + 5자리 '순차발행' (00001~99999))
		//CUSTOM_KIND_CD '1', '2'의 경우는 '100'으로 설정 
		int customKindCode = Integer.parseInt(customPersonVo.getCustomKindCode());
		int customId = customPersonService.obtainCustomId(customKindCode);

		//기업고객고분코드명 설정
		if (2 == customKindCode) {
			personDto.setKind_name("기업고객");
		} else {
			List<CustomKindDTO> customKindDtoList = customKindService.searchCustomKindList();
			for (CustomKindDTO customKindDto : customKindDtoList) {
				if (customKindDto.getCustom_kind_cd() == customKindCode) {
					personDto.setKind_name(customKindDto.getCustom_kind_nm());
				}
			}
		}		
		//기업고객등급코드명 설정
		List<CustomGradeDTO> customGradeDtoList = customGradeService.searchCustomGradeList();
		for (CustomGradeDTO customGradeDto : customGradeDtoList) {
			if (customGradeDto.getGrade_code().equals("P") ) { //history등록용(가입시 등급코드 'P' (default))
				personDto.setGrade_name(customGradeDto.getGrade_name());
			}
		}
		
		//개인고객 회원정보 VO 설정
		personDto.setCustom_id(customId);
		personDto.setCustom_nm(customPersonVo.getCustomName());
		personDto.setCustom_kind_cd(customKindCode);
		personDto.setJob(customPersonVo.getJob());
		personDto.setTxt_job(customPersonVo.getTxtJob());
		personDto.setPost_code(customPersonVo.getValidatingPostcode());
		personDto.setRoad_addr(customPersonVo.getRoadAddress());
		personDto.setExtra_addr(customPersonVo.getExtraAddress());
		personDto.setDetail_addr(customPersonVo.getDetailAddress());
		personDto.setEmail(customPersonVo.getEmail());
		personDto.setJumin_no(customPersonVo.getJuminNo());
		personDto.setGender(customPersonVo.getGender());
		personDto.setBirth_date(customPersonVo.getBirthDate());
		personDto.setTel_no(customPersonVo.getTelNo());
		personDto.setHp_no(customPersonVo.getHpNo());
		personDto.setHobby(customPersonVo.getCheckedHobbies());
		personDto.setMemo("");
		
		//개인고객 로그인 VO 설정
		loginDto.setLogin_id(customPersonVo.getLoginId());
		loginDto.setEncrypt_pwd(customPersonVo.getEncryptPwd());
		loginDto.setCustom_id(customId);
		
		//개인고객 회원정보 DB 등록, 개인고객 로그인 DB 등록
		customPersonService.insertCustomPersonAndCustomPersonLogin(personDto, loginDto);
		
//	if (1 == resLogin && 1 == resComp) {
			return "redirect:/msgCustomPerson/EntryOk";
//	} else {
//			return "redirect:/msgCustomPerson/EntryNo";
//	}		
	}
	
	//로그인ID중복체크화면 이동
	@RequestMapping(value="/customPersonLoginIdCheck", method=RequestMethod.GET)
	public String customPersonLoginIdCheckGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "custom/person/customPersonLoginIdCheck";
	}
	
	//로그인ID중복체크
	@RequestMapping(value="/customPersonLoginIdCheck", method=RequestMethod.POST)
	public String customPersonLoginIdCheckPost(
		@RequestParam(name="loginId", defaultValue="", required=true) String loginId,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		model.addAttribute("loginId", loginId);
		
		//isExist = true 아이디 중복
		if (customPersonService.loginIdCheck(loginId)) {
			model.addAttribute("existLoginIdYN", "Y");
		} else {
			model.addAttribute("existLoginIdYN", "N");
		}
		
		return "custom/person/customPersonLoginIdCheck";
	}
	
	//주민등록번호중복체크화면 이동
	@RequestMapping(value="/customPersonJuminNoCheck", method=RequestMethod.GET)
	public String customPersonJuminNoCheckGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "custom/person/customPersonJuminNoCheck";
	}
	
	//주민등록번호중복체크
	@RequestMapping(value="/customPersonJuminNoCheck", method=RequestMethod.POST)
	public String customPersonJuminNoCheckPost(
		@RequestParam(name="juminNo", defaultValue="", required=true) String juminNo,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		model.addAttribute("juminNo", juminNo);
		model.addAttribute("existJuminNoYN", null);
		
		//isExist = true 아이디 중복
		if (customPersonService.juminNoCheck(juminNo)) {
			model.addAttribute("existJuminNoYN", "Y");
		} else {
			model.addAttribute("existJuminNoYN", "N");
		}
		
		return "custom/person/customPersonJuminNoCheck";
	}
	
	//이메일중복체크화면 이동
	@RequestMapping(value="/customPersonEmailCheck", method=RequestMethod.GET)
	public String customPersonEmailCheckGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "custom/person/customPersonEmailCheck";
	}
	
	//이메일중복체크
	@RequestMapping(value="/customPersonEmailCheck", method=RequestMethod.POST)
	public String customPersonEmailCheckPost(
		@RequestParam(name="email", defaultValue="", required=true) String email,
		@RequestParam(name="email1", defaultValue="", required=true) String email1,
		@RequestParam(name="email2", defaultValue="", required=true) String email2,
		@RequestParam(name="txtEmail2", defaultValue="", required=true) String txtEmail2,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		model.addAttribute("email", email);
		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		model.addAttribute("txtEmail2", txtEmail2);
		
		//이메일 중복 / 존재 체크
		if (customPersonService.emailCheck(email)) {
			model.addAttribute("existEmailYN", "Y");
		} else {
			model.addAttribute("existEmailYN", "N");
		}
	
		return "custom/person/customPersonEmailCheck";
	}
	
	//회원정보수정화면 이동
	@RequestMapping(value="/customPersonUpdate", method=RequestMethod.GET)
	public String customPersonUpdateGet(HttpServletRequest request, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		HttpSession session = request.getSession();
		int sCustomId = (int) session.getAttribute("sCustomId");

		//개별회원정보 조회
		CustomPersonDTO personDto = customPersonService.searchCustomPerson(sCustomId);
		if (null == personDto) return "redirect:/msgCustomPerson/LoginNo";//비회원화면으로 이동
		
		//Form출력 편집 설정
		CustomPersonEntryUpdateFormVO customPersonVo = new CustomPersonEntryUpdateFormVO();
		customPersonVo.setCustomName(personDto.getCustom_nm());
		customPersonVo.setCustomKindCode(String.valueOf(personDto.getCustom_kind_cd()));
		customPersonVo.setPostcode(personDto.getPost_code());
		customPersonVo.setRoadAddress(personDto.getRoad_addr());
		customPersonVo.setExtraAddress(personDto.getExtra_addr());
		customPersonVo.setDetailAddress(personDto.getDetail_addr());
		customPersonVo.setJuminNo(personDto.getJumin_no());
		customPersonVo.setGender(personDto.getGender());
		customPersonVo.setHobby(personDto.getHobby());
		customPersonVo.setMemo(personDto.getMemo());
		
		//직업 편집
		int startIdx = personDto.getJob().indexOf(":") + 1;
		if ( -1 < startIdx ) {
			customPersonVo.setTxtJob(personDto.getJob().substring(startIdx, personDto.getJob().length()));
			customPersonVo.setJob("기타");
		} else {
			customPersonVo.setJob(personDto.getJob());
		}
		
		//Email 분리(@)
		String[] email = personDto.getEmail().split("@");
		if (null == email || 2 > email.length) {
			customPersonVo.setEmail("");
			customPersonVo.setEmail1("");
			customPersonVo.setEmail2("");
		} else {
			customPersonVo.setEmail(personDto.getEmail());
			customPersonVo.setEmail1(email[0]);
			customPersonVo.setEmail2(email[1]);
		}
		
		//생일
		customPersonVo.setBirthDate(personDto.getBirth_date().substring(0, 10));

		//전화번호 분리(-) : 선택입력항목
		String[] tel = personDto.getTel_no().split("-");
		if (null == tel || 3 > tel.length) {
			customPersonVo.setTelNo("");
			customPersonVo.setTel1("");
			customPersonVo.setTel2("");
			customPersonVo.setTel3("");
		} else {
			customPersonVo.setTelNo(personDto.getTel_no());
			customPersonVo.setTel1(tel[0]);
			customPersonVo.setTel2(tel[1]);
			customPersonVo.setTel3(tel[2]);
		}		
		
		//휴대전화 분리(-) : 필수입력항목
		String[] hp = personDto.getHp_no().split("-");
		customPersonVo.setHpNo(personDto.getHp_no());
		customPersonVo.setHp1(hp[0]);
		customPersonVo.setHp2(hp[1]);
		customPersonVo.setHp3(hp[2]);

		//기업고객정보수정FormVO 화면표시값 설정
		model.addAttribute("vo", customPersonVo);

		//기업고객고분코드 목록조회 
		List<CustomKindDTO> customKindDtoList = customKindService.searchCustomKindList();
		List<CustomKindVO> customKindVoList = new ArrayList<>();
		CustomKindVO customKindVo = null;
		for (CustomKindDTO customKindDto : customKindDtoList) {
			customKindVo = new CustomKindVO();
			customKindVo.setCustomKindCode(customKindDto.getCustom_kind_cd());
			customKindVo.setCustomKindName(customKindDto.getCustom_kind_nm());
			customKindVoList.add(customKindVo);
		}
		//기업고객고분코드 화면표시값 설정 
		model.addAttribute("customKindList", customKindVoList);
		return "custom/person/customPersonUpdate";
	}
	
	//회원정보수정
	@RequestMapping(value="/customPersonUpdate", method=RequestMethod.POST)
	public String customPersonUpdatePost(HttpServletRequest request, @Validated CustomPersonEntryUpdateFormVO customPersonVo, BindingResult bindRes, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		System.out.println("customPersonVo.getValidatingPostcode() = " + customPersonVo.getValidatingPostcode());			
		System.out.println("customPersonVo.getGender() = " + customPersonVo.getGender());			
		
		//개인고객 로그인 정보 취득
		HttpSession session = request.getSession();
		String sLoginId = (String) session.getAttribute("sLoginId");
		String encryptPwd = customPersonVo.getEncryptPwd();
		
		//개인고객 로그인 정보 조회
		CustomPersonLoginDTO loginDto = customPersonService.searchLogin(sLoginId, encryptPwd);
		if (null == loginDto) return "redirect:/msgCustomPerson/PwdNo";//회원정보수정화면으로 재이동-비밀번호 오류
		
		//개인고객 회원정보 VO 설정
		CustomPersonDTO personDto = new CustomPersonDTO();
		String customName = customPersonVo.getCustomName();
		personDto.setCustom_id(loginDto.getCustom_id());
		personDto.setCustom_nm(customName);
		personDto.setCustom_kind_cd(Integer.parseInt(customPersonVo.getCustomKindCode()));
		personDto.setJob(customPersonVo.getJob());
		personDto.setTxt_job(customPersonVo.getTxtJob());
		personDto.setPost_code(customPersonVo.getValidatingPostcode());
		personDto.setRoad_addr(customPersonVo.getRoadAddress());
		personDto.setExtra_addr(customPersonVo.getExtraAddress());
		personDto.setDetail_addr(customPersonVo.getDetailAddress());
		personDto.setEmail(customPersonVo.getEmail());
		personDto.setJumin_no(customPersonVo.getJuminNo());
		personDto.setGender(customPersonVo.getGender());
		personDto.setBirth_date(customPersonVo.getBirthDate());
		personDto.setTel_no(customPersonVo.getTelNo());
		personDto.setHp_no(customPersonVo.getHpNo());
		personDto.setHobby(customPersonVo.getCheckedHobbies());
		personDto.setMemo(customPersonVo.getMemo());

		//개인고객 회원정보 DB 수정
		customPersonService.updateCustomPerson(personDto);
		
//		if (1 == resPerson) {
				session.setAttribute("sCustomName", customName);//고객명
				return "redirect:/msgCustomPerson/UpdateOk";
//		} else {
//			return "redirect:/msgCustomPerson/UpdateNo";
//		}
	}
}