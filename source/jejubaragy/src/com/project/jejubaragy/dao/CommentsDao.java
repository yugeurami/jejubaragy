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

import com.project.jejubaragy.dto.CommentsDto;

public class CommentsDao {
	public static final int SUCCESS = 1;
	public static final int FAIL = 0;
	
	private static CommentsDao instance = new CommentsDao();
	public static CommentsDao getInstance() {
		return instance;
	}
	private CommentsDao() {}
	
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
	public int commentsCount(int bnum) {
		int cnt = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) CNT FROM COMMENTS WHERE BNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt("cnt");
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
		return cnt;
	}
	
	// 댓글 리스트
	public ArrayList<CommentsDto> CommentsList(int bnum) {
		ArrayList<CommentsDto> commentslist = new ArrayList<CommentsDto>(); 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT *" + 
				"    FROM ( SELECT ROWNUM RN, A.*" + 
				"                FROM ( SELECT * " + 
				"                            FROM COMMENTS" + 
				"                            WHERE BNUM = ?" + 
				"                            ORDER BY CGROUP DESC, CSTEP) A )";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int cid = rs.getInt("cid");
				String mid = rs.getString("mid");
				String aid = rs.getString("aid");
				String cwriter = rs.getString("cwriter");
				String cphoto = rs.getString("cphoto");
				String ccontent = rs.getString("ccontent");
				int cgroup = rs.getInt("cgroup");
				int cstep = rs.getInt("cstep");
				int cindent = rs.getInt("cindent");
				Date crdate = rs.getDate("crdate");
				String cip = rs.getString("cip");
				commentslist.add(new CommentsDto(cid, mid, aid, cwriter, cphoto, bnum, ccontent, 
													cgroup, cstep, cindent, crdate, cip));
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
		return commentslist;
	}
	public CommentsDto CommentsGet(int cid) {
		CommentsDto dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM COMMENTS WHERE CID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String mid = rs.getString("mid");
				String aid = rs.getString("aid");
				String cwriter = rs.getString("cwriter");
				String cphoto = rs.getString("cphoto");
				int bnum = rs.getInt("bnum");
				String ccontent = rs.getString("ccontent");
				int cgroup = rs.getInt("cgroup");
				int cstep = rs.getInt("cstep");
				int cindent = rs.getInt("cindent");
				Date crdate = rs.getDate("crdate");
				String cip = rs.getString("cip");
				dto = new CommentsDto(cid, mid, aid, cwriter, cphoto, bnum, ccontent, 
						cgroup, cstep, cindent, crdate, cip);
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
		
	// 댓글 작성
	public int commentsWrite(CommentsDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO COMMENTS(CID, MID, AID, CWRITER, CPHOTO, BNUM, CCONTENT, CGROUP, CSTEP, CINDENT, CRDATE, CIP)" + 
				"                    VALUES(COMMENTS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, COMMENTS_SEQ.CURRVAL, 0, 0, SYSDATE, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMid());
			pstmt.setString(2, dto.getAid());
			pstmt.setString(3, dto.getCwriter());
			pstmt.setString(4, dto.getCphoto());
			pstmt.setInt(5, dto.getBnum());
			pstmt.setString(6, dto.getCcontent());
			pstmt.setString(7, dto.getCip());
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
	
	// 대댓글 작성 전 로직
	private void stepA(int cgroup, int cstep) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE COMMENTS SET CSTEP = CSTEP + 1" + 
				"        WHERE CGROUP = ? AND CSTEP > ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cgroup);
			pstmt.setInt(2, cstep);
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
	
	// 대댓글 작성하기
	public int commentsReply(CommentsDto dto) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		stepA(dto.getCgroup(), dto.getCstep());
		String sql = "INSERT INTO COMMENTS(CID, MID, AID, CWRITER, CPHOTO, BNUM, CCONTENT, CGROUP, CSTEP, CINDENT, CRDATE, CIP)" + 
				"                    VALUES(COMMENTS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getMid());
			pstmt.setString(2, dto.getAid());
			pstmt.setString(3, dto.getCwriter());
			pstmt.setString(4, dto.getCphoto());
			pstmt.setInt(5, dto.getBnum());
			pstmt.setString(6, dto.getCcontent());
			pstmt.setInt(7, dto.getCgroup());
			pstmt.setInt(7, dto.getCstep()+1);
			pstmt.setInt(7, dto.getCindent()+1);
			pstmt.setString(8, dto.getCip());
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
	
	// 댓글 수정
	public int commentsModify(String ccontent, int cid) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE COMMENTS" + 
				"    SET CCONTENT = ?" + 
				"    WHERE CID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ccontent);
			pstmt.setInt(2, cid);
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
	
	// 댓글 삭제
	public int commentsDelete(int cgroup, int cstep, int cindent) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM COMMENTS " + 
				"    WHERE CGROUP = ? AND " + 
				"                ( CSTEP >= ? AND " + 
				"                  CSTEP<( SELECT NVL( MIN(CSTEP), 9999 ) " + 
				"                                FROM COMMENTS " + 
				"                                WHERE CGROUP = ? AND CSTEP > ? AND CINDENT <= ?) )";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cgroup);
			pstmt.setInt(2, cstep);
			pstmt.setInt(3, cgroup);
			pstmt.setInt(4, cstep);
			pstmt.setInt(5, cindent);
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
