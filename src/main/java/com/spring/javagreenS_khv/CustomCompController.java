package com.spring.javagreenS_khv;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javagreenS_khv.common.ProjectSupport;
import com.spring.javagreenS_khv.dto.CustomCompDTO;
import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.dto.CustomGradeDTO;
import com.spring.javagreenS_khv.dto.CustomKindDTO;
import com.spring.javagreenS_khv.service.CustomCompService;
import com.spring.javagreenS_khv.service.CustomGradeService;
import com.spring.javagreenS_khv.service.CustomKindService;
import com.spring.javagreenS_khv.vo.CustomCompEntryUpdateFormVO;
import com.spring.javagreenS_khv.vo.CustomKindVO;
import com.spring.javagreenS_khv.vo.KakaoAddressVO;
import com.spring.javagreenS_khv.vo.QrCodeVO;
import com.spring.javagreenS_khv.vo.StyleCssCustomCompVO;
import com.spring.javagreenS_khv.vo.StyleCssVO;

//기업고객회원관리Controller
@Controller
@RequestMapping("/customComp")
public class CustomCompController {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomCompController.class);

	@Autowired
	public CustomCompService customCompService;
	
	@Autowired
	public CustomKindService customKindService;
	
	@Autowired
	public CustomGradeService customGradeService;
	
	//카카오맵 사용
	@RequestMapping(value="/kakaomap", method=RequestMethod.GET)
	public String kakaomapGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "custom/comp/kakaomap/kakaomap";
	}
	
	//카카오맵 응용1 - Map 조회
	@RequestMapping(value="/kakaoEx1", method=RequestMethod.GET)
	public String kakaoEx1Get() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "custom/comp/kakaomap/kakaoEx1";
	}
	
	//카카오맵 응용1 - 주소명으로 저장
	@ResponseBody
	@RequestMapping(value="/kakaoEx1", method=RequestMethod.POST)
	public String kakaoEx1Post(HttpSession session, KakaoAddressVO vo) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		KakaoAddressVO searchVo = customCompService.searchAddressName(vo.getMapaddress());
		if (null != searchVo) return "0";
		vo.setCustomid( (int) session.getAttribute("sCustomId") );
		customCompService.insertAddressName(vo);
		return "1";
	}
	
//	//카카오맵 응용2 - Map 조회
//	@RequestMapping(value="/kakaoEx2", method=RequestMethod.GET)
//	public String kakaoEx2Get(Model model, @RequestParam(name="mapaddress", defaultValue="db에 저장되어있는 주소명 한개", required=false) String mapaddress) {
//		List<KakaoAddressVO> vos = customCompService.searchAddressNameList();
//		KakaoAddressVO searchVo = customCompService.searchAddressName(mapaddress);
//		model.addAttribute("vos", vos);
//
//		model.addAttribute("vo", searchVo);
//		model.addAttribute("mapaddress", mapaddress);
//		return "custom/comp/kakaomap/kakaoEx2";
//	}
//	//카카오맵 응용2.2 - 지점명 DB에서 삭제
//	@ResponseBody
//	@RequestMapping(value="/kakaoEx2Delete", method=RequestMethod.POST)
//	public String kakaoEx2DeletePost(String mapaddress) {
//		customCompService.kakaoEx2Delete(mapaddress);
//		return "";
//	}
//	// 카카오맵 응용하기3
//	@RequestMapping(value="/kakaoEx3", method=RequestMethod.GET)
//	public String kakaoEx3Get(Model model, String mapaddress) {
//		if(mapaddress == null) mapaddress = "";
//		model.addAttribute("mapaddress", mapaddress);
//		return "custom/comp/kakaomap/kakaoEx3";
//	}

	//고객회사소개 (Map)
	@RequestMapping(value="/customCompMap", method=RequestMethod.GET)
	public String customCompMapGet(HttpSession session, String address, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		String sAddress = (String)session.getAttribute("sAddress");
		if(address == null) address = sAddress;
		model.addAttribute("address", address);
		return "custom/comp/kakaomap/customCompMap";
	}
	private void setLoginSession(HttpServletRequest request, HttpServletResponse response, HttpSession session, CustomCompLoginDTO loginDto, String idSave) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		//로그인 아이디,비밀번호로 회원조회가 됬을 경우, HttpSession에 조회된 회원정보 설정
		session.setAttribute("sLoginId", loginDto.getLogin_id());
		session.setAttribute("sGradeCode", loginDto.getCustom_grade());//고객등급
		session.setAttribute("sGradeName", loginDto.getGrade_name());//고객등급명
		session.setAttribute("sCustomId", loginDto.getCustom_id());//고객ID -- SEQ로 바꾸자
		session.setAttribute("sCustomName", loginDto.getCustom_name());//고객명
		session.setAttribute("sAddress", loginDto.getAddress());//고객회사소개-kakaoMap검색용(도로명주소)
		session.setAttribute("sLoginDate", loginDto.getLogin_date());//로그인날짜
		
		// --------------------------------------------------
		// DB 저장 : 오늘방문횟수, 전체방문횟수, 포인터 100씩 증가
		// --------------------------------------------------
		//최종방문일과 오늘날짜 비교해서 다른 경우, 오늘방문횟수(todayCnt)값을 0으로 초기화
		String todayYmdhms = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
    String todayYmd = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    if (null == loginDto.getLogin_date() || ! loginDto.getLogin_date().substring(0, 10).equals(todayYmd)) {
			customCompService.updateTodayCnt(loginDto.getLogin_id(), loginDto.getCustom_id());//DB저장(오늘방문횟수 '0', 로그인날짜 default now())
			loginDto.setToday_cnt(0);
			loginDto.setLogin_date(todayYmdhms);
		}
    
		//1.오늘방문횟수, 전체방문횟수 1씩 증가 
		customCompService.updateVisitCntAndTodayCnt(loginDto.getLogin_id(), loginDto.getCustom_id());//DB 방문횟수 증가
		loginDto.setToday_cnt(loginDto.getToday_cnt() + 1);
		loginDto.setVisit_cnt(loginDto.getVisit_cnt() + 1);
		if (10 >= loginDto.getToday_cnt()) {
			//2.포인터 100씩 증가(방문시마다 100포인트씩 증가<DB저장>, 1일 10회 이하)
			customCompService.updatePoint(loginDto.getLogin_id(), loginDto.getCustom_id());//DB 포인트 100포인트 증가
			loginDto.setPoint(loginDto.getPoint() + 100);
		}
		
		// --------------------------------------------------
		// 세션 저장(Mypage 회원전용방 출력용) : 오늘방문횟수, 전체방문횟수, 포인트
		// --------------------------------------------------
		session.setAttribute("sTodayVCnt", loginDto.getToday_cnt());
		session.setAttribute("sVCnt", loginDto.getVisit_cnt());
		session.setAttribute("sPoint", loginDto.getPoint());
		//idSave 저장 : 쿠키에 아이디(id)를 저장 checkbox checked 클릭 여부 - on/null
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
	
	private String getOrgFileName(MultipartFile fName) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		String orgFileName = "";
		String oFileName = fName.getOriginalFilename();
		if(!oFileName.equals("")) {
			UUID uid = UUID.randomUUID();
			orgFileName = uid + "_" + oFileName;
		}
		return orgFileName;
	}
	
	// QR코드 생성화면 이동(URL 등록폼)
	@RequestMapping(value="/qrCode", method=RequestMethod.GET)
	public String qrCodeGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "qrCode/qrCode";
	}
	
	// QR코드 생성 -- 화일명에 한글지원하는 produces의 출처: https://tomining.tistory.com/202 [마이너의 일상:티스토리]
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value="/qrCreate", method=RequestMethod.POST, produces="application/text;charset=utf8")
	public String qrCreatePost(HttpServletRequest request, HttpSession session, String qrCodeStartNobodyOrMoveUrls, String extention) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		String qrCodeName = customCompService.qrCreate(qrCodeStartNobodyOrMoveUrls, (String) session.getAttribute("sLoginId"), (int) session.getAttribute("sCustomId"), 
				uploadPath, (String) session.getAttribute("sCustomName"), extention);	// qr코드가 저장될 서버경로와 qr코드 찍었을때 이동할 url을 서비스객체로 넘겨서 qr코드를 생성하게 한다.
		return qrCodeName;
	}
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value="/loginQrCode", method=RequestMethod.POST)
	public String loginQrCodePost(HttpSession session, HttpServletRequest request, HttpServletResponse response, MultipartFile customImgFileName) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		logger.info("<Request Param> qrFName = " + customImgFileName);
		
		//고객사진 upload보관
		String orgFileName = this.getOrgFileName(customImgFileName);
		ProjectSupport ps = new ProjectSupport();
		ps.writeFile(customImgFileName, orgFileName, "qrCode");

		QrCodeVO qrVo = customCompService.loginQrCode(
				request.getSession().getServletContext().getRealPath("/resources/data/qrCode/"), 
				customImgFileName.getOriginalFilename());
		if (null == qrVo) return "qrCode/qrCode";
		
		// --------------------------------------------------
		// 로그인 성공시 처리 내용 : 로그인정보 세션저장 
		// --------------------------------------------------
		// 1.오늘방문횟수, 전체방문횟수 1씩 증가 
		// 2.포인터 증가(1일 10회까지 방문시마다 100포인트씩 증가)
		// 3.주요자료 세션 저장 
		// 4.아이디 저장유무에 따라 쿠키 저장
		// --------------------------------------------------
		CustomCompLoginDTO loginDto = customCompService.searchLogin2(qrVo.getCustomId());
		if (null == loginDto) return "qrCode/qrCode";
		setLoginSession(request, response, session, loginDto, "");//로그인정보 세션저장
		return "redirect:/msgCustomComp/LoginOk";
	}

	//로그인화면 이동
	@RequestMapping(value="/customCompLogin", method=RequestMethod.GET)
	public String customCompLoginGet(HttpServletRequest request) {
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
		return "custom/comp/customCompLogin";
	}
	
	//로그인
	@RequestMapping(value="/customCompLogin", method=RequestMethod.POST)
	public String customCompLoginPost(HttpSession session, HttpServletRequest request, HttpServletResponse response,
		@RequestParam("loginId") String loginId, @RequestParam("encryptPwd") String encryptPwd,
		@RequestParam(name="idSave", defaultValue="", required=false) String idSave, Model model) {//Model쓸때는 RedirectAttribute를 같이 쓸 수 없다
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		// --------------------------------------------------
		// 로그인 성공시 처리 내용 : 로그인정보 세션저장 
		// --------------------------------------------------
		// 1.오늘방문횟수, 전체방문횟수 1씩 증가 
		// 2.포인터 증가(1일 10회까지 방문시마다 100포인트씩 증가)
		// 3.주요자료 세션 저장 
		// 4.아이디 저장유무에 따라 쿠키 저장
		// --------------------------------------------------
		CustomCompLoginDTO loginDto = customCompService.searchLogin(loginId, encryptPwd);
		if (null == loginDto) return "custom/comp/customCompLogin";
		setLoginSession(request, response, session, loginDto, idSave);//로그인정보 세션저장
		return "redirect:/msgCustomComp/LoginOk";
	}
	
	//회원탈퇴(기업고객로그인테이블) - 30일 회원정보유지, 회원로그인정보 임시삭제(delete_date=탈퇴날짜(회원탈퇴))
	@RequestMapping(value="/customCompDeletePract", method=RequestMethod.GET)
	public String customCompDeletePractGet(HttpServletRequest request) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		HttpSession session = request.getSession();
		String sLoginId = (String) session.getAttribute("sLoginId");
		int sCustomId = (int) session.getAttribute("sCustomId");
		//회원탈퇴 - 1달간은 회원정보유지, deleteDate와 logoutDate를 now()로 수정
		customCompService.updateCustomCompLoginUserDel(sLoginId, sCustomId);
//		if (1 == res) {
		return "redirect:/msgCustomComp/DeletePractOk";
//		} else {
//			return "redirect:/msgCustomComp/DeletePractNo";
//		}
	}

	//로그아웃
	@RequestMapping(value="/customCompLogout", method=RequestMethod.GET)
	public String customCompLogoutGet(HttpServletRequest request, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		HttpSession session = request.getSession();
		String sLoginId = (String) session.getAttribute("sLoginId");
		int sCustomId = (int) session.getAttribute("sCustomId");
		String sCustomName = (String) session.getAttribute("sCustomName");
		customCompService.updateLogout(sLoginId, sCustomId);//DB 로그아웃정보 수정
//		if (1 == res) {
			session.invalidate();//세션삭제
			model.addAttribute("customName", sCustomName);
			return "redirect:/msgCustomComp/LogoutOk";
//		} else {
//			return "redirect:/msgCustomComp/LogoutNo";
//		}
	}
	
	//ckeditor에서 글을 올릴 때 image와 함께 올리려면, 이곳에서 서버파일시스템에 그림파일을 저장할 수 있도록 처리
	@ResponseBody
	@RequestMapping(value="/imageUpload", method=RequestMethod.GET)
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, MultipartFile upload) throws Exception {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddhhmmss");
		String orgFName = upload.getOriginalFilename();
		orgFName = sdf.format(date) + "_" + orgFName;
		
		//서버파일시스템에 사진 저장(전송하지 않아도, 호일읽는 것만으로 아래폴더에 사진이 저장되고, 사진을 뺀다고 지워지지않는다.
		byte[] bytes = upload.getBytes();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream os = new FileOutputStream(new File(uploadPath + orgFName));
		os.write(bytes);
		
		//서버파일시스템에 저장된 파일을 화면에 보여주기위한 작업
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + orgFName;

		// Json type으로 출력(전송) { key : value, key : value } 
		out.println("{\"orgFName\":\""+orgFName+"\",\"uploaded\":1, \"url\":\""+fileUrl+"\"}");
		out.flush();
		os.close();
	}

	
	
	
	
	//회원전용방
	@RequestMapping(value="/customCompMain", method=RequestMethod.GET)
	public String customCompMainGet(HttpSession session, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		String sLoginId = (String)session.getAttribute("sLoginId");
		String sGradeCode = (String) session.getAttribute("sGradeCode");
		if ((null == sLoginId || 0 == sLoginId.trim().length()) 
			&& (null == sGradeCode || 0 == sGradeCode.trim().length())) {
			return "redirect:/msgCustomComp/LoginNo";//비회원 화면
		}
		CustomCompDTO compDTO = customCompService.searchCustomComp( (int) session.getAttribute("sCustomId") );
		model.addAttribute("photo", compDTO.getCustom_img_file_name());//프로필 사진
		return "custom/comp/customCompMain";
	}
	
	//회원가입화면 이동
	@RequestMapping(value="/customCompEntry", method=RequestMethod.GET)
	public String customCompEntryGet(Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		List<CustomKindDTO> customKindDtoList = customKindService.searchCustomKindList(); //기업고객고분코드 목록조회 
		List<CustomKindVO> customKindVoList = new ArrayList<>();
		CustomKindVO customKindVo = null;
		for (CustomKindDTO customKindDto : customKindDtoList) {
			
			customKindVo = new CustomKindVO();
			customKindVo.setCustomKindCode(customKindDto.getCustom_kind_cd());
			customKindVo.setCustomKindName(customKindDto.getCustom_kind_nm());
			customKindVoList.add(customKindVo);
		}
		model.addAttribute("customKindList", customKindVoList);
		return "custom/comp/customCompEntry";
	}
	
	//회원가입
	@RequestMapping(value="/customCompEntry", method=RequestMethod.POST)
	public String customCompEntryPost(HttpServletRequest request, MultipartFile fName, @Validated CustomCompEntryUpdateFormVO customCompVo, BindingResult bindRes, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		if (bindRes.hasErrors()) {
			List<FieldError> fieldErrors = bindRes.getFieldErrors();//발생된 에러
			StyleCssCustomCompVO errMsgVo = new StyleCssCustomCompVO();
			initErrMsgList(errMsgVo);//에러메세지 빈값 초기화
			setErrMsgList(errMsgVo, fieldErrors);//발생된 에러메세지 재설정
			model.addAttribute("errMsgVo", errMsgVo);
			
			List<CustomKindDTO> customKindDtoList = customKindService.searchCustomKindList(); //기업고객고분코드 목록조회 
			List<CustomKindVO> customKindVoList = new ArrayList<>();
			CustomKindVO customKindVo = null;
			for (CustomKindDTO customKindDto : customKindDtoList) {
				customKindVo = new CustomKindVO();
				customKindVo.setCustomKindCode(customKindDto.getCustom_kind_cd());
				customKindVo.setCustomKindName(customKindDto.getCustom_kind_nm());
				customKindVoList.add(customKindVo);
			}
			model.addAttribute("customKindList", customKindVoList);
			
			model.addAttribute("compEntryVo", customCompVo);
			return "custom/comp/customCompEntry";
		}
		
		CustomCompDTO compDto = new CustomCompDTO(); 
		CustomCompLoginDTO loginDto = new CustomCompLoginDTO();
		
		//기업고객아이디 발급
		//CUSTOM_ID 구성 : 3자리(100~999) 'CUSTOM_KIND_CD' + 5자리 '순차발행' (00001~99999))
		//CUSTOM_KIND_CD '1', '2'의 경우는 '100'으로 설정 
		int customKindCode = Integer.parseInt(customCompVo.getCustomKindCode());
		int customId = customCompService.obtainCustomId(customKindCode);
		
		//기업고객고분코드명 설정
		if (1 == customKindCode) {
			compDto.setKind_name("기업고객");
		} else {
			List<CustomKindDTO> customKindDtoList = customKindService.searchCustomKindList();
			for (CustomKindDTO customKindDto : customKindDtoList) {
				if (customKindDto.getCustom_kind_cd() == customKindCode) {
					compDto.setKind_name(customKindDto.getCustom_kind_nm());
				}
			}
		}
		
		//기업고객등급코드명 설정
		List<CustomGradeDTO> customGradeDtoList = customGradeService.searchCustomGradeList();
		for (CustomGradeDTO customGradeDto : customGradeDtoList) {
			if (customGradeDto.getGrade_code().equals("O") ) { //history등록용(가입시 등급코드 'O' (default))
				compDto.setGrade_name(customGradeDto.getGrade_name());
			}
		}
		
		//고객사진 upload보관
		String orgFileName = this.getOrgFileName(fName);
		if (orgFileName.equals("")) {
			orgFileName = "noimage.jpg";
		} 
		
		ProjectSupport ps = new ProjectSupport();
		ps.writeFile(fName, orgFileName, "custom");
		customCompVo.setPhoto(orgFileName);

		//기업고객 회원정보 VO 설정
		compDto.setCustom_id(customId);
		compDto.setCustom_nm(customCompVo.getCustomName());
		compDto.setCustom_nm_short(customCompVo.getCustomNameShort());
		compDto.setCustom_kind_cd(customKindCode);
		compDto.setEstbl_date(customCompVo.getEstblDate());
		compDto.setCompany_no(customCompVo.getCompanyNo());
		compDto.setOffice(customCompVo.getOffice());
		compDto.setTxt_office(customCompVo.getTxtOffice());
		compDto.setTel_no(customCompVo.getTelNo());
		compDto.setHp_no(customCompVo.getHpNo());
		compDto.setEmail(customCompVo.getEmail());
		compDto.setPost_code(customCompVo.getValidatingPostcode());
		compDto.setRoad_addr(customCompVo.getRoadAddress());
		compDto.setExtra_addr(customCompVo.getExtraAddress());
		compDto.setDetail_addr(customCompVo.getDetailAddress());
		compDto.setMemo("");
		compDto.setCustom_img_file_name(customCompVo.getPhoto());//고객사진 DB보관 설정
		
		//기업고객 로그인 VO 설정
		loginDto.setCustom_id(customId);
		loginDto.setLogin_id(customCompVo.getLoginId());
		loginDto.setEncrypt_pwd(customCompVo.getEncryptPwd());
		
		//기업고객 고객정보 DB 등록, 기업고객 로그인 DB 등록 - mybatis transaction 포함
		customCompService.insertCustomCompAndCustomCompLogin(compDto, loginDto);//고객정보 DB 저장
//		if (1 == resLogin && 1 == resComp) {
				return "redirect:/msgCustomComp/EntryOk";
//		} else {
//				return "redirect:/msgCustomComp/EntryNo";
//		}		
	}
	
	//VO 멤버필드 빈값으로 초기화
	private void initErrMsgList(StyleCssCustomCompVO vo) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		Method[] methods = vo.getClass().getDeclaredMethods();
		Method method = null;
		Field[] fields = vo.getClass().getDeclaredFields();
		String methodName = null;
		int size = fields.length;
		StyleCssVO cssVo = null;

		for (int i=0; i<methods.length; i++) {
			method = methods[i];
			methodName = methods[i].getName();
			if (methodName.substring(0, 3).equals("set")) { 
				cssVo = new StyleCssVO();
				cssVo.setFieldCss("is-valid");
				cssVo.setInvalidCss("is-valid");
				cssVo.setMessageTxt("");
				try {
					method.invoke(cssVo); //setOOOMethod()를 invoke로 실행
				} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
					logger.debug(e.getMessage());
				}
			}
		}
	}
	
	//initErrMsgList()에서 초기화된 VO에 실제로 발생된 Error Message 값으로 재설정
	private void setErrMsgList(StyleCssCustomCompVO vo, List<FieldError> fieldErrors) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		int errorsSize=fieldErrors.size();
		FieldError fe = null;
		Method method = null;
		StyleCssVO cssVo = null;
		
		System.out.println(" FieldErrors : " + errorsSize);
		for (int j=0; j<errorsSize; j++) {
				fe = fieldErrors.get(j);
				System.out.println("field : " + fe.getField());
				System.out.println("Message : " + fe.getDefaultMessage());
				
				cssVo = new StyleCssVO();
				cssVo.setFieldCss("is-invalid"); //에러스타일CSS 설정
				cssVo.setInvalidCss("is-invalid"); //에러스타일CSS 설정
				cssVo.setMessageTxt(fe.getDefaultMessage()); //에러메세지 설정
				try {
					method = vo.getClass().getDeclaredMethod("set" + StringUtils.capitalize(fe.getField()), null); //setOOO메소드명으로 찾아서 메소드 객체 획득 
					method.invoke(cssVo); //setOOO메소드 실행
				} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException e) {
					logger.debug(e.getMessage());
				}
		}
	}

	//로그인ID중복체크화면 이동
	@RequestMapping(value="/customCompLoginIdCheck", method=RequestMethod.GET)
	public String customCompLoginIdCheckGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "custom/comp/customCompLoginIdCheck";
	}
	
	//로그인ID중복체크
	@RequestMapping(value="/customCompLoginIdCheck", method=RequestMethod.POST)
	public String customCompLoginIdCheckPost(
		@RequestParam(name="loginId", defaultValue="", required=true) String loginId,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		model.addAttribute("loginId", loginId);
		//isExist = true 아이디 중복
		if (customCompService.loginIdCheck(loginId)) {
			model.addAttribute("existLoginIdYN", "Y");
		} else {
			model.addAttribute("existLoginIdYN", "N");
		}
		return "custom/comp/customCompLoginIdCheck";
	}
	
	//사업자등록번호중복체크화면 이동
	@RequestMapping(value="/customCompCompanyNoCheck", method=RequestMethod.GET)
	public String customCompCompanyNoCheckGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "custom/comp/customCompCompanyNoCheck";
	}
	
	//사업자등록번호중복체크
	@RequestMapping(value="/customCompCompanyNoCheck", method=RequestMethod.POST)
	public String customCompCompanyNoCheckPost(@RequestParam(name="companyNo", defaultValue="", required=true) String companyNo, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		model.addAttribute("companyNo", companyNo);
		//isExist = true 아이디 중복
		if (customCompService.companyNoCheck(companyNo)) {
			model.addAttribute("existCompanyNoYN", "Y");
		} else {
			model.addAttribute("existCompanyNoYN", "N");
		}
		return "custom/comp/customCompCompanyNoCheck";
	}
	
	//이메일중복체크화면 이동
	@RequestMapping(value="/customCompEmailCheck", method=RequestMethod.GET)
	public String customCompEmailCheckGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "custom/comp/customCompEmailCheck";
	}
	
	//이메일중복체크
	@RequestMapping(value="/customCompEmailCheck", method=RequestMethod.POST)
	public String customCompEmailCheckPost(
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
		if (customCompService.emailCheck(email)) {
			model.addAttribute("existEmailYN", "Y");
		} else {
			model.addAttribute("existEmailYN", "N");
		}
		return "custom/comp/customCompEmailCheck";
	}
	
	//회원정보수정화면 이동
	@RequestMapping(value="/customCompUpdate", method=RequestMethod.GET)
	public String customCompUpdateGet(HttpServletRequest request, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		HttpSession session = request.getSession();
		int sCustomId = (int) session.getAttribute("sCustomId");
		
		//개별회원정보 조회
		CustomCompDTO compDto = customCompService.searchCustomComp(sCustomId);
		if (null == compDto) return "redirect:/msgCustomComp/LoginNo";//비회원화면으로 이동
		
		//Form출력 설정
		CustomCompEntryUpdateFormVO customCompVo = new CustomCompEntryUpdateFormVO();
		customCompVo.setCustomName(compDto.getCustom_nm());
		customCompVo.setCustomNameShort(compDto.getCustom_nm_short());
		customCompVo.setCompanyNo(compDto.getCompany_no());
		customCompVo.setCustomKindCode(String.valueOf(compDto.getCustom_kind_cd()));
		customCompVo.setPostcode(compDto.getPost_code());
		customCompVo.setRoadAddress(compDto.getRoad_addr());
		customCompVo.setExtraAddress(compDto.getExtra_addr());
		customCompVo.setDetailAddress(compDto.getDetail_addr());
		customCompVo.setMemo(compDto.getMemo());
		
		//Form출력 편집 설정
		//창립일
		System.out.println("compDto.getEstblDate() = " + compDto.getEstbl_date());		
		customCompVo.setEstblDate(compDto.getEstbl_date().substring(0, 10));

		//사무실 편집
		int startIdx = compDto.getOffice().indexOf(":") + 1;
		if ( -1 < startIdx ) {
			customCompVo.setTxtOffice(compDto.getOffice().substring(startIdx, compDto.getOffice().length()));
			customCompVo.setOffice("기타");
		} else {
			customCompVo.setOffice(compDto.getOffice());
		}
		
		//Email 분리(@)
		String[] email = compDto.getEmail().split("@");
		if (null == email || 2 > email.length) {
			customCompVo.setEmail("");
			customCompVo.setEmail1("");
			customCompVo.setEmail2("");
		} else {
			customCompVo.setEmail(compDto.getEmail());
			customCompVo.setEmail1(email[0]);
			customCompVo.setEmail2(email[1]);
		}
		
		//전화번호 분리(-) : 필수입력항목
		customCompVo.setTelNo(compDto.getTel_no());
		String[] tel = compDto.getTel_no().split("-");
		customCompVo.setTel1(tel[0]);
		customCompVo.setTel2(tel[1]);
		customCompVo.setTel3(tel[2]);
		
		//휴대전화 분리(-) : 선택입력항목
		String[] hp = compDto.getHp_no().split("-");
		if (null == hp || 3 > hp.length) {
			customCompVo.setHpNo("");
			customCompVo.setHp1("");
			customCompVo.setHp2("");
			customCompVo.setHp3("");
		} else {
			customCompVo.setHpNo(compDto.getHp_no());
			customCompVo.setHp1(hp[0]);
			customCompVo.setHp2(hp[1]);
			customCompVo.setHp3(hp[2]);
		}
		
		//customImgFileName
		customCompVo.setCustomImgFileName(compDto.getCustom_img_file_name());

		//기업고객정보수정FormVO 화면표시값 설정
		model.addAttribute("vo", customCompVo);

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
		return "custom/comp/customCompUpdate";
	}
	
	//회원정보수정
	@RequestMapping(value="/customCompUpdate", method=RequestMethod.POST)
	public String customCompUpdatePost(HttpSession session, MultipartFile fName, @Validated CustomCompEntryUpdateFormVO customCompVo, BindingResult bindRes, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		System.out.println("customCompVo.getPostcode() = " + customCompVo.getPostcode());			
		System.out.println("customCompVo.getValidatingPostcode() = " + customCompVo.getValidatingPostcode());			

		//고객사진 upload보관
		String orgFileName = this.getOrgFileName(fName);
		if (!orgFileName.equals("")) {
			ProjectSupport ps = new ProjectSupport();
			ps.writeFile(fName, orgFileName, "custom");
			
			// 기존에 존재하는 파일 삭제하기
			if(!customCompVo.getPhoto().equals("noimage.jpg")) {
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String uploadPath = "";
				uploadPath = request.getSession().getServletContext().getRealPath("/resources/custom/");
				File file = new File(uploadPath + customCompVo.getPhoto());
				file.delete();
			}
			
			// 기존파일을 지우고, 새로 업로드된 파일명을 set시킨다.
			customCompVo.setPhoto(orgFileName);
		} 
		
		String sLoginId = (String) session.getAttribute("sLoginId");
		String encryptPwd = customCompVo.getEncryptPwd();
		CustomCompLoginDTO loginDto = customCompService.searchLogin(sLoginId, encryptPwd);
		if (null == loginDto) return "redirect:/msgCustomComp/PwdNo";//회원정보수정화면으로 재이동-비밀번호 오류

		CustomCompDTO compDto = new CustomCompDTO();//기업고객 회원정보 VO
		compDto.setCustom_id(loginDto.getCustom_id());
		compDto.setCustom_nm(customCompVo.getCustomName());
		compDto.setCustom_nm_short(customCompVo.getCustomNameShort());
		compDto.setCustom_kind_cd(Integer.parseInt(customCompVo.getCustomKindCode()));
		compDto.setEstbl_date(customCompVo.getEstblDate());
		compDto.setCompany_no(customCompVo.getCompanyNo());
		compDto.setOffice(customCompVo.getOffice());
		compDto.setTxt_office(customCompVo.getTxtOffice());
		compDto.setTel_no(customCompVo.getTelNo());
		compDto.setHp_no(customCompVo.getHpNo());
		compDto.setEmail(customCompVo.getEmail());
		compDto.setPost_code(customCompVo.getValidatingPostcode());
		compDto.setRoad_addr(customCompVo.getRoadAddress());
		compDto.setExtra_addr(customCompVo.getExtraAddress());
		compDto.setDetail_addr(customCompVo.getDetailAddress());
		compDto.setMemo(customCompVo.getMemo());
		compDto.setCustom_img_file_name(customCompVo.getPhoto());

		customCompService.updateCustomComp(compDto);//기업고객 회원정보 DB 수정
//		if (1 == resComp) {
			model.addAttribute("sCustomName", customCompVo.getCustomName());//고객명
			return "redirect:/msgCustomComp/UpdateOk";
//		} else {
//			return "redirect:/msgCustomComp/UpdateNo";
//		}
	}
}