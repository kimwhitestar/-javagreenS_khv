package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class CustomPersonLoginVO {
	private String loginId;//아이디체크(영문자1자리이상, 숫자나 특수기호 조합 2~20자리)
	private String loginPwd;//
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
}