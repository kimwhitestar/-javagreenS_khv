package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class PagingVO {
	private int blockSize;
	private int curBlock;
	private int lastBlock;
	private int pageSize;
	private int pageNo;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo;
	private String division;
}