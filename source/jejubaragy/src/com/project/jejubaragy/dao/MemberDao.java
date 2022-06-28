package com.project.jejubaragy.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.project.jejubaragy.dto.MemberDto;

public class MemberDao {
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	public static final int EXISTENCE = 1;
	public static final int NON_EXISTENCE = 0;
	
	private static MemberDao instance = new MemberDao();
	public static MemberDao getInstance() {
		return instance;
	}
	private MemberDao() {}
	
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
	
	// 아이디 중복 확인
	public int memberIdCheck(String mid) {
		int result = EXISTENCE;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM MEMBER WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
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
	
	// 회원 가입
	public int memberJoin(MemberDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO MEMBER(MID, MPW, MNAME, MPHOTO)" + 
				"                VALUES(?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMid());
			pstmt.setString(2, dto.getMpw());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getMphoto());
			result = pstmt.executeUpdate();
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
	
	// 로그인
	public MemberDto memberLogin(String mid, String mpw) {
		MemberDto member = null; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM MEMBER" + 
				"    WHERE MID = ? AND MPW = ? AND MSTATUS = 1";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String mname = rs.getString("mname");
				String mphoto = rs.getString("mphoto");
				Date mrdate = rs.getDate("mrdate");
				int mstatus = rs.getInt("mstatus");
				member = new MemberDto(mid, mpw, mname, mphoto, mrdate, mstatus);
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
		return member;
	}
	
	// 총 회원 수
	public int memberCount() {
		int cnt = FAIL;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) CNT FROM MEMBER";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			cnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
		return cnt;
	}
	
	// 회원 목록 && 회원 검색
	public ArrayList<MemberDto> memberList(String searchmid, String searchmname, int startRow, int endRow) {
		ArrayList<MemberDto> members = new ArrayList<MemberDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT *" + 
				"    	FROM (SELECT ROWNUM RN, A.*" + 
				"                    FROM (SELECT * FROM MEMBER" + 
				"                                WHERE MID LIKE '%'||?||'%' AND" + 
				"                                           MNAME LIKE '%'||?||'%' AND" + 
				"                                           MSTATUS = 1" + 
				"                                ORDER BY MID, MRDATE DESC) A )" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchmid);
			pstmt.setString(2, searchmname);
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String mid = rs.getString("mid");
				String mpw = rs.getString("mpw");
				String mname = rs.getString("mname");
				String mphoto = rs.getString("mphoto");
				Date mrdate = rs.getDate("mrdate");
				int mstatus = rs.getInt("mstatus");
				members.add(new MemberDto(mid, mpw, mname, mphoto, mrdate, mstatus));
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
		return members;
	}
	// 탈퇴/강등 회원리스트
	public ArrayList<MemberDto> memberDownList(String searchmid, String searchmname, int startRow, int endRow) {
		ArrayList<MemberDto> members = new ArrayList<MemberDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT *" + 
				"    	FROM (SELECT ROWNUM RN, A.*" + 
				"                    FROM (SELECT * FROM MEMBER" + 
				"                                WHERE MID LIKE '%'||?||'%' AND" + 
				"                                           MNAME LIKE '%'||?||'%' AND" + 
				"                                           MSTATUS = 0" + 
				"                                ORDER BY MID, MRDATE DESC) A )" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchmid);
			pstmt.setString(2, searchmname);
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String mid = rs.getString("mid");
				String mpw = rs.getString("mpw");
				String mname = rs.getString("mname");
				String mphoto = rs.getString("mphoto");
				Date mrdate = rs.getDate("mrdate");
				int mstatus = rs.getInt("mstatus");
				members.add(new MemberDto(mid, mpw, mname, mphoto, mrdate, mstatus));
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
		return members;
	}
	
	// 회원정보 수정
	public int memberModify(String mid, String mpw, String mname, String mphoto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER" + 
				"    	SET MPW = ?," + 
				"           MNAME = ?," + 
				"           MPHOTO = ?" + 
				"    	WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mpw);
			pstmt.setString(2, mname);
			pstmt.setString(3, mphoto);
			pstmt.setString(4, mid);
			result = pstmt.executeUpdate();
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
	
	// 회원 탈퇴 & 강등
	public int memberDelete(String mid) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER SET MSTATUS = 0 WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			result = pstmt.executeUpdate();
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
	// 회원 복구
	public int memberUp(String mid) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER SET MSTATUS = 1 WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			result = pstmt.executeUpdate();
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
