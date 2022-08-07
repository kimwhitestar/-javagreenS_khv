package com.spring.javagreenS_khv.vo;

import java.util.List;

import lombok.Data;

public @Data class FlgSummaryVO {
	private String delFlag;
	private List<FlagVO> flagVos;
}