package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.jejubaragy.dao.AdminDao;
import com.project.jejubaragy.dto.AdminDto;

public class AdminLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String aid = request.getParameter("aid");
		String apw = request.getParameter("apw");
		AdminDao dao = AdminDao.getInstance();
		AdminDto admin = dao.adminLogin(aid, apw);
		request.setAttribute("adminLoginResulte", AdminDao.FAIL);
		if(admin!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("admin", admin);
			request.setAttribute("adminLoginResulte", AdminDao.SUCCESS);
		}
	}

}
