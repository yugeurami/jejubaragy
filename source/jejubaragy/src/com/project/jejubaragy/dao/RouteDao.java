package com.project.jejubaragy.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.project.jejubaragy.dto.MemberDto;
import com.project.jejubaragy.dto.RouteDto;

public class RouteDao {
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	
	private static RouteDao instance = new RouteDao();
	public static RouteDao getInstance() {
		return instance;
	}
	private RouteDao() {}
	
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
	
	// 내 루트 목록
	public ArrayList<RouteDto> myRouteList(String mid) {
		ArrayList<RouteDto> routeList = new ArrayList<RouteDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT *" + 
				"                 FROM ROUTE" + 
				"                 WHERE MID = ?" + 
				"                  ORDER BY RSTARTDATE DESC)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int rnum = rs.getInt("rnum");
				String rname = rs.getString("rname");
				Date rstartdate = rs.getDate("rstartdate");
				Date renddate = rs.getDate("renddate");
				int rprivate = rs.getInt("rprivate");
				routeList.add(new RouteDto(rnum, rname, mid, null, rstartdate, renddate, rprivate));
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
		return routeList;
	}
	// 전체 공개 루트 목록
	public ArrayList<RouteDto> AllRouteList() {
		ArrayList<RouteDto> routeList = new ArrayList<RouteDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT R.*, MNAME" + 
				"        FROM ROUTE R, MEMBER M  " + 
				"        WHERE R.MID=M.MID AND RPRIVATE = 1 " + 
				"        ORDER BY RNUM DESC";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int rnum = rs.getInt("rnum");
				String rname = rs.getString("rname");
				String mid = rs.getString("mid");
				String mname = rs.getString("mname");
				Date rstartdate = rs.getDate("rstartdate");
				Date renddate = rs.getDate("renddate");
				int rprivate = rs.getInt("rprivate");
				routeList.add(new RouteDto(rnum, rname, mid, mname, rstartdate, renddate, rprivate));
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
		return routeList;
	}
	
	// 루트 만들기
	public int routeMake(String rname, String mid, Date rstartdate, Date renddate, int rprivate) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO ROUTE(RNUM, RNAME, MID, RSTARTDATE, RENDDATE, RPRIVATE)" + 
				"                VALUES(ROUTE_SEQ.NEXTVAL, ?, ?, ?, ? , ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rname);
			pstmt.setString(2, mid);
			pstmt.setDate(3, rstartdate);
			pstmt.setDate(4, renddate);
			pstmt.setInt(5, rprivate);
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
	public int getROUTE_SEQ() {
		int rnum= 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT ROUTE_SEQ.CURRVAL FROM DUAL";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rnum = rs.getInt(1);
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
		return rnum;
	}
	// 디테일 수정하기
	public int routeModify(String rname, Date rstartdate, Date renddate, int rprivate, int rnum ) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE ROUTE " + 
				"    SET RNAME = ?," + 
				"          RSTARTDATE = ?," + 
				"          RENDDATE = ?," + 
				"          RPRIVATE = ?" + 
				"    WHERE RNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rname);
			pstmt.setDate(2, rstartdate);
			pstmt.setDate(3, renddate);
			pstmt.setInt(4, rprivate);
			pstmt.setInt(5, rnum);
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
	public int routeDelete(int rnum) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM ROUTE WHERE RNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rnum);
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
