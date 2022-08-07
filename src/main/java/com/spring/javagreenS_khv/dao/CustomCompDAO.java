package com.spring.javagreenS_khv.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_khv.dto.CustomCompDTO;
import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.vo.KakaoAddressVO;
import com.spring.javagreenS_khv.vo.QrCodeVO;

public interface CustomCompDAO {
	
	public KakaoAddressVO searchAddressName(@Param("address") String address);
	
	public void insertAddressName(@Param("vo") KakaoAddressVO vo);

	public List<KakaoAddressVO> searchAddressNameList();

	public void kakaoEx2Delete(@Param("address") String address);

	public CustomCompLoginDTO searchLogin(@Param("loginId") String loginId, @Param("encryptPwd") String encryptPwd);

	public void updateTodayCnt(@Param("loginId") String loginId, @Param("customId") int customId);

	public void updateVisitCntAndTodayCnt(@Param("loginId") String loginId, @Param("customId") int customId);

	public void updatePoint(@Param("loginId") String loginId, @Param("customId") int customId);

	public void updateCustomCompLoginUserDel(@Param("loginId") String loginId, @Param("customId") int customId);

	public void updateLogout(@Param("loginId") String loginId, @Param("customId") int customId);

	public boolean loginIdCheck(@Param("loginId") String loginId);

	public boolean companyNoCheck(@Param("companyNo") String companyNo);

	public boolean emailCheck(@Param("email") String email);

	public void insertCustomCompAndCustomCompLogin(@Param("compDto") CustomCompDTO compDto, @Param("loginDto") CustomCompLoginDTO loginDto);

	public int obtainCustomId(@Param("customKindCode") int customKindCode);

	public CustomCompDTO searchCustomComp(@Param("customId") int customId);

	
	public void updateCustomComp(@Param("compDto") CustomCompDTO compDto);

	
	public void insertQrCode(@Param("loginId") String loginId, @Param("customId") int customId, @Param("customName") String customName, @Param("qrCode") String qrCode);
	
	public QrCodeVO searchQrCode(@Param("qrCode") String qrCode);

	
	public CustomCompLoginDTO searchLogin2(@Param("customId") int customId);


}