package com.spring.javagreenS_khv.service;

import java.util.List;

import com.spring.javagreenS_khv.dto.CustomCompDeleteDTO;
import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.dto.CustomPersonDeleteDTO;
import com.spring.javagreenS_khv.dto.CustomPersonLoginDTO;
import com.spring.javagreenS_khv.vo.AdminLoginVO;
import com.spring.javagreenS_khv.vo.CustomCompSearchVO;
import com.spring.javagreenS_khv.vo.CustomStatsVO;

public interface AdminService {
	
	
	public AdminLoginVO searchAdminLogin(String loginId, String encryptPwd);

	public void updateLogout(String sLoginId);

	public List<CustomCompDeleteDTO> searchCustomCompDeleteList(String overFlg);

	public List<CustomPersonDeleteDTO> searchCustomPersonDeleteList(String overFlg);

	public void deleteCustomCompDelete(String customId);

	public void deleteCustomPersonDelete(String customId);

	public List<CustomCompLoginDTO> searchRecentlyEntryCustomCompList();

	public List<CustomCompLoginDTO> searchRecentlyLoginCustomCompList();

	public List<CustomCompLoginDTO> searchPracDeleteCustomCompList();

	public List<CustomPersonLoginDTO> searchRecentlyEntryCustomPersonList();

	public List<CustomPersonLoginDTO> searchRecentlyLoginCustomPersonList();

	public List<CustomPersonLoginDTO> searchPracDeleteCustomPersonList();

	public List<CustomStatsVO> searchEntryAndDeleteCustomCompStatsList1();

	public List<CustomStatsVO> searchEntryAndDeleteCustomCompStatsList2();

	public List<CustomStatsVO> searchEntryCustomCompStatsList();

	public List<CustomStatsVO> searchEntryCustomCompStatsList1();
	
	public List<CustomStatsVO> searchEntryCustomCompStatsList2();

	public List<CustomStatsVO> searchDeleteCustomCompStatsList();

	public List<CustomStatsVO> searchDeleteCustomCompStatsList1();

	public List<CustomStatsVO> searchDeleteCustomCompStatsList2();

	public List<CustomStatsVO> searchEntryAndDeleteCustomPersonStatsList1();

	public List<CustomStatsVO> searchEntryAndDeleteCustomPersonStatsList2();

	public List<CustomStatsVO> searchEntryCustomPersonStatsList();

	public List<CustomStatsVO> searchEntryCustomPersonStatsList1();

	public List<CustomStatsVO> searchEntryCustomPersonStatsList2();

	public List<CustomStatsVO> searchDeleteCustomPersonStatsList();

	public List<CustomStatsVO> searchDeleteCustomPersonStatsList1();

	public List<CustomStatsVO> searchDeleteCustomPersonStatsList2();

	public List<CustomCompSearchVO> searchCustomCompJoinList(String customGrade);

	public List<CustomCompSearchVO> searchCustomPersonJoinList(String customGrade);

	public void updateCustomCompGrade(String customId, String customGradeCd);

	public void updateCustomPersonGrade(String customId, String customGradeCd);

}