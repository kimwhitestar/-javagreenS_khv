package com.spring.javagreenS_khv;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_khv.dto.CustomCompDeleteDTO;
import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.dto.CustomGradeDTO;
import com.spring.javagreenS_khv.dto.CustomPersonDeleteDTO;
import com.spring.javagreenS_khv.dto.CustomPersonLoginDTO;
import com.spring.javagreenS_khv.service.AdminService;
import com.spring.javagreenS_khv.service.CustomGradeService;
import com.spring.javagreenS_khv.service.FlgSummaryService;
import com.spring.javagreenS_khv.vo.AdminLoginVO;
import com.spring.javagreenS_khv.vo.CustomCompDeleteFormVO;
import com.spring.javagreenS_khv.vo.CustomCompSearchVO;
import com.spring.javagreenS_khv.vo.CustomGradeVO;
import com.spring.javagreenS_khv.vo.CustomPersonDeleteFormVO;
import com.spring.javagreenS_khv.vo.CustomPersonSearchVO;
import com.spring.javagreenS_khv.vo.CustomStatsVO;
import com.spring.javagreenS_khv.vo.FlgSummaryVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	public AdminService adminService;
	
	@Autowired
	public CustomGradeService customGradeService;
	
	@Autowired
	public FlgSummaryService flgSummaryService;
	
//	@Autowired
//	public BCryptPasswordEncoder bCrypt;
	
	//로그인화면 이동
	@RequestMapping(value="/adminLogin", method=RequestMethod.GET)
	public String adminLoginGet(HttpServletRequest request) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "admin/adminLogin";
	}
	
	//로그인
	@RequestMapping(value="/adminLogin", method=RequestMethod.POST)
	public String adminLoginPost(HttpSession session, AdminLoginVO adminLoginVo, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		AdminLoginVO vo = adminService.searchAdminLogin(adminLoginVo.getLoginId(), adminLoginVo.getEncryptPwd());
		if (null == vo) {
			return "redirect:/msgAdmin/LoginNo";
		}
		model.addAttribute("vo", vo);
		
		//로그인 아이디,비밀번호로 회원조회가 됬을 경우, HttpSession에 조회된 회원정보 설정
		session.setAttribute("sLoginId", vo.getLoginId());
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("sLevelName", vo.getLevelName());
		return "redirect:/msgAdmin/LoginOk";
	}
	
	//로그아웃
	@RequestMapping(value="/adminLogout", method=RequestMethod.GET)
	public String adminLogoutGet(HttpSession session, Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		String sLoginId = (String)session.getAttribute("sLoginId");
		String sLevelName = (String)session.getAttribute("sLevelName");
		
		adminService.updateLogout(sLoginId);//DB 로그아웃정보 수정
		
//		if (1 == res) {
			session.invalidate();//세션삭제
			model.addAttribute("levelName", sLevelName);
			return "redirect:/msgAdmin/LogoutOk";

//		} else {
//			return "redirect:/msgAdmin/LogoutNo";
//		}
			
	}

	//기업고객 고객등급수정목록화면 이동
	@RequestMapping(value="/customCompGradeUpdateList", method=RequestMethod.GET)
	public String customCompGradeUpdateListGet(
		@RequestParam(name="customGrade", defaultValue="", required=false) String customGrade, 
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		return customCompGradeUpdateListPost(customGrade, model);
	}

	//기업고객 고객등급수정목록화면 - 조회
	@RequestMapping(value="/customCompGradeUpdateList", method=RequestMethod.POST)
	public String customCompGradeUpdateListPost(
		@RequestParam(name="customGrade", defaultValue="", required=false) String customGrade,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		/*포인트flag 획득 (NONE:전체|1000:1,000P+|5000:5,000P+|50000:50,000P+|500000:500,000P+)*/
		FlgSummaryVO pointFlgVo = flgSummaryService.searchFlg("POINT_FLG", "000", "110");
		model.addAttribute("pointFlgVo", pointFlgVo);
		
		//기업고객 등급코드목록
		List<CustomGradeVO> customGradeVos = new ArrayList<>();
		CustomGradeVO customGradeVo	= null;
		List<CustomGradeDTO> customGradeDtoList = customGradeService.searchCustomCompGradeList();//A:우수기업고객|B:정규기업고객|C:일반기업고객|O:임시기업고객
		for (CustomGradeDTO customGradeDto : customGradeDtoList) {
			customGradeVo = new CustomGradeVO();
			customGradeVo.setCustomGradeCd(customGradeDto.getGrade_code());
			customGradeVo.setCustomGradeNm(customGradeDto.getGrade_name());
			customGradeVos.add(customGradeVo);
		}
		model.addAttribute("customGradeVos", customGradeVos);
		model.addAttribute("customGrade", customGrade);
		
		/*차라리 CRUD 각자 기능화면별로 VO, DTO(이것도 생략)를 갖는게 좋은 것 같다. 
		 *아무리 model bean 재사용이라지만, table마다 dto를 만든다는 것은 부적절하기 그지없다. 절대 이러지말자. 
		 *DATA정확성(외래키조건검색이 아닐경우)과 속도향상에도 전혀 도움이 안된다. 차라리 조회기능을 재사용하자. 하지만, 이미 다 해놓은게 있어서 다 바꾸기가 벅차다.. 이번에만 그냥 두자ㅜㅜ.. db정렬 맞춰야하는데.. 헐..이게뭐야*/
		//List<CustomCompDTO> dto1 = adminService.searchCustomComp(customGrade);  
		//List<CustomCompLoginDTO> dto2 = adminService.searchCustomCompLogin(customGrade);  
		
		List<CustomCompSearchVO> vos = adminService.searchCustomCompJoinList(customGrade);  
		if (null == vos || 0 == vos.size()) {
			model.addAttribute("vos", null);
			return "admin/customCompGradeUpdateList";
		}
		model.addAttribute("vos", vos);

		return "admin/customCompGradeUpdateList";
	}	
	
	//기업고객 고객등급수정
	@RequestMapping(value="/customCompGradeUpdate", method=RequestMethod.POST)
	public String customCompGradeUpdatePost(
		@RequestParam(name="updateCustomId", required=false) String[] updateCustomId,
		@RequestParam(name="updateCustomGradeCd", required=false) String[] updateCustomGradeCd,
		@RequestParam(name="onceUpdateCustomId", defaultValue="", required=false) String onceUpdateCustomId,
		@RequestParam(name="onceUpdateCustomGradeCd", required=false) String onceUpdateCustomGradeCd,
		@RequestParam(name="customGrade", defaultValue="", required=false) String customGrade,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		if (!onceUpdateCustomId.isEmpty() && !onceUpdateCustomGradeCd.isEmpty()) {
			adminService.updateCustomCompGrade(onceUpdateCustomId, onceUpdateCustomGradeCd);
			model.addAttribute("customGrade", customGrade);
			return "redirect:/msgAdmin/CompGradeUpdateOk";
		} 
		int idx = 0;
		for (String customId : updateCustomId) {
			adminService.updateCustomCompGrade(customId, updateCustomGradeCd[idx]);
			idx++;
		}
		model.addAttribute("customGrade", customGrade);
		return "redirect:/msgAdmin/CompGradeUpdateNo";
	}
	
	//개인고객 고객등급수정목록화면 이동
	@RequestMapping(value="/customPersonGradeUpdateList", method=RequestMethod.GET)
	public String customPersonGradeUpdateListGet(
		@RequestParam(name="customGrade", defaultValue="", required=false) String customGrade, 
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return customPersonGradeUpdateListPost(customGrade, model);
	}

	//개인고객 고객등급수정목록화면 - 조회
	@RequestMapping(value="/customPersonGradeUpdateList", method=RequestMethod.POST)
	public String customPersonGradeUpdateListPost(
		@RequestParam(name="customGrade", defaultValue="", required=false) String customGrade,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		//기업고객 등급코드목록
		List<CustomGradeVO> customGradeVos = new ArrayList<>();
		CustomGradeVO customGradeVo	= null;
		List<CustomGradeDTO> customGradeDtoList = customGradeService.searchCustomPersonGradeList();//S:우수개인고객|R:정규개인고객|Q:일반개인고객|P:임시개인고객
		for (CustomGradeDTO customGradeDto : customGradeDtoList) {
			customGradeVo = new CustomGradeVO();
			customGradeVo.setCustomGradeCd(customGradeDto.getGrade_code());
			customGradeVo.setCustomGradeNm(customGradeDto.getGrade_name());
			customGradeVos.add(customGradeVo);
		}
		model.addAttribute("customGradeVos", customGradeVos);
		model.addAttribute("customGrade", customGrade);
		
		List<CustomCompSearchVO> vos = adminService.searchCustomPersonJoinList(customGrade);  
		if (null == vos || 0 == vos.size()) {
			model.addAttribute("vos", null);
			return "admin/customPersonGradeUpdateList";
		}
		model.addAttribute("vos", vos);

		return "admin/customPersonGradeUpdateList";
	}	
	
	//개인고객 고객등급수정
	@RequestMapping(value="/customPersonGradeUpdate", method=RequestMethod.POST)
	public String customPersonGradeUpdatePost(
		@RequestParam(name="updateCustomId", required=false) String[] updateCustomId,
		@RequestParam(name="updateCustomGradeCd", required=false) String[] updateCustomGradeCd,
		@RequestParam(name="onceUpdateCustomId", defaultValue="", required=false) String onceUpdateCustomId,
		@RequestParam(name="onceUpdateCustomGradeCd", required=false) String onceUpdateCustomGradeCd,
		@RequestParam(name="customGrade", defaultValue="", required=false) String customGrade,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		if (!onceUpdateCustomId.isEmpty() && !onceUpdateCustomGradeCd.isEmpty()) {
			adminService.updateCustomPersonGrade(onceUpdateCustomId, onceUpdateCustomGradeCd);
			model.addAttribute("customGrade", customGrade);
			return "redirect:/msgAdmin/PersonGradeUpdateOk";
		} 
		int idx = 0;
		for (String customId : updateCustomId) {
			adminService.updateCustomPersonGrade(customId, updateCustomGradeCd[idx]);
			idx++;
		}
		model.addAttribute("customGrade", customGrade);
		return "redirect:/msgAdmin/PersonGradeUpdateNo";
	}
	
	//기업고객회원탈퇴목록화면 이동
	@RequestMapping(value="/customCompDeletePracList", method=RequestMethod.GET)
	public String customCompDeletePracListGet(
		@RequestParam(name="overFlg", defaultValue="NONE", required=false) String overFlg,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		return customCompDeletePracListPost(overFlg, model);
	}

	//기업고객회원탈퇴목록화면 - 조회
	@RequestMapping(value="/customCompDeletePracList", method=RequestMethod.POST)
	public String customCompDeletePracListPost(
		@RequestParam(name="overFlg", defaultValue="NONE", required=false) String overFlg,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		/*회원탈퇴후 30일 경과여부 flag 획득 (NONE:해당안됨|OVER:30일경과|PRAC:30일미경과)*/
		FlgSummaryVO flgSummaryVo = flgSummaryService.searchFlg("DELETE_OVER_FLG", "000", "180");
		model.addAttribute("delOverFlgVo", flgSummaryVo);
		
		//한 페이징에 표시할 레코드 검색
		List<CustomCompDeleteDTO> dtos = adminService.searchCustomCompDeleteList(overFlg);
		if (null == dtos || 0 == dtos.size()) {
			model.addAttribute("vos", null);
			model.addAttribute("overFlg", overFlg);
			return "admin/customCompDeletePracList";
		}
		
		List<CustomCompDeleteFormVO> vos = new ArrayList<>();
		CustomCompDeleteFormVO compDelVo = null;
		for (CustomCompDeleteDTO compDelDto : dtos) {
			//Form출력 설정
			compDelVo = new CustomCompDeleteFormVO();
			compDelVo.setLoginId(compDelDto.getLogin_id());
			compDelVo.setCustomId(compDelDto.getCustom_id());
			compDelVo.setCustomName(compDelDto.getCustom_nm());
			compDelVo.setCompanyNo(compDelDto.getCompany_no());
			compDelVo.setOverDaysUserDel(compDelDto.getOver_days_user_del());
			compDelVo.setOverFlg(compDelDto.getOver_flg());
			compDelVo.setDeleteDate(compDelDto.getDelete_date());
			compDelVo.setDeleteUser(compDelDto.getDelete_user());
			vos.add(compDelVo);
		}
		model.addAttribute("vos", vos);
		model.addAttribute("overFlg", overFlg);
		
		return "admin/customCompDeletePracList";
	}
	
	
	
	
	
	
	//개인고객회원탈퇴목록화면 이동
	@RequestMapping(value="/customPersonDeletePracList", method=RequestMethod.GET)
	public String customPersonDeletePracListGet(
		@RequestParam(name="overFlg", defaultValue="NONE", required=false) String overFlg,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		return customPersonDeletePracListPost(overFlg, model);
	}
	
	//개인고객회원탈퇴목록화면 - 조회
	@RequestMapping(value="/customPersonDeletePracList", method=RequestMethod.POST)
	public String customPersonDeletePracListPost(
		@RequestParam(name="overFlg", defaultValue="NONE", required=false) String overFlg,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		/*회원탈퇴후 30일 경과여부 flag 획득 (NONE:해당안됨|OVER:30일경과|PRAC:30일미경과)*/
		FlgSummaryVO flgSummaryVo = flgSummaryService.searchFlg("DELETE_OVER_FLG", "000", "180");
		model.addAttribute("delOverFlgVo", flgSummaryVo);
		
		
		//한 페이징에 표시할 레코드 검색
		List<CustomPersonDeleteDTO> dtos = adminService.searchCustomPersonDeleteList(overFlg);
		if (null == dtos || 0 == dtos.size()) {
			model.addAttribute("vos", null);
			model.addAttribute("overFlg", overFlg);
			return "admin/customPersonDeletePracList";
		}
		
		List<CustomPersonDeleteFormVO> vos = new ArrayList<>();
		CustomPersonDeleteFormVO personDelVo = null;
		for (CustomPersonDeleteDTO personDelDto : dtos) {
			//Form출력 설정
			personDelVo = new CustomPersonDeleteFormVO();
			personDelVo.setLoginId(personDelDto.getLogin_id());
			personDelVo.setCustomId(personDelDto.getCustom_id());
			personDelVo.setCustomName(personDelDto.getCustom_nm());
			personDelVo.setBirthDate(personDelDto.getBirth_date());
			personDelVo.setOverDaysUserDel(personDelDto.getOver_days_user_del());
			personDelVo.setOverFlg(personDelDto.getOver_flg());
			personDelVo.setDeleteDate(personDelDto.getDelete_date());
			personDelVo.setDeleteUser(personDelDto.getDelete_user());
			vos.add(personDelVo);
		}
		model.addAttribute("vos", vos);
		model.addAttribute("overFlg", overFlg);
		return "admin/customPersonDeletePracList";
	}
	
	//기업고객 탈퇴회원신청자 회원삭제(탈퇴신청 1개월차)
	@RequestMapping(value="/customCompDeletePrac", method=RequestMethod.POST)
	public String customCompDeletePracPost(
		@RequestParam(name="delCustomId", required=false) String[] delCustomId,
		@RequestParam(name="onceDelCustomId", defaultValue="", required=false) String onceDelCustomId,
		@RequestParam(name="overFlg", defaultValue="NONE", required=false) String overFlg,
		Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		if (!onceDelCustomId.isEmpty()) {
			adminService.deleteCustomCompDelete(onceDelCustomId);
			model.addAttribute("overFlg", overFlg);
			return "redirect:/msgAdmin/CompDeleteOk";
		}
		for (String customId : delCustomId) {
			adminService.deleteCustomCompDelete(customId);
		}
		model.addAttribute("overFlg", overFlg);
		return "redirect:/msgAdmin/CompDeleteOk";
	}

	//개인고객 탈퇴회원신청자 회원삭제(탈퇴신청 1개월차)
	@RequestMapping(value="/customPersonDeletePrac", method=RequestMethod.POST)
	public String customPersonDeletePracPost(
		@RequestParam(name="delCustomId", required=false) String[] delCustomId,
		@RequestParam(name="onceDelCustomId", defaultValue="", required=false) String onceDelCustomId,
		@RequestParam(name="overFlg", defaultValue="NONE", required=false) String overFlg,
		Model model) {
		
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		
		if (!onceDelCustomId.isEmpty()) {
			adminService.deleteCustomPersonDelete(onceDelCustomId);
			model.addAttribute("overFlg", overFlg);
			return "redirect:/msgAdmin/PersonDeleteOk";
		}
		
		for (String customId : delCustomId) {
			adminService.deleteCustomPersonDelete(customId);
		}
		
		model.addAttribute("overFlg", overFlg);
		return "redirect:/msgAdmin/PersonDeleteOk";
	}
	
	
	
	//기업고객회원통계화면 이동
	@RequestMapping(value="/customCompStats", method=RequestMethod.GET)
	public String customCompStatsGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "admin/customCompStats";
	}
	
	//기업고객회원통계화면 이동
	@ResponseBody
	@RequestMapping(value="/customCompStats", method=RequestMethod.POST)
	public List<CustomStatsVO>[] customCompStatsPost() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		
		List<CustomStatsVO>[] statsComp = new ArrayList[8];
		
		//기간별(년월) 가입회원 통계
		statsComp[0] = adminService.searchEntryCustomCompStatsList();

		//고객구분별 가입회원 통계
		statsComp[1] = adminService.searchEntryCustomCompStatsList1();
		
		//고객등급별 가입회원 통계
		statsComp[2] = adminService.searchEntryCustomCompStatsList2();
		
		//기간별(년월) 삭제회원 통계
		statsComp[3] = adminService.searchDeleteCustomCompStatsList();

		//고객구분별 삭제회원 통계
		statsComp[4] = adminService.searchDeleteCustomCompStatsList1();
		
		//고객등급별 삭제회원 통계
		statsComp[5] = adminService.searchDeleteCustomCompStatsList2();
		
		//고객구분별 가입회원수, 삭제회원수 통계
		statsComp[6] = adminService.searchEntryAndDeleteCustomCompStatsList1();

		//고객등급별 가입회원수, 삭제회원수 통계
		statsComp[7] = adminService.searchEntryAndDeleteCustomCompStatsList2();

		return statsComp;
	}

	//개인고객회원통계화면 이동
	@RequestMapping(value="/customPersonStats", method=RequestMethod.GET)
	public String customPersonStatsGet() {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명
		return "admin/customPersonStats";
	}
	
	//개인고객회원통계화면 이동
	@ResponseBody
	@RequestMapping(value="/customPersonStats", method=RequestMethod.POST)
	public List<CustomStatsVO>[] customPersonStatsPost() {
		
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		List<CustomStatsVO>[] statsPerson = new ArrayList[8];
		
		//기간별(년월) 가입회원 통계
		statsPerson[0] = adminService.searchEntryCustomPersonStatsList();

		//고객구분별 가입회원 통계
		statsPerson[1] = adminService.searchEntryCustomPersonStatsList1();
		
		//고객등급별 가입회원 통계
		statsPerson[2] = adminService.searchEntryCustomPersonStatsList2();
		
		//기간별(년월) 삭제회원 통계
		statsPerson[3] = adminService.searchDeleteCustomPersonStatsList();

		//고객구분별 삭제회원 통계
		statsPerson[4] = adminService.searchDeleteCustomPersonStatsList1();
		
		//고객등급별 삭제회원 통계
		statsPerson[5] = adminService.searchDeleteCustomPersonStatsList2();

		//고객구분별 가입회원수, 삭제회원수 통계
		statsPerson[6] = adminService.searchEntryAndDeleteCustomPersonStatsList1();

		//고객등급별 가입회원수, 삭제회원수 통계
		statsPerson[7] = adminService.searchEntryAndDeleteCustomPersonStatsList2();


//		// Json type으로 출력(전송) { key : value, key : value } //return void
//		PrintWriter out = response.getWriter();
//		out.println("{\"orgFName\":\""+orgFName+"\",\"uploaded\":1, \"url\":\""+fileUrl+"\"}");
//		out.flush();
		
//		JSONArray jsonArray = new JSONArray();
//		model.addAttribute("jsonList", jsonArray.fromObject(statsComp[3]));//JSONArray <- List<Map>
//		jsp에서 let json = JSON.parse('${jsonList}');
		
		return statsPerson;
	}
	
	//관리자 메인화면 (차후 기업고객,개인고객서비스검색으로 수정함)
	@RequestMapping(value="/adminIndex", method=RequestMethod.GET)
	public String adminIndexGet(Model model) {
		logger.info("[" + new Object(){}.getClass().getEnclosingMethod().getName() + "]"); //현재 실행중인 메소드명

		/* 기업고객 대시보드 목록 조회 */
		CustomCompSearchVO compVo = null;
		//신규회원가입한 목록 - 가입일 1개월차
		List<CustomCompLoginDTO> compRecentlyEntryDtoList = adminService.searchRecentlyEntryCustomCompList();
		List<CustomCompSearchVO> compRecentlyEntryVoList = new ArrayList<>(); 
		//최근접속회원목록
		List<CustomCompLoginDTO> compRecentlyLoginDtoList = adminService.searchRecentlyLoginCustomCompList();
		List<CustomCompSearchVO> compRecentlyLoginVoList = new ArrayList<>(); 
		//탈퇴회원목록 - 회원삭제대상자(임시탈퇴유지기간 30일을 경과한 회원)
		List<CustomCompLoginDTO> compPracDeleteDtoList = adminService.searchPracDeleteCustomCompList();
		List<CustomCompSearchVO> compPracDeleteVoList = new ArrayList<>(); 

		/* 개인고객 대시보드 목록 조회 */
		CustomPersonSearchVO personVo = null;
		//신규회원가입한 목록 - 가입일 1개월차
		List<CustomPersonLoginDTO> personRecentlyEntryDtoList = adminService.searchRecentlyEntryCustomPersonList();
		List<CustomPersonSearchVO> personRecentlyEntryVoList = new ArrayList<>(); 
		//최근접속회원목록
		List<CustomPersonLoginDTO> personRecentlyLoginDtoList = adminService.searchRecentlyLoginCustomPersonList();
		List<CustomPersonSearchVO> personRecentlyLoginVoList = new ArrayList<>(); 
		//탈퇴회원목록 - 회원삭제대상자(임시탈퇴유지기간 30일을 경과한 회원)
		List<CustomPersonLoginDTO> personPracDeleteDtoList = adminService.searchPracDeleteCustomPersonList();
		List<CustomPersonSearchVO> personPracDeleteVoList = new ArrayList<>(); 
		
		
		for (CustomCompLoginDTO compDto : compRecentlyEntryDtoList) {
			compVo = new CustomCompSearchVO();
			compVo.setLoginId(compDto.getLogin_id());
			compVo.setCustomNameShort(compDto.getCustom_nm_short());
			compVo.setCustomKindName(compDto.getCustom_kind_nm());
			compVo.setCreateDate(compDto.getCreate_date());
			compRecentlyEntryVoList.add(compVo);
		}
		for (CustomCompLoginDTO compDto : compRecentlyLoginDtoList) {
			compVo = new CustomCompSearchVO();
			compVo.setLoginId(compDto.getLogin_id());
			compVo.setCustomNameShort(compDto.getCustom_nm_short());
			compVo.setCustomKindName(compDto.getCustom_kind_nm());
			compVo.setLoginDate(compDto.getLogin_date());
			compRecentlyLoginVoList.add(compVo);
		}
		for (CustomCompLoginDTO compDto : compPracDeleteDtoList) {
			compVo = new CustomCompSearchVO();
			compVo.setLoginId(compDto.getLogin_id());
			compVo.setCustomNameShort(compDto.getCustom_nm_short());
			compVo.setCustomKindName(compDto.getCustom_kind_nm());
			compVo.setDeleteDate(compDto.getDelete_date());
			compPracDeleteVoList.add(compVo);
		}
		for (CustomPersonLoginDTO personDto : personRecentlyEntryDtoList) {
			personVo = new CustomPersonSearchVO();
			personVo.setLoginId(personDto.getLogin_id());
			personVo.setCustomName(personDto.getCustom_nm());
			personVo.setCustomKindName(personDto.getCustom_kind_nm());
			personVo.setCreateDate(personDto.getCreate_date());
			personRecentlyEntryVoList.add(personVo);
		}
		for (CustomPersonLoginDTO personDto : personRecentlyLoginDtoList) {
			personVo = new CustomPersonSearchVO();
			personVo.setLoginId(personDto.getLogin_id());
			personVo.setCustomName(personDto.getCustom_nm());
			personVo.setCustomKindName(personDto.getCustom_kind_nm());
			personVo.setLoginDate(personDto.getLogin_date());
			personRecentlyLoginVoList.add(personVo);
		}
		for (CustomPersonLoginDTO personDto : personPracDeleteDtoList) {
			personVo = new CustomPersonSearchVO();
			personVo.setLoginId(personDto.getLogin_id());
			personVo.setCustomName(personDto.getCustom_nm());
			personVo.setCustomKindName(personDto.getCustom_kind_nm());
			personVo.setDeleteDate(personDto.getDelete_date());
			personPracDeleteVoList.add(personVo);
		}
		model.addAttribute("compRecentlyEntryVoList", compRecentlyEntryVoList);
		model.addAttribute("compRecentlyLoginVoList", compRecentlyLoginVoList);
		model.addAttribute("compPracDeleteVoList", compPracDeleteVoList);
		model.addAttribute("personRecentlyEntryVoList", personRecentlyEntryVoList);
		model.addAttribute("personRecentlyLoginVoList", personRecentlyLoginVoList);
		model.addAttribute("personPracDeleteVoList", personPracDeleteVoList);
		
		return "admin/adminIndex";
	}
}