package com.spring.javagreenS_khv.dto;

import lombok.Data;

//Controller와 ibatis 양쪽 파라미터 관리는 같이 할 수 없네요ㅜㅜ
//mapper쪽은 resultSet말고도 불편하더라도 DTO를 별도로 만드는 편이 좋을 것 같습니다.
//입력화면쪽은 전용VO가 좋은 것 같습니다.
public @Data class CustomCompLoginDTO {
	private int seq;
	private String login_id;
	private String login_pwd;
	private String encrypt_pwd;
	private int custom_id;
	private String custom_name;
	private String custom_nm_short;
	private int custom_kind_cd;
	private String custom_kind_nm;
	private String custom_grade;
	private String grade_name;
	private String address;//회사소개-카카오맵용(도로명)
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