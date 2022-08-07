package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class CustomStatsVO {
	private String yyyy;
	private String mm;
	private String yyyyMM;
	private String customKindCd;
	private String customKindNm;
	private String customGrade;
	private String gradeName;
	private int entryCnt;
	private int deleteCnt;
	private int cnt;
}