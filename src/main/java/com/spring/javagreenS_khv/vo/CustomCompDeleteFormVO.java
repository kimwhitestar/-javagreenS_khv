package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class CustomCompDeleteFormVO {
	private String loginId;
	private int customId;
	private String customName;
	private String companyNo;
	private int overDaysUserDel;//login삭제후 경과일
	private String overFlg;//login삭제후 30일 경과유무FLG 
	private String deleteDate;
	private String deleteUser;
	private String deleteDate2;
	private String deleteUser2;
}