package com.spring.javagreenS_khv.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javagreenS_khv.dao.AdminDAO;
import com.spring.javagreenS_khv.dto.CustomCompDeleteDTO;
import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.dto.CustomPersonDeleteDTO;
import com.spring.javagreenS_khv.dto.CustomPersonLoginDTO;
import com.spring.javagreenS_khv.vo.AdminLoginVO;
import com.spring.javagreenS_khv.vo.CustomCompSearchVO;
import com.spring.javagreenS_khv.vo.CustomStatsVO;


@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	public AdminDAO adminDao;

	@Override
	public AdminLoginVO searchAdminLogin(String loginId, String encryptPwd) {
		return adminDao.searchAdminLogin(loginId, encryptPwd);
	}

	@Override
	public void updateLogout(String loginId) {
		adminDao.updateLogout(loginId);
	}

	@Override
	public List<CustomCompDeleteDTO> searchCustomCompDeleteList(String overFlg) {
		return adminDao.searchCustomCompDeleteList(overFlg);
	}

	@Override
	public List<CustomPersonDeleteDTO> searchCustomPersonDeleteList(String overFlg) {
		return adminDao.searchCustomPersonDeleteList(overFlg);
	}
	@Transactional
	@Override
	public void deleteCustomCompDelete(String customId) {
		adminDao.deleteCustomCompDelete(customId);
	}

	@Transactional
	@Override
	public void deleteCustomPersonDelete(String customId) {
		adminDao.deleteCustomPersonDelete(customId);
	}

	@Override
	public List<CustomCompLoginDTO> searchRecentlyEntryCustomCompList() {
		return adminDao.searchRecentlyEntryCustomCompList();
	}

	@Override
	public List<CustomCompLoginDTO> searchRecentlyLoginCustomCompList() {
		
		return adminDao.searchRecentlyLoginCustomCompList();
	}

	@Override
	public List<CustomCompLoginDTO> searchPracDeleteCustomCompList() {
		return adminDao.searchPracDeleteCustomCompList();
	}

	@Override
	public List<CustomPersonLoginDTO> searchRecentlyEntryCustomPersonList() {
		return adminDao.searchRecentlyEntryCustomPersonList();
	}

	@Override
	public List<CustomPersonLoginDTO> searchRecentlyLoginCustomPersonList() {
		
		return adminDao.searchRecentlyLoginCustomPersonList();
	}

	@Override
	public List<CustomPersonLoginDTO> searchPracDeleteCustomPersonList() {
		return adminDao.searchPracDeleteCustomPersonList();
	}

	@Override
	public List<CustomStatsVO> searchEntryAndDeleteCustomCompStatsList1() {
		return adminDao.searchEntryAndDeleteCustomCompStatsList1();
	}

	@Override
	public List<CustomStatsVO> searchEntryAndDeleteCustomCompStatsList2() {
		return adminDao.searchEntryAndDeleteCustomCompStatsList2();
	}

	
	
	@Override
	public List<CustomStatsVO> searchEntryCustomCompStatsList() {
		return adminDao.searchEntryCustomCompStatsList();
	}
	
	@Override
	public List<CustomStatsVO> searchEntryCustomCompStatsList1() {
		return adminDao.searchEntryCustomCompStatsList1();

	}

	@Override
	public List<CustomStatsVO> searchEntryCustomCompStatsList2() {
		return adminDao.searchEntryCustomCompStatsList2();
	}

	@Override
	public List<CustomStatsVO> searchDeleteCustomCompStatsList() {
		return adminDao.searchDeleteCustomCompStatsList();
	}

	@Override
	public List<CustomStatsVO> searchDeleteCustomCompStatsList1() {
		return adminDao.searchDeleteCustomCompStatsList1();
	}

	@Override
	public List<CustomStatsVO> searchDeleteCustomCompStatsList2() {
		return adminDao.searchDeleteCustomCompStatsList2();
	}

	@Override
	public List<CustomStatsVO> searchEntryAndDeleteCustomPersonStatsList1() {
		return adminDao.searchEntryAndDeleteCustomPersonStatsList1();
	}

	@Override
	public List<CustomStatsVO> searchEntryAndDeleteCustomPersonStatsList2() {
		return adminDao.searchEntryAndDeleteCustomPersonStatsList2();
	}
	@Override
	public List<CustomStatsVO> searchEntryCustomPersonStatsList() {
		return adminDao.searchEntryCustomPersonStatsList();
	}
	@Override
	public List<CustomStatsVO> searchEntryCustomPersonStatsList1() {

		return adminDao.searchEntryCustomPersonStatsList1();
	}

	@Override
	public List<CustomStatsVO> searchEntryCustomPersonStatsList2() {
		return adminDao.searchEntryCustomPersonStatsList2();
	}

	@Override
	public List<CustomStatsVO> searchDeleteCustomPersonStatsList() {
		return adminDao.searchDeleteCustomPersonStatsList();
	}

	@Override
	public List<CustomStatsVO> searchDeleteCustomPersonStatsList1() {
		return adminDao.searchDeleteCustomPersonStatsList1();
	}

	@Override
	public List<CustomStatsVO> searchDeleteCustomPersonStatsList2() {
		return adminDao.searchDeleteCustomPersonStatsList2();
	}
	
	
	
	@Override
	public List<CustomCompSearchVO> searchCustomCompJoinList(String customGrade) {
		return adminDao.searchCustomCompJoinList(customGrade);
	}
	@Override
	public List<CustomCompSearchVO> searchCustomPersonJoinList(String customGrade) {
		return adminDao.searchCustomPersonJoinList(customGrade);
	}
	@Transactional
	@Override
	public void updateCustomCompGrade(String customId, String customGradeCd) {
		adminDao.updateCustomCompGrade(customId, customGradeCd);
	}
	@Transactional
	@Override
	public void updateCustomPersonGrade(String customId, String customGradeCd) {
		adminDao.updateCustomPersonGrade(customId, customGradeCd);
	}
}