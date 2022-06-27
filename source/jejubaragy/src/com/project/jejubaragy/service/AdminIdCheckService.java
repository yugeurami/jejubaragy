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
		if(result == AdminDao.NON_EXISTENCE) {
			request.setAttribute("idCheckResult", "id 중복 확인 완료");
		}else {
			request.setAttribute("idCheckResult", "중복된 id입니다");
		}
	}

}
