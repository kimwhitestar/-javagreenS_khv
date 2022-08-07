package com.spring.javagreenS_khv.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javagreenS_khv.dao.CustomPersonDAO;
import com.spring.javagreenS_khv.dto.CustomPersonDTO;
import com.spring.javagreenS_khv.dto.CustomPersonLoginDTO;

@Service
public class CustomPersonServiceImpl implements CustomPersonService {

	@Autowired
	public CustomPersonDAO customPersonDao;

	@Override
	public CustomPersonLoginDTO searchLogin(String loginId, String encryptPwd) {
		return customPersonDao.searchLogin(loginId, encryptPwd);
	}

	@Override
	public void updateTodayCnt(String loginId, int customId) {
		customPersonDao.updateTodayCnt(loginId, customId);
	}

	@Override
	public void updateVisitCntAndTodayCnt(String loginId, int customId) {
		customPersonDao.updateVisitCntAndTodayCnt(loginId, customId);
	}

	@Override
	public void updatePoint(String loginId, int customId) {
		customPersonDao.updatePoint(loginId, customId);
	}

	@Transactional
	@Override
	public void updateCustomPersonLoginUserDel(String loginId, int customId) {
		customPersonDao.updateCustomPersonLoginUserDel(loginId, customId);
	}

	@Override
	public void updateLogout(String loginId, int customId) {
		customPersonDao.updateLogout(loginId, customId);
	}

	@Override
	public boolean loginIdCheck(String loginId) {
		return customPersonDao.loginIdCheck(loginId);
	}

	@Override
	public boolean emailCheck(String email) {
		return customPersonDao.emailCheck(email);
	}

	@Override
	public boolean juminNoCheck(String juminNo) {
		return customPersonDao.juminNoCheck(juminNo);
	}

	@Override
	public int obtainCustomId(int customKindCode) {
		return customPersonDao.obtainCustomId(customKindCode);
	}

	@Transactional
	@Override
	public void insertCustomPersonAndCustomPersonLogin(CustomPersonDTO personDto, CustomPersonLoginDTO loginDto) {
		customPersonDao.insertCustomPersonAndCustomPersonLogin(personDto, loginDto);
	}

	@Override
	public CustomPersonDTO searchCustomPerson(int customId) {
		return customPersonDao.searchCustomPerson(customId);
	}

	@Transactional
	@Override
	public void updateCustomPerson(CustomPersonDTO personDto) {
		customPersonDao.updateCustomPerson(personDto);
	}
}