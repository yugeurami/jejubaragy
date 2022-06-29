package com.project.jejubaragy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.project.jejubaragy.dto.SpotDto;

public class SpotDao {
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	public static final int EXISTENCE = 1;
	public static final int NON_EXISTENCE = 0;
	
	private static SpotDao instance = new SpotDao();
	public static SpotDao getInstance() {
		return instance;
	}
	private SpotDao() {}
	
	private Connection getConnection () throws SQLException {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle11g");
			conn = ds.getConnection();
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	
	//여행지 목록
	public ArrayList<SpotDto> spotList(String ccode, String sname){
		ArrayList<SpotDto> spotList = new ArrayList<SpotDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT A.*, CNAME" + 
				"    FROM (SELECT * FROM SPOT" + 
				"                WHERE CCODE = ? AND" + 
				"                SNAME LIKE '%'||?||'%' ) A, CATEGORY C" + 
				"    WHERE A.CCODE=C.CCODE" + 
				"    ORDER BY SNAME";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ccode);
			pstmt.setString(2, sname);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int sid = rs.getInt("sid");
				sname = rs.getString("sname");
				String sphoto = rs.getString("sphoto");
				String saddress = rs.getString("saddress");
				String description = rs.getString("description");
				String cname = rs.getString("cname");
				spotList.add(new SpotDto(sid, ccode, cname, sname, sphoto, saddress, description));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
		return spotList;
	}
	
	//여행지 자세히 보기
	public SpotDto spotContent(int sid) {
		SpotDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT S.*, CNAME" + 
				"   	 FROM SPOT S, CATEGORY C" + 
				"    	 WHERE S.CCODE=C.CCODE AND SID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String ccode = rs.getNString("ccode");
				String sname = rs.getString("sname");
				String sphoto = rs.getString("sphoto");
				String saddress = rs.getString("saddress");
				String description = rs.getString("description");
				String cname = rs.getString("cname");
				dto = new SpotDto(sid, ccode, cname, sname, sphoto, saddress, description);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
		return dto;
	}
	
	// 중복된 여행지 체크
	public int spotCheck(int sid) {
		int result = EXISTENCE;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM SPOT WHERE SID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sid);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				result = NON_EXISTENCE;
			}else {
				result = EXISTENCE;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
		return result;
	}
	// 여행지 등록
	public int spotInsert(int sid, String ccode, String sname, String sphoto, String saddress,
			String description){
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO SPOT(SID, CCODE, SNAME, SPHOTO, SADDRESS, DESCRIPTION )" + 
				"                    VALUES(?, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sid);
			pstmt.setString(2, ccode);
			pstmt.setString(3, sname);
			pstmt.setString(4, sphoto);
			pstmt.setString(5, saddress);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "등록 성공" : "등록 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
		return result;
	}
	
	// 여행지 수정
	public int spotModify(int sid, String ccode, String sname, String sphoto, String saddress,
			String description){
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE SPOT" + 
				"    SET CCODE = ?," + 
				"          SNAME = ?," + 
				"          SPHOTO = ?," + 
				"          SADDRESS = ?," + 
				"          DESCRIPTION = ?" + 
				"    WHERE SID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ccode);
			pstmt.setString(2, sname);
			pstmt.setString(3, sphoto);
			pstmt.setString(4, saddress);
			pstmt.setInt(5, sid);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "수정 성공" : "수정 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
		return result;
	}
	
	// 여행지 삭제
	public int spotModify(int sid){
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM SPOT WHERE SID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sid);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "삭제 성공" : "삭제 실패");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
		return result;
	}
	
}
