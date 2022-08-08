package com.spring.javagreenS_khv.vo;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;

import lombok.Data;

public @Data class CustomCompEntryUpdateFormVO {
	/**
	 * 기업고객회원정보(customComp)
	 */
	private int seq;
	private int customId;
	@Pattern(regexp="[가-힣a-zA-Z()]{3,10}([0-9]*)" ,	message="한글 또는 영문 3자리 이상으로 필요하면 숫자, 중괄호 조합 3~20자리로 입력하세요")
	private String customName; //기업명체크(한글or영문에 필요하면 숫자포함 조합 3~20자리)
	@Pattern(regexp="[가-힣a-zA-Z()]{3,10}([0-9]*)" , message="한글 또는 영문 3자리 이상으로 필요하면 숫자, 중괄호 조합 3~20자리로 입력하세요")
	private String customNameShort; //기업명(단축명칭)체크(한글or영문에 필요하면 숫자포함 조합 3~20자리)
	private int customKindGroupCode;
	private String kindGroupName;
	private String customKindCode;
	private String customKindName;
	private char customGrade;
	private String gradeName;
	private String estblDate;
	@Pattern(regexp="[0-9]{3}-[0-9]{2}-[0-9]{5}" , message="숫자-숫자-숫자로 입력하세요")
	private String companyNo; //사업자등록번호체크(숫자3자리-숫자2자리-숫자5자리)
	@Pattern(regexp="[기타:]{0,3}[가-힣a-zA-Z0-9]{0,100}" , message="한글 또는 영문 또는 숫자 2~100자리로 입력하세요")
	private String txtOffice; //사무실명체크(한글 또는 영문 또는 숫자 1~100자리)
	private String office;
	private String tel1;
	@Pattern(regexp="\\d{3,4}" , message="숫자 3자리~4자리로 입력하세요")
	private String tel2; //전화번호2체크(숫자 3~4자리)
	@Pattern(regexp="\\d{4}" , message="숫자 4자리로 입력하세요")
	private String tel3; //전화번호3체크(숫자 4자리)
	private String telNo;
	private String hp1;
	@Pattern(regexp="(\\d{4})|" , message="숫자 4자리로 입력하세요")
	private String hp2; //휴대폰번호2체크(숫자 4자리)
	@Pattern(regexp="(\\d{4})|" , message="숫자 4자리로 입력하세요")
	private String hp3; //휴대폰번호3체크(숫자 4자리)
	private String hpNo;
	@Pattern(regexp="^[a-zA-Z]{2}[0-9_+-.]*[a-zA-Z]([a-zA-Z0-9_+-.]*)$" , message="영문자 3자리 이상으로 필요하면 특수기호(_+-.), 숫자, 영문 조합 3~25자리로 입력하세요")
	private String email1; //이메일체크(영문자으로 시작하여 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
	private String email2;
	//@Pattern(regexp="[a-zA-Z][a-zA-Z0-9_+-]*[.][a-zA-Z0-9]([_+-.][a-zA-Z]|[a-zA-Z])" , message="도메인명은 영문자와 특수기호(_+-.), 숫자, 영문 조합 3~25자리까지 입력가능합니다")
	private String txtEmail2; //도메인체크(domain deep 2이상, 영문자와 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
	@Email(message="이메일 형식을 맞춰주세요")
	@Length(min=8, max=50, message="이메일은 8~50자리로 입력하세요")
	private String email;
	private String postcode;
	private String validatingPostcode;
	private String roadAddress;
	private String extraAddress;
	@Pattern(regexp="[a-zA-Z0-9가-힣#-. ]{1,50}" , message="한글 또는 영문에 필요하면 숫자, 특수문자( .-#) 포함하여 1~50자리로 입력하세요")
	private String detailAddress;//상세주소체크(한글or영문에 필요하면 숫자 또는 특수문자( .-#) 1~50자리)
	@Pattern(regexp="[a-zA-Z0-9가-힣]([@#$%^&!?]|[~()<>_*+-=]|[,.:;\\/]|[ ]*)" , message="문자, 숫자, 특수문자(~!?@#$%^&*()<>_+=-,.:;/ )의 조합 500자 이하로 입력하세요")
	private String memo;//메모 체크(숫자,문자,특수문자체크(~!?@#$%^&*()<>_+=-,.:;/ ) 조합 500자리)
	@Pattern(regexp="[a-zA-Z0-9가-힣_-~()+][.](JPG|JPEG|GIF|jpg|jpeg|gif)$" , message="문자,숫자,특수문자(_-~()+) 50자리의 화일명과 .jpg 또는 .jpeg 또는 .gif확장자만 가능합니다")
	private String customImgFileName; //화일명 체크(문자,숫자,특수문자(~()<>_*+-) 50자리의 화일명과 .JPG 또는 .JPEG 또는 .GIF확장자만 가능합니다)
	private String photo;
	private int overDaysUserDel; //회원탈퇴신청 후 30일 경과시 회원삭제처리
	private String createDate;
	private String createUser;
	private String updateDate;
	private String updateUser;
	private String deleteDate;
	private String deleteUser;

	/**
	 * 기업고객회원로그인정보(customCompLogin)
	 */
	@Pattern(regexp = "^[a-zA-Z]+[0-9_+-.]*[a-zA-Z_+-.]*[0-9]([a-zA-Z0-9_+-.]*)$" , message="영문자로 시작하여 숫자1자리 이상 포함하는 영문,숫자,특수기호(_+-.)의 조합 2~20자리로 입력하세요")
	private String loginId;//아이디체크(영문자1자리이상, 숫자나 특수기호 조합 2~20자리)
	private String loginPwd;
	private String encryptPwd;
	private int point;
	private int visitCnt;
	private int todayCnt;
	private String createDate2;
	private String createUser2;
	private String updateDate2;
	private String updateUser2;
	private String deleteDate2;
	private String deleteUser2;
	
	/* hibernate validator 체크
	 @Digits(Integer=, fraction=) : @숫자(정수, 소수이하자릿수)
	 @Past() : 과거 날짜?, @Future : 미래 날짜?
	 @Size() : 요청값 길이 체크
	 @Range() : 요청값 범위 체크
	
	@Email(message="이메일 형식을 맞춰주세요")
	@NotNull(message="아이디를 입력하세요?")
	@Length(min=4, max=20, message="아이디는 4자 ~ 20글자로 입력하세요")
	@Pattern(regexp = "", message="입력규칙위반")
	@Range(min=20, max=99, message="나이는 20~99세까지 가입 가능합니다")
	private String mid;
	 */
}