package com.spring.javagreenS_khv.vo;

import javax.validation.constraints.Pattern;

import lombok.Data;

public @Data class CustomPersonEntryUpdateFormVO {
	//개인고객회원정보
	private int seq;
	private int customId;
	private String customName;
	private int customKindGroupCode;
	private String kindGroupName;
	private String customKindCode;
	private String kindName;
	private char customGrade;
	private String gradeName;
	private String job;
	private String txtJob;
	private String hobby;
	private String checkedHobbies;
	private String birthDate;
	private String juminNo;
	private String gender;
	private String tel1;
	@Pattern(regexp="/\\d{3,4}$/g"
			, message="숫자 3자리~4자리로 입력하세요")
	private String tel2; //전화번호2체크(숫자 3~4자리)
	@Pattern(regexp="/\\d{4}$/g"
			, message="숫자 4자리로 입력하세요")
	private String tel3; //전화번호3체크(숫자 4자리)
	private String telNo;
	private String hp1;
	@Pattern(regexp="/\\d{4}$/g"
			, message="숫자 4자리로 입력하세요")
	private String hp2; //휴대폰번호2체크(숫자 4자리)
	@Pattern(regexp="/\\d{4}$/g"
			, message="숫자 4자리로 입력하세요")
	private String hp3; //휴대폰번호3체크(숫자 4자리)
	private String hpNo;
	@Pattern(regexp="/^[a-zA-Z]{2}[0-9_+-.]*[a-zA-Z]([a-zA-Z0-9_+-.]*)$/g"
			, message="영문자 3자리 이상으로 필요하면 특수기호(_+-.), 숫자, 영문 조합 3~25자리로 입력하세요")
	private String email1; //이메일체크(영문자으로 시작하여 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
	private String email2;
	@Pattern(regexp="/[a-zA-Z][0-9]*[_+-.][a-zA-Z0-9]([_+-.][a-zA-Z]|[a-zA-Z])/g"
			, message="도메인명은 영문자와 특수기호(_+-.), 숫자, 영문 조합 3~25자리까지 입력가능합니다")
	private String txtEmail2; //도메인체크(domain deep 2이상, 영문자와 특수기호 _+-. 또는 숫자 또는 문자 조합 3~25자리)
	private String email;
	private String validatingPostcode;
	private String postcode;
	private String roadAddress;
	private String extraAddress;
	private String detailAddress;
	private String memo;
	private String createDate;
	private String createUser;
	private String updateDate;
	private String updateUser;
	private String deleteDate;
	private String deleteUser;
	private int overDaysUserDel; //회원삭제신청 경과일(30일 경과시 회원탈퇴처리)
	//개인고객회원로그인정보
	private String loginId;
	private String loginPwd;
	private String encryptPwd;
	private int point;
	private int visitCnt;
	private int todayCnt;
}