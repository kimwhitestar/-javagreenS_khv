package com.spring.javagreenS_khv.service;

import java.util.List;

import com.spring.javagreenS_khv.dto.CustomCompDTO;
import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.vo.KakaoAddressVO;

public interface CustomCompService {
	
	public KakaoAddressVO searchAddressName(String address);

	public void insertAddressName(KakaoAddressVO vo);

	public List<KakaoAddressVO> searchAddressNameList();

	public void kakaoEx2Delete(String address);
	
	public CustomCompLoginDTO searchLogin(String loginId, String encryptPwd);

	public void updateTodayCnt(String loginId, int customId);

	public void updateVisitCntAndTodayCnt(String loginId, int customId);

	public void updatePoint(String loginId, int customId);

	public void updateCustomCompLoginUserDel(String loginId, int customId);

	public void updateLogout(String loginId, int customId);

	public boolean loginIdCheck(String loginId);

	public boolean companyNoCheck(String companyNo);

	public boolean emailCheck(String email);

	public int obtainCustomId(int customKindCode);

	public void insertCustomCompAndCustomCompLogin(CustomCompDTO compDto, CustomCompLoginDTO loginDto);

	public CustomCompDTO searchCustomComp(int customId);

	public void updateCustomComp(CustomCompDTO compDto);

	
	
	
	
	
	public CustomCompLoginDTO searchLogin(int customId);
	
	public String qrCreate(String qrCodeStartNobodyOrMoveUrls, int sCustomId, String uploadPath, String sCustomName, String extention);
	
	
	public String loginQrCode(String filePath, String qrCodeFileName);


}