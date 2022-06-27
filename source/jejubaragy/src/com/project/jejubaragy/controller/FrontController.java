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
import com.project.jejubaragy.service.Service;

@WebServlet("/FrontController")
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
			viewPage = "admin/adminLogin.jsp";
		}else if(command.equals("/adminLogin.do")) {
			service = new AdminLoginService();
			service.execute(request, response);
			viewPage = "main.do";
		}else if(command.equals("/adminList.do")) {
			service = new AdminListService();
			service.execute(request, response);
			viewPage = "admin/adminList.jsp";
		}else if(command.equals("/adminJoinView.do")) {
			readPage = true;
			viewPage = "admin/AdminJoin.jsp";
		}else if(command.equals("/adminJoin.do")) {
			if(readPage) {
				service = new AdminJoinService();
				service.execute(request, response);
				readPage = false;
			}
			viewPage = "adminLoginView.do";
		}else if(command.equals("/AdminIdCheck.do")) {
			service = new AdminIdCheckService();
			service.execute(request, response);
			viewPage = "admin/AdminIdCheck.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}

}
