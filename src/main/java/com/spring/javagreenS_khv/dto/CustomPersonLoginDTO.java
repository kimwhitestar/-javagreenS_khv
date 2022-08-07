package com.spring.javagreenS_khv.dto;

import lombok.Data;

public @Data class CustomPersonLoginDTO {
	private int seq;
	private String login_id;
	private String login_pwd;
	private String encrypt_pwd;
	private int custom_id;
	private String custom_nm;
	private int custom_kind_cd;
	private String custom_kind_nm;
	private String custom_grade;
	private String grade_name;
	private int point;
	private int visit_cnt;
	private int today_cnt;
	private String login_date;
	private String login_user;
	private String logout_date;
	private String logout_user;
	private String create_date;
	private String create_user;
	private String update_date;
	private String update_user;
	private String delete_date;
	private String delete_user;
	
}