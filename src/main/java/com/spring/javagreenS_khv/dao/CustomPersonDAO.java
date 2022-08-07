package com.spring.javagreenS_khv.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_khv.dto.CustomPersonDTO;
import com.spring.javagreenS_khv.dto.CustomPersonLoginDTO;

public interface CustomPersonDAO {

	public CustomPersonLoginDTO searchLogin(@Param("loginId") String loginId, @Param("encryptPwd") String encryptPwd);

	public void updateTodayCnt(@Param("loginId") String loginId, @Param("customId") int customId);

	public void updateVisitCntAndTodayCnt(@Param("loginId") String loginId, @Param("customId") int customId);

	public void updatePoint(@Param("loginId") String loginId, @Param("customId") int customId);

	public void updateCustomPersonLoginUserDel(@Param("loginId") String loginId, @Param("customId") int customId);

	public void updateLogout(@Param("loginId") String loginId, @Param("customId") int customId);

	public boolean loginIdCheck(@Param("loginId") String loginId);

	public boolean emailCheck(@Param("email") String email);

	public boolean juminNoCheck(@Param("juminNo") String juminNo);

	public int obtainCustomId(@Param("customKindCode") int customKindCode);

	public void insertCustomPersonAndCustomPersonLogin(@Param("personDto") CustomPersonDTO personDto, @Param("loginDto") CustomPersonLoginDTO loginDto);

	public CustomPersonDTO searchCustomPerson(@Param("customId") int customId);
	
	public void updateCustomPerson(@Param("personDto") CustomPersonDTO personDto);
	
}