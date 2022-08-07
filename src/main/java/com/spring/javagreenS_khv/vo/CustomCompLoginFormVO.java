package com.spring.javagreenS_khv.vo;

import javax.validation.constraints.Size;

import lombok.Data;

public @Data class CustomCompLoginFormVO {
	/**
	 * 기업고객회원로그인정보(customCompLogin)
	 */
	@Size(min = 2, max=20, message="2자~20자로 입력하세요")
	private String loginId;//아이디체크(영문자1자리이상, 숫자나 특수기호 조합 2~20자리)
	@Size(min = 3, max=20, message="3자~20자로 입력하세요")
	private String loginPwd;//비밀번호체크(영문자,숫자,특수기호 @#$%&!?^~*+-_. 조합 3~20자리)
	private String encryptPwd;
	private int customId;
	private String customName;
	private String customGrade;
	private String gradeName;
	private int point;
	private int visitCnt;
	private int todayCnt;
	private String loginDate;
	private String logoutDate;
	private String createDate;
	private String updateDate;
	private String updateUser;
	private String deleteDate;
	private String deleteUser;
	/* hibernate validator 체크
	 @Digits(Integer=, fraction=) : @숫자(정수, 소수이하자릿수)
	 @Past() : 과거 날짜?, @Future : 미래 날짜?
	 @Size() : 요청값 길이 체크
	 @Range() : 요청값 범위 체크
	
	@NotNull(message="아이디를 입력하세요?")
	@Length(min=4, max=20, message="아이디는 4자 ~ 20글자로 입력하세요")
	@Pattern(regexp = "", message="입력규칙위반")
	@Range(min=20, max=99, message="나이는 20~99세까지 가입 가능합니다")
	private String mid;
	 */

}