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

import com.project.jejubaragy.dto.DetailRouteDto;

public class DetailRouteDao {
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	
	private static DetailRouteDao instance = new DetailRouteDao();
	public static DetailRouteDao getInstance() {
		return instance;
	}
	private DetailRouteDao() {}
	
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
	// 디테일 루트 리스트
	public ArrayList<DetailRouteDto> detailRouteList(int rnum) {
		ArrayList<DetailRouteDto> details = new ArrayList<DetailRouteDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT D.*, SNAME, SADDRESS FROM DETAILROUTE D, SPOT S" + 
				"    WHERE D.SID=S.SID AND RNUM = ?" + 
				"    ORDER BY DDATE, DSEQ";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int dnum = rs.getInt("dnum");
				int sid = rs.getInt("sid");
				int ddate = rs.getInt("ddate");
				int dseq = rs.getInt("dseq");
				String sname = rs.getString("sname");
				String saddress = rs.getString("saddress");
				details.add(new DetailRouteDto(dnum, rnum, sid, sname, saddress, ddate, dseq));
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
		return details;
	}
	// 루트의 일수
	public int routeDays(int rnum) {
		int days = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT MAX(DDATE) DAYS FROM DETAILROUTE WHERE RNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			rs = pstmt.executeQuery();
			rs.next();
			days = rs.getInt("days");
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
		return days;
	}
	
	// 디테일 루트 만들기
	public int detailRouteMake(int rnum, int sid, int ddate, int dseq) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO DETAILROUTE(DNUM, RNUM, SID, DDATE, DSEQ)" + 
				"                VALUES(DETAILROUTE_SEQ.NEXTVAL, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			pstmt.setInt(2, sid);
			pstmt.setInt(3, ddate);
			pstmt.setInt(4, dseq);
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
	// 디테일 수정하기
	public int detailRouteModify(int ddate, int dseq, int dnum) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE DETAILROUTE" + 
				"    SET DDATE = ?," + 
				"          DSEQ = ?" + 
				"    WHERE DNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ddate);
			pstmt.setInt(2, dseq);
			pstmt.setInt(3, dnum);
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
	
	// 삭제하기
	public int detailRouteDelete(int dnum) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM DETAILROUTE WHERE DNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dnum);
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
