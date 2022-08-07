package com.spring.javagreenS_khv.dto;

import lombok.Data;

public @Data class CustomCompDTO {
	private int seq;
	private int custom_id;
	private String custom_nm;
	private String custom_nm_short;
	private int custom_kind_group_code;
	private String kind_group_name;
	private int custom_kind_cd;
	private String kind_name;
	private String custom_grade;
	private String grade_name;
	private String estbl_date;
	private String company_no;
	private String office;
	private String txt_office;
	private String tel_no;
	private String hp_no;
	private String email;
	private String post_code;
	private String road_addr;
	private String extra_addr;
	private String detail_addr;
	private String memo;
	private String custom_img_file_name;
	private int over_days_user_del; //회원탈퇴신청 후 30일 경과시 회원삭제처리
	private String delete_over_flg;
	private String create_date;
	private String create_user;
	private String update_date;
	private String update_user;
	private String delete_date;
	private String delete_user;
} 