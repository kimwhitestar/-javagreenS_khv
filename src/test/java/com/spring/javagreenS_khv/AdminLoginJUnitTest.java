package com.spring.javagreenS_khv;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.spring.javagreenS_khv.vo.AdminLoginVO;

public class AdminLoginJUnitTest {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		Connection conn = null;
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/javagreen_khv";
		conn = DriverManager.getConnection(url, "root", "1234");
		
		return conn;
	}
	
	//관리자 로그인
	public AdminLoginVO loginAdmin(String loginId, String loginPwd) {
		AdminLoginVO vo = null;
		try {
			conn = getConnection();
			String sql = "select * from adminLogin where loginId = ? and loginPwd = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);
			pstmt.setString(2, loginPwd);
			rs = pstmt.executeQuery();
			
			if (null != rs && rs.next()) {
				vo = new AdminLoginVO();
				vo.setLoginId(rs.getString("loginId"));
				vo.setLevel(rs.getString("level"));
				System.out.println(vo);
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return vo;
	}

	//관리자 로그인 테스트
	@Test 
	public void loginAdminTest() {
		String loginId = "admin";
		String loginPwd = "a1!";
		String encodingPwd = new BCryptPasswordEncoder().encode(loginPwd);
		AdminLoginVO vo = loginAdmin(loginId, encodingPwd);
		//level : 0 관리자, 1 회원
		if (null != vo && "0" == vo.getLevel()) {
			System.out.println("관리자가 맞습니다");
		}
	}

	//spring에서 제공하는 BCryptPasswordEncoder로 encoding해서 암호화비밀번호로 변환
	public String encodingPwd(String pwd) {
		String encodingPwd = new BCryptPasswordEncoder().encode(pwd);
		return encodingPwd;
	}
	
	//BCryptPasswordEncoder의 encode를 통해 암호화 테스트
	@Test
	public void encrypPwdTest() {
		String loginPwd = "a1!";
		String diaEncodingPwd = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
		String encodingPwd = encodingPwd(loginPwd);
		if (diaEncodingPwd.equals(encodingPwd)) {
			System.out.println("BCryptPasswordEncoder로 encoding해서 비밀번호 변환 테스트했습니다");
		}
	}
	
	//DB에 저장된 암호화된 비밀번호 데이타 가져오기
	public String dbEncrypPwd(String loginId, String loginPwd) {
		String dbEncodingPwd = null;
		try {
			conn = getConnection();
			String sql = "select * from adminLogin where loginId = ? and loginPwd = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);
			pstmt.setString(2, loginPwd);
			rs = pstmt.executeQuery();
			
			if (null != rs && rs.next()) {
				AdminLoginVO vo = new AdminLoginVO();
				dbEncodingPwd = rs.getString("loginPwd");
				System.out.println(vo);
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return dbEncodingPwd;
	}
	
	//DB에서 가져온 암호화된 비밀번호가 BCryptPasswordEncoder의 encode를 통해 암호화된 비밀번호가 맞는지 확인
	public void dbEncrypPwdTest() {
		String loginId = "admin";
		String loginPwd = "a1!";
		
		String diaEncodingPwd = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
		String encodingPwd = new BCryptPasswordEncoder().encode(loginPwd);
		if (diaEncodingPwd.equals(encodingPwd)) {
			System.out.println("BCryptPasswordEncoder로 encoding해서 비밀번호 변환 테스트했습니다");
		}
		
		String dbEncodingPwd = dbEncrypPwd(loginId, loginPwd);
		if (diaEncodingPwd.equals(dbEncodingPwd)) {
			System.out.println("BCryptPasswordEncoder로 변환한 비밀번호와 DB에 저장된 암화화된 비밀번호가 서로 맞습니다.");
		}
	}
}