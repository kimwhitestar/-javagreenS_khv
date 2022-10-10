package com.spring.javagreenS_khv.vo;

import lombok.Data;

public @Data class StyleCssVO {
	private String fieldCss; //HTML element id의 css
	private String invalidCss; //에러feedback css
	private String messageTxt; //화면표시할 메세지(유효:공란, 에러:에러메세지)
}