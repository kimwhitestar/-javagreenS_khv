package com.spring.javagreenS_khv.vo;

import lombok.Data;

/*
 * 개인고객회원 대시보드, 통계 조회
 */
public @Data class CustomPersonSearchVO {
	/**
	 * 개인고객회원정보(customPerson)
	 */
	private int seq;
	private int customId;
	private String customName;
	private String customKindCode;
	private String customKindName;
	private String customGrade;
	private String gradeName;
	private int customKindGroupCode;
	private String kindGroupName;
	private String birthDate;
	private String juminNo;
	private String job;
	private String hobby;
	private String gender;
	private String telNo;
	private String hpNo;
	private String email;
	private String postcode;
	private String roadAddress;
	private String extraAddress;
	private String detailAddress;
	private String memo;
	private int overDaysUserDel;
	private String createDate;
	private String createUser;
	private String updateDate;
	private String updateUser;
	private String deleteDate;
	private String deleteUser;
	
	/**
	 * 개인고객회원로그인정보(customPersonLogin)
	 */
	private int seq2;
	private String loginId;
	private String loginPwd;
	private String encryptPwd;
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