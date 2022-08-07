package com.spring.javagreenS_khv.vo;

import lombok.Data;

/**
 * 기업고객회원 대시보드, 통계, 회원레벨, 회원목록 조회
 */
public @Data class CustomCompSearchVO {
	
	/**
	 * 기업고객회원정보(customComp)
	 */
	private int seq;
	private int customId;
	private String customName;
	private String customNameShort;
	private String customKindCode;
	private String customKindName;
	private String customGrade;
	private String gradeName;
	private int customKindGroupCode;
	private String kindGroupName;
	private String estblDate;
	private String companyNo;
	private String office;
	private String telNo;
	private String hpNo;
	private String email;
	private String postcode;
	private String roadAddress;
	private String extraAddress;
	private String detailAddress;
	private String memo;
	private String customImgFileName;
	private String photo;
	private int overDaysUserDel;
	private String createDate;
	private String createUser;
	private String updateDate;
	private String updateUser;
	private String deleteDate;
	private String deleteUser;

	/**
	 * 기업고객회원로그인정보(customCompLogin)
	 */
	private int seq2;
	private String loginId;
	private String loginPwd;
	private String encryptPwd;
	private String address; //회사소개-카카오맵용(도로명)
	private int point;
	private int visitCnt;
	private int todayCnt;
	private String overFlg; //history통계용
	private String loginDate;
	private String loginUser;
	private String logoutDate;
	private String logoutUser;
	private String createDate2;
	private String createUser2;
	private String updateDate2;
	private String updateUser2;
	private String deleteDate2;
	private String deleteUser2;
}