package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class PdsVO {
	private int idx;
	private String mid;	
	private String nickName;
	private String fName;
	private String fSName;
	private int fSize;
	private String title;
	private String part;
	private String password;
	private String fDate;
	private int downNum;
	private String openSw;
	private String content;
//	//날짜형식필드를 '문자'와 '숫자'로 나눔
//	private String wCDate;//문자형날짜
//	private int wNDate;//오늘날짜와 글쓴날짜의 시간차
}