package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class AdminLoginVO {
	private int idx;
	private String loginId;
	private String loginPwd;
	private String encryptPwd;
	private String level;
	private String levelName;
	private String loginDate;
	private String loginUser;
	private String logoutDate;
	private String logoutUser;
	private String createDate;
	private String createUser;
	private String updateDate;
	private String updateUser;
	private String deleteDate;
	private String deleteUser;
}