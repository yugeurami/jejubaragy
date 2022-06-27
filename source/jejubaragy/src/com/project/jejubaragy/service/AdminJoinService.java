package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.AdminDao;
import com.project.jejubaragy.dto.AdminDto;

public class AdminJoinService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		AdminDao dao = AdminDao.getInstance();
		String aid = request.getParameter("aid");
		String apw = request.getParameter("apw");
		String aname = request.getParameter("aname");
		AdminDto dto = new AdminDto(aid, apw, aname);
		int result = dao.adminJoin(dto);
		if(result == AdminDao.SUCCESS) {
			request.setAttribute("admin", dto);
			request.setAttribute("joinResult", AdminDao.SUCCESS);
		}else {
			request.setAttribute("joinResult", AdminDao.FAIL);
		}
	}

}
