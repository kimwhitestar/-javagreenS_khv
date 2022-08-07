package com.spring.javagreenS_khv.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_khv.dto.CustomCompDeleteDTO;
import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.dto.CustomPersonDeleteDTO;
import com.spring.javagreenS_khv.dto.CustomPersonLoginDTO;
import com.spring.javagreenS_khv.vo.AdminLoginVO;
import com.spring.javagreenS_khv.vo.CustomCompSearchVO;
import com.spring.javagreenS_khv.vo.CustomStatsVO;


public interface AdminDAO {
	
	public AdminLoginVO searchAdminLogin(@Param("loginId") String loginId, @Param("encryptPwd") String encryptPwd);

	public void updateLogout(@Param("loginId") String loginId);

	public List<CustomCompDeleteDTO> searchCustomCompDeleteList(@Param("overFlg") String overFlg);

	public List<CustomPersonDeleteDTO> searchCustomPersonDeleteList(@Param("overFlg") String overFlg);

	public void deleteCustomCompDelete(@Param("customId") String customId);

	public void deleteCustomPersonDelete(@Param("customId") String customId);

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

	public List<CustomCompSearchVO> searchCustomCompJoinList(@Param("customGrade") String customGrade);

	public List<CustomCompSearchVO> searchCustomPersonJoinList(@Param("customGrade") String customGrade);

	public void updateCustomCompGrade(@Param("customId") String customId, @Param("customGradeCd") String customGradeCd);

	
	public void updateCustomPersonGrade(@Param("customId") String customId, @Param("customGradeCd") String customGradeCd);
}