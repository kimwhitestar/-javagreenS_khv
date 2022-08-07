package com.spring.javagreenS_khv.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_khv.dto.FlgSummaryDTO;

public interface FlgSummaryDAO {
	public FlgSummaryDTO searchFlg(@Param("flgCd") String flgCd, @Param("menuCd") String menuCd, @Param("subMenuCd") String subMenuCd);
}