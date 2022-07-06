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

import com.project.jejubaragy.dto.BoardDto;

public class BoardDao {
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	
	private static BoardDao instance = new BoardDao();
	public static BoardDao getInstance() {
		return instance;
	}
	private BoardDao() {}
	
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
	
	// 총 게시글 수
	public int boardCount() {
		int cnt = FAIL;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) CNT FROM BOARD";
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
	
	// 게시글 페이징
	public ArrayList<BoardDto> boardList(int startRow, int endRow) {
		ArrayList<BoardDto> boardlist = new ArrayList<BoardDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT *" + 
				"   	 FROM (SELECT ROWNUM RN, A.*" + 
				"                    FROM (SELECT *" + 
				"                              FROM BOARD" + 
				"                              ORDER BY BNUM DESC) A )" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int bnum = rs.getInt("bnum");
				String mid = rs.getString("mid");
				String aid = rs.getString("aid");
				String bwriter = rs.getString("bwriter");
				int rnum = rs.getInt("rnum");
				String btitle = rs.getString("btitle");
				String bcontent = rs.getString("bcontent");
				String bmainphoto = rs.getString("bmainphoto");
				int bhit = rs.getInt("bhit");
				String bip = rs.getString("bip");
				Date brdate = rs.getDate("brdate");
				boardlist.add(new BoardDto(bnum, mid, aid, bwriter, rnum, btitle, bcontent, bmainphoto, bhit, bip, brdate));
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
		return boardlist;
	}
	
	// 여행지가 포함된 글목록
	public ArrayList<BoardDto> boardSearchList(int sid, int startRow, int endRow) {
		ArrayList<BoardDto> boardlist = new ArrayList<BoardDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT *" + 
				"    FROM (  SELECT ROWNUM RN, A.*" + 
				"                    FROM (  SELECT * FROM BOARD" + 
				"                                    WHERE RNUM = ( SELECT RNUM FROM DETAILROUTE WHERE SID = ? )" + 
				"                                    ORDER BY BHIT DESC) A )" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sid);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int bnum = rs.getInt("bnum");
				String mid = rs.getString("mid");
				String aid = rs.getString("aid");
				String bwriter = rs.getString("bwriter");
				int rnum = rs.getInt("rnum");
				String btitle = rs.getString("btitle");
				String bcontent = rs.getString("bcontent");
				String bmainphoto = rs.getString("bmainphoto");
				int bhit = rs.getInt("bhit");
				String bip = rs.getString("bip");
				Date brdate = rs.getDate("brdate");
				boardlist.add(new BoardDto(bnum, mid, aid, bwriter, rnum, btitle, bcontent, bmainphoto, bhit, bip, brdate));
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
		return boardlist;
	}
	// 베스트 게시글 5개 보기
	public ArrayList<BoardDto> boardBestList() {
		ArrayList<BoardDto> boardlist = new ArrayList<BoardDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT *" + 
				"    FROM (  SELECT ROWNUM RN, A.*" + 
				"                    FROM (  SELECT *" + 
				"                                    FROM BOARD" + 
				"                                    ORDER BY BHIT DESC) A )" + 
				"    WHERE RN BETWEEN 1 AND 5";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int bnum = rs.getInt("bnum");
				String mid = rs.getString("mid");
				String aid = rs.getString("aid");
				String bwriter = rs.getString("bwriter");
				int rnum = rs.getInt("rnum");
				String btitle = rs.getString("btitle");
				String bcontent = rs.getString("bcontent");
				String bmainphoto = rs.getString("bmainphoto");
				int bhit = rs.getInt("bhit");
				String bip = rs.getString("bip");
				Date brdate = rs.getDate("brdate");
				boardlist.add(new BoardDto(bnum, mid, aid, bwriter, rnum, btitle, bcontent, bmainphoto, bhit, bip, brdate));
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
		return boardlist;
	}
	
	// 게시글 작성
	public int boardWrite(BoardDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO BOARD(BNUM, MID, AID, BWRITER, RNUM, BTITLE, BCONTENT, BMAINPHOTO, BHIT, BIP, BRDATE)" + 
				"                VALUES(BOARD_SEQ.NEXTVAL, ? , ?, ?, ?, ?, ?, ?, 0, ?, SYSDATE)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMid());
			pstmt.setString(2, dto.getAid());
			pstmt.setString(3, dto.getBwriter());
			pstmt.setInt(4, dto.getRnum());
			pstmt.setString(5, dto.getBtitle());
			pstmt.setString(6, dto.getBcontent());
			pstmt.setString(7, dto.getBmainphoto());
			pstmt.setString(8, dto.getBip());
			System.out.println(dto);
			result = pstmt.executeUpdate();
			System.out.println(result);
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
	
	// 게시글 조회수 올리기
	public void hitup(int bnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE BOARD SET BHIT = BHIT + 1 WHERE BNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				System.out.println(e2.getMessage());
			}
		}
	}
	
	//게시글 자세히 보기
	public BoardDto boardContent(int bnum) {
		BoardDto board = null; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BOARD WHERE BNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String mid = rs.getString("mid");
				String aid = rs.getString("aid");
				String bwriter = rs.getString("bwriter");
				int rnum = rs.getInt("rnum");
				String btitle = rs.getString("btitle");
				String bcontent = rs.getString("bcontent");
				String bmainphoto = rs.getString("bmainphoto");
				int bhit = rs.getInt("bhit");
				String bip = rs.getString("bip");
				Date brdate = rs.getDate("brdate");
				board = new BoardDto(bnum, mid, aid, bwriter, rnum, btitle, bcontent, bmainphoto, bhit, bip, brdate);
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
		return board;
	}
	
	// 게시글 수정
	public int boardModify(String btitle, int rnum, String bcontent, String bmainphoto, int bnum ) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE BOARD" + 
				"    	SET BTITLE = ?," + 
				"			 RNUM = ?," +
				"          BCONTENT = ?," + 
				"          BMAINPHOTO = ?" + 
				"   	WHERE BNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, btitle);
			pstmt.setString(2, bcontent);
			pstmt.setString(3, bmainphoto);
			pstmt.setInt(4, bnum);
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
	
	// 글 삭제
	public int boardDelete(int bnum) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM BOARD WHERE BNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
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

