package com.spring.javagreenS_khv.service;

import com.spring.javagreenS_khv.dto.CustomPersonDTO;
import com.spring.javagreenS_khv.dto.CustomPersonLoginDTO;

public interface CustomPersonService {

	public CustomPersonLoginDTO searchLogin(String loginId, String encryptPwd);
	
	public void updateTodayCnt(String loginId, int customId);

	public void updateVisitCntAndTodayCnt(String loginId, int customId);

	public void updatePoint(String loginId, int customId);

	public void updateCustomPersonLoginUserDel(String loginId, int customId);

	public void updateLogout(String loginId, int customId);

	public boolean loginIdCheck(String loginId);

	public boolean emailCheck(String email);

	public boolean juminNoCheck(String juminNo);

	public int obtainCustomId(int customKindCode);

	public void insertCustomPersonAndCustomPersonLogin(CustomPersonDTO personDto, CustomPersonLoginDTO loginDto);

	public CustomPersonDTO searchCustomPerson(int customId);

	public void updateCustomPerson(CustomPersonDTO personDto);
	
}