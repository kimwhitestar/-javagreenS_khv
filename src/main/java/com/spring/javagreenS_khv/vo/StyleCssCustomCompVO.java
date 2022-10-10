package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class StyleCssCustomCompVO {
	/* 기업고객회원정보(customComp) */
	private StyleCssVO customName; //기업명체크
	private StyleCssVO customNameShort; //기업명(단축명칭)
	private StyleCssVO customKindCode; //고객구분코드
	private StyleCssVO estblDate; //창립일
	private StyleCssVO companyNo; //사업자등록번호체크
	private StyleCssVO office; //사무실명
	private StyleCssVO tel2; //전화번호2
	private StyleCssVO tel3; //전화번호3
	private StyleCssVO hp2; //휴대폰번호2체크
	private StyleCssVO hp3; //휴대폰번호3체크
	private StyleCssVO email1; //이메일
	private StyleCssVO txtEmail2; //기타도메인 firstMethod -7번째 알파벳 't'
	private StyleCssVO detailAddress;//상세주소
	private StyleCssVO memo;//메모
	private StyleCssVO customImgFileName; //프로필사진
	/* 기업고객회원로그인정보(customCompLogin) */
	private StyleCssVO loginId; //로그인 아이디
	private StyleCssVO loginPwd; //로그인 비밀번호
}