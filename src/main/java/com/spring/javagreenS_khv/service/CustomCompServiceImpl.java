package com.spring.javagreenS_khv.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.SimpleFormatter;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javagreenS_khv.dao.CustomCompDAO;
import com.spring.javagreenS_khv.dto.CustomCompDTO;
import com.spring.javagreenS_khv.dto.CustomCompLoginDTO;
import com.spring.javagreenS_khv.vo.KakaoAddressVO;
import com.spring.javagreenS_khv.vo.QrCodeVO;

@Service
public class CustomCompServiceImpl implements CustomCompService {
	
	@Autowired
	public CustomCompDAO customCompDao;
	
	@Override
	public KakaoAddressVO searchAddressName(String address) {
		return customCompDao.searchAddressName(address);
	}

	@Override
	public void insertAddressName(KakaoAddressVO vo) {
		customCompDao.insertAddressName(vo);
	}

	@Override
	public List<KakaoAddressVO> searchAddressNameList() {
		return customCompDao.searchAddressNameList();
	}

	@Override
	public void kakaoEx2Delete(String address) {
		customCompDao.kakaoEx2Delete(address);
	}

	@Override
	public CustomCompLoginDTO searchLogin(String loginId, String encryptPwd) {
		return customCompDao.searchLogin(loginId, encryptPwd);
	}

	@Override
	public void updateTodayCnt(String loginId, int customId) {
		customCompDao.updateTodayCnt(loginId, customId);
	}

	@Override
	public void updateVisitCntAndTodayCnt(String loginId, int customId) {
		customCompDao.updateVisitCntAndTodayCnt(loginId, customId);
	}

	@Override
	public void updatePoint(String loginId, int customId) {
		customCompDao.updatePoint(loginId, customId);
	}

	@Transactional
	@Override
	public void updateCustomCompLoginUserDel(String loginId, int customId) {
		customCompDao.updateCustomCompLoginUserDel(loginId, customId);
	}

	@Override
	public void updateLogout(String loginId, int customId) {
		customCompDao.updateLogout(loginId, customId);
	}

	@Override
	public boolean loginIdCheck(String loginId) {
		return customCompDao.loginIdCheck(loginId);
	}

	@Override
	public boolean companyNoCheck(String companyNo) {
		return customCompDao.companyNoCheck(companyNo);
	}

	@Override
	public boolean emailCheck(String email) {
		return customCompDao.emailCheck(email);
	}

	@Override
	public int obtainCustomId(int customKindCode) {
		return customCompDao.obtainCustomId(customKindCode);
	}

	@Transactional
	@Override
	public void insertCustomCompAndCustomCompLogin(CustomCompDTO compDto, CustomCompLoginDTO loginDto) {
System.out.println("<Impl> compDto.getCustom_img_file_name() = " + compDto.getCustom_img_file_name());
		customCompDao.insertCustomCompAndCustomCompLogin(compDto, loginDto);
	}

	@Override
	public CustomCompDTO searchCustomComp(int customId) {
		return customCompDao.searchCustomComp(customId);
	}

	@Transactional
	@Override
	public void updateCustomComp(CustomCompDTO compDto) {
		customCompDao.updateCustomComp(compDto);
	}

	
	@Override
	public CustomCompLoginDTO searchLogin2(int customId) {
		return customCompDao.searchLogin2(customId);
	}	
	
	@Override
	public String qrCreate(String qrCodeStart, String loginId, int customId, String uploadPath, String customName, String extention) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmm");
		UUID uid = UUID.randomUUID();
		String strUid = uid.toString().substring(0,15);
		String qrCode = "", qrCodeImgName = customName;
		qrCode = sdf.format(new Date()) + "_" + String.format("%10s", loginId) + "_" + qrCodeStart + "_" + strUid; // qrCode Lenth (51) = 12 + 1 + 10 + 1 + 11 + 1 + 15
		String qrCodeFileName = qrCodeImgName + "_" + sdf.format(new Date());
	  try {
	      File file = new File(uploadPath);		// qr코드 이미지를 저장할 디렉토리 지정
	      if (!file.exists()) return "";
	      String[] oldFileNms = file.list();
	      if (null != oldFileNms && 0 < oldFileNms.length) {
		      int fNameLen = qrCodeImgName.length() + 15;
		      int[] fNameNums = new int[oldFileNms.length];//[0,0,0,0,0, ... N]
		      int fNameNum = 0, fNameNumIdx = 0;
		      String fNameNumbering = "";
		      for (String oldFile : oldFileNms) {
		      	System.out.println("oldFile = " + oldFile);
		      	if (oldFile.length() >= fNameLen) {
			      	if (oldFile.substring(0, fNameLen).equals(qrCodeImgName)) {
			      		fNameNumbering = oldFile.substring(oldFile.indexOf("(") + 1, oldFile.indexOf(")") - 1);
			      		if (! fNameNumbering.isEmpty()) { //null, 공란체크
			      			fNameNums[fNameNumIdx] = Integer.parseInt(fNameNumbering);
			      			fNameNumIdx++;
			      		}
			      	}
		      	}
		      }
		      Arrays.sort(fNameNums);//asending (기대값 : 0,0,0,0,0,1,2)
		      System.out.printf("fNameNums[0] = %d fNameNums[%d] = %d", fNameNums[0], fNameNums.length-1, fNameNums[fNameNums.length-1]);
		      fNameNum = fNameNums[fNameNums.length-1] + 1; // (기대값 : 2 + 1)
		      qrCodeFileName = qrCodeFileName + "(" + fNameNum + ")"; // (결과 : QR화일명_yyyyMMddhhmmss(3))
	      }
	      
	      int qrcodeColor = 0xFF000000;			// qr코드 바코드 생성값(전경색) - 뒤의 6자리가 색상코드임
	      int backgroundColor = 0xFFFFFFFF;	// qr코드 배경색상값
      	//String codeurl = new String(qrCodeStartNobodyOrMoveUrls.getBytes("UTF-8"), "ISO-8859-1");	// qr코드 인식시 이동할 url 주소
	      //BitMatrix bitMatrix = qrCodeWriter.encode(codeurl, BarcodeFormat.QR_CODE, 200, 200);

	      QRCodeWriter qrCodeWriter = new QRCodeWriter();
	      BitMatrix bitMatrix = qrCodeWriter.encode(qrCode, BarcodeFormat.QR_CODE, 200, 200);
	      MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrcodeColor, backgroundColor);
	      BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
	      
	      System.out.println("realPath = " + uploadPath + qrCodeFileName + "." + extention);
	      ImageIO.write(bufferedImage, extention, new File(uploadPath + qrCodeFileName + "." + extention));		// ImageIO를 사용한 바코드 파일쓰기

	      customCompDao.insertQrCode(loginId, customId, customName, qrCode); // 생성한 qr코드 DB저장
	  } catch (Exception e) {
	      e.printStackTrace();
	  }
	  return qrCodeFileName;
	}	

	@Override
	public QrCodeVO loginQrCode(String filePath, String qrCodeFileName) {
    File file = new File(filePath);
    File qrCodeFile = null;
    if (!file.exists()) return null;
    String[] oldFileNms = file.list();
    if (null != oldFileNms && 0 < oldFileNms.length) {
      for (String oldFile : oldFileNms) {
      	if (oldFile.equals(qrCodeFileName)) {
      		qrCodeFile = new File(filePath + qrCodeFileName);
System.out.println("Impl.loginQrCode() qrCodeFile : " + filePath + qrCodeFileName);
      	}
      }
    }
    if (null == qrCodeFile) return null;
    BufferedImage bufferedImage;
		try {
			bufferedImage = ImageIO.read(qrCodeFile);
		} catch (IOException e) {
			System.out.println(e.getMessage());
      return null;
		}
    LuminanceSource source = new BufferedImageLuminanceSource(bufferedImage);
    BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
    try {
      Result result = new MultiFormatReader().decode(bitmap);
      String qrCode = result.getText();
System.out.println("qrCode = " + qrCode);      
      if (51 > qrCode.length()) return null;
      QrCodeVO qrVo = customCompDao.searchQrCode(qrCode);
      if (null == qrVo) return null;
      String qrLoginId = qrCode.substring(13, 24 -1).trim();//실제로 index는 0부터 시작되, 13~22까지 자름
System.out.println("qrLoginId = " + qrLoginId);      
      if (!qrLoginId.equals(qrVo.getLoginId())) return null;
      else return qrVo;
    } catch (NotFoundException e) {
			System.out.println(e.getMessage());
      return null;
    }		
	}
}