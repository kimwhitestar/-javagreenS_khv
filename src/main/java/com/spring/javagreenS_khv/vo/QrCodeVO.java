package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class QrCodeVO {
	private int idx;
	private String loginId;
	private int customId;
	private String customName;
	private String qrcode;
}