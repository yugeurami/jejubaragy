package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.AdminDao;

public class AdminIdCheckService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String aid = request.getParameter("aid");
		AdminDao dao = AdminDao.getInstance();
		int result = dao.adminIdCheck(aid);
		if(result == AdminDao.EXISTENCE) {
			request.setAttribute("idCheckResult", "중복된 ID입니다");
		}else {
			request.setAttribute("idCheckResult", "ID 중복 확인 완료");
		}
	}

}
