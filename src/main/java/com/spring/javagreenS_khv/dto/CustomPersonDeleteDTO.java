package com.spring.javagreenS_khv.dto;

import lombok.Data;

public @Data class CustomPersonDeleteDTO {
	private String login_id;
	private int custom_id;
	private String custom_nm;
	private String birth_date;
	private int over_days_user_del;//login삭제후 경과일
	private String over_flg;//login삭제후 30일 경과유무FLG (경과:'OVER', 미경과:'PRAC')
	private String delete_date;
	private String delete_user;
}