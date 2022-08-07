package com.spring.javagreenS_khv.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_khv.vo.PdsVO;

public interface PdsDAO {

	public int searchPdsListTotRecCnt(String part);
	
	public List<PdsVO> searchPdsList(int startIndexNo, int pageSize, String part);

	public PdsVO searchPds(@Param("idx") int idx);

	public void insertPds(@Param("vo") PdsVO vo);

	public Object updateDownNum(@Param("idx") int idx);

	public void deletePds(@Param("idx") int idx);


	
	
	
//	private final MysqlConn instance = MysqlConn.getInstance();
//	private final Connection conn = instance.getConn();
//	private PreparedStatement pstmt = null;
//	private ResultSet rs = null;
//	private PdsVO vo = null;
//	private String sql = new String("");
//	
//	//자료실에 업로드된 파일의 정보를 DB저장
//	public int insert(PdsVO vo) {
//		int res = 0;
//		try {
//			sql = "insert into pds values (default, ?, ?, ?, ?, ?, ?, ?, ?, default, default, ?, ? ) ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, vo.getMid());
//			pstmt.setString(2, vo.getNickName());
//			pstmt.setString(3, vo.getfName());
//			pstmt.setString(4, vo.getfSName());
//			pstmt.setInt(5, vo.getfSize());
//			pstmt.setString(6, vo.getTitle());
//			pstmt.setString(7, vo.getPart());
//			pstmt.setString(8, vo.getPassword());
//			pstmt.setString(9, vo.getOpenSw());
//			pstmt.setString(10, vo.getContent());
//			res = pstmt.executeUpdate();
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;	
//	}
//	
//	//PDS 목록 조회
//	public List<PdsVO> searchPdsList(String part) {
//		List<PdsVO> vos = new ArrayList<>();
//		try {
//			if (part.equals("전체")) {
//				sql = "select * from pds where order by idx desc";
//				pstmt = conn.prepareStatement(sql);
//			} else {
//				sql = "select * from pds where part = ? order by idx desc";
//				pstmt.setString(1, part);
//				pstmt = conn.prepareStatement(sql);
//			}
//			rs = pstmt.executeQuery();//pk 1건 획득
//			
//			while (rs.next()) {
//				vo = new PdsVO();
//				vo.setMid(rs.getString("mid"));    
//				vo.setNickName(rs.getString("nickName"));
//				vo.setfName(rs.getString("fName"));  
//				vo.setfSName(rs.getString("fSName")); 
//				vo.setfSize(rs.getInt("fSize")); 
//				vo.setTitle(rs.getString("title"));  
//				vo.setPart(rs.getString("part"));
//				
//				vo.setwCDate(rs.getString("fDate"));
//				vo.setwNDate(new TimeDiff().timeDiff(vo.getwCDate()));
//				vo.setPassword(rs.getString("pwd	"));  
//				vo.setDownNum(rs.getInt("downNum"));
//				vo.setOpenSw(rs.getString("openSw")); 
//				vo.setContent(rs.getString("content"));
//				vos.add(vo);
//			}                        
//		} catch(SQLException e) { 	
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.rsClose();
//			instance.pstmtClose();
//		}
//		return vos;
//	}
//	//Pds 상세내용 조회
//	public PdsVO search(int idx) {
//		PdsVO vo = null;
//		try {
//			sql = "select * from pds where idx = ? order by idx desc";
//			pstmt.setInt(1, idx);
//			pstmt = conn.prepareStatement(sql);
//			rs = pstmt.executeQuery();//pk 1건 획득
//			
//			if (rs.next()) {
//				vo = new PdsVO();
//				vo.setMid(rs.getString("mid"));    
//				vo.setNickName(rs.getString("nickName"));
//				vo.setfName(rs.getString("fName"));  
//				vo.setfSName(rs.getString("fSName")); 
//				vo.setfSize(rs.getInt("fSize")); 
//				vo.setTitle(rs.getString("title"));  
//				vo.setPart(rs.getString("part"));
//				vo.setwCDate(rs.getString("fDate"));
//				vo.setPassword(rs.getString("pwd	"));    
//				vo.setDownNum(rs.getInt("downNum"));
//				vo.setOpenSw(rs.getString("openSw")); 
//				vo.setContent(rs.getString("content"));
//			}                        
//		} catch(SQLException e) { 	
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.rsClose();
//			instance.pstmtClose();
//		}
//		return vo;
//	}
//
//	//다운로드 횟수 1회 증가
//	public int updatePdsDownNum(int idx) {
//		int res = 0;
//		try {
//			sql = "update into pds set downNum = downNum + 1 where idx = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			res = pstmt.executeUpdate();
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return res;	
//	}
//
//	public boolean delete(int idx) {
//		boolean resFlg = true;
//		try {
//			sql = "delete from pds where idx = ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, idx);
//			if (1 != pstmt.executeUpdate()) resFlg = false;
//		} catch(SQLException e) {
//			System.out.println("SQL 에러 : " + e.getMessage());
//		} finally {
//			instance.pstmtClose();
//		}
//		return resFlg;	
//	}
}