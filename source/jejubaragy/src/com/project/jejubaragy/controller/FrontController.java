package com.project.jejubaragy.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.service.AdminIdCheckService;
import com.project.jejubaragy.service.AdminJoinService;
import com.project.jejubaragy.service.AdminListService;
import com.project.jejubaragy.service.AdminLoginService;
import com.project.jejubaragy.service.BoardBestListService;
import com.project.jejubaragy.service.BoardContentService;
import com.project.jejubaragy.service.LogoutService;
import com.project.jejubaragy.service.MemberDownListService;
import com.project.jejubaragy.service.MemberDownService;
import com.project.jejubaragy.service.MemberIdCheckService;
import com.project.jejubaragy.service.MemberJoinService;
import com.project.jejubaragy.service.MemberListService;
import com.project.jejubaragy.service.MemberLoginService;
import com.project.jejubaragy.service.MemberModifyService;
import com.project.jejubaragy.service.MemberUpService;
import com.project.jejubaragy.service.Service;
import com.project.jejubaragy.service.SpotListService;
import com.project.jejubaragy.service.BoardListService;
import com.project.jejubaragy.service.BoardModifyService;
import com.project.jejubaragy.service.BoardWriteService;
import com.project.jejubaragy.service.CommentsGetService;
import com.project.jejubaragy.service.CommentsModifyService;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean readPage = false;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String command = uri.substring(conPath.length());
		String viewPage	= null;
		Service	service = null; 
		if(command.equals("/main.do")) {
			viewPage = "main/main.jsp";
		}else if(command.equals("/adminLoginView.do")) {
			readPage = true;
			viewPage = "admin/adminLogin.jsp";
		}else if(command.equals("/adminLogin.do")) {
			if(readPage) {
				service = new AdminLoginService();
				service.execute(request, response);
				readPage = false;
			}
			viewPage = "main.do";
		}else if(command.equals("/adminList.do")) {
			service = new AdminListService();
			service.execute(request, response);
			viewPage = "admin/adminList.jsp";
		}else if(command.equals("/adminJoinView.do")) {
			readPage = true;
			viewPage = "admin/adminJoin.jsp";
		}else if(command.equals("/adminJoin.do")) {
			if(readPage) {
				service = new AdminJoinService();
				service.execute(request, response);
				readPage = false;
			}
			viewPage = "adminList.do";
		}else if(command.equals("/adminIdCheck.do")) {
			service = new AdminIdCheckService();
			service.execute(request, response);
			viewPage = "admin/adminIdCheck.jsp";
		}else if(command.equals("/memberList.do")) {
			service = new MemberListService();
			service.execute(request, response);
			viewPage = "member/memberList.jsp";
		}else if(command.equals("/memberDownList.do")) {
			service = new MemberDownListService();
			service.execute(request, response);
			viewPage = "member/memberDownList.jsp";
		}else if(command.equals("/logout.do")) {
			service = new LogoutService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/memberLoginView.do")) {
			readPage = true;
			viewPage = "member/memberLogin.jsp";
		}else if(command.equals("/memberLogin.do")) {
			if(readPage) {
				service = new MemberLoginService();
				service.execute(request, response);
				readPage = false;
			}
			viewPage = "main.do";
		}else if(command.equals("/memberJoinView.do")) {
			readPage = true;
			viewPage = "member/memberJoin.jsp";
		}else if(command.equals("/memberJoin.do")) {
			if(readPage) {
				service = new MemberJoinService();
				service.execute(request, response);
				readPage = false;
			}
			viewPage = "memberLoginView.do";
		}else if(command.equals("/memberIdCheck.do")) {
			service = new MemberIdCheckService();
			service.execute(request, response);
			viewPage = "member/memberIdCheck.jsp";
		}else if(command.equals("/memberModifyView.do")) {
			readPage = true;
			viewPage = "member/memberModify.jsp";
		}else if(command.equals("/memberModify.do")) {
			if(readPage) {
				service = new MemberModifyService();
				service.execute(request, response);
				readPage = false;
			}
			viewPage = "main.do";
		}else if(command.equals("/memberDown.do")) {
			service = new MemberDownService();
			service.execute(request, response);
			viewPage = "memberList.do";
		}else if(command.equals("/memberDelete.do")) {
			service = new MemberDownService();
			service.execute(request, response);
			viewPage = "logout.do";
		}else if(command.equals("/memberUp.do")) {
			service = new MemberUpService();
			service.execute(request, response);
			viewPage = "memberDownList.do";
		}else if(command.equals("/spotList.do")) {
			service = new SpotListService();
			service.execute(request, response);
			viewPage = "spot/spotList.jsp";
		}else if(command.equals("/boardList.do")) {
			service = new BoardListService();
			service.execute(request, response);
			viewPage = "board/boardList.jsp";
		}else if(command.equals("/boardWriteView.do")) {
			readPage = true;
			viewPage = "board/boardWrite.jsp";
		}else if(command.equals("/boardWrite.do")) {
			if(readPage) {
				service = new BoardWriteService();
				service.execute(request, response);
			}
			viewPage = "board/boardList.do";
		}else if(command.equals("/boardContent.do")) {
			service = new BoardContentService();
			service.execute(request, response);
			viewPage = "board/boardContent.jsp";
		}else if(command.equals("/boardModifyView.do")) {
			readPage = true;
			service = new BoardContentService();
			service.execute(request, response);
			viewPage = "board/boardModify.jsp";
		}else if(command.equals("/boardModify.do")) {
			if(readPage) {
				service = new BoardModifyService();
				service.execute(request, response);
			}
			viewPage = "board/boardContent.do";
		}else if(command.equals("/commentsModifyView.do")) {
			service = new CommentsGetService();
			service.execute(request, response);
			viewPage = "comments/commentsModify.jsp";
		}else if(command.equals("/commentsModify.do")) {
			service = new CommentsModifyService();
			service.execute(request, response);
			viewPage = "board/boardContent.do";
		}else if(command.equals("/boardBest.do")) {
			service = new BoardBestListService();
			service.execute(request, response);
			viewPage = "main.do";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
