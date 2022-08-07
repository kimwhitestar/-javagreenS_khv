package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class AdminVO {
	private int seq;
	private String level;
	private String levelName;
	private int memberId;
	private String memberName;
	private String gender;
	private String juminNo;
	private String birthday;
	private String tel;
	private String hp;
	private String email;
	private String postcode;
	private String roadAddr;
	private String extraAddr;
	private String detailAddr;
	private String content;
	private String photo;
	private String hireDate;
	private String resignDate;
	private String createDate;
	private String createUser;
	private String updateDate;
	private String updateUser;
	private String deleteDate;
	private String deleteUser;
}