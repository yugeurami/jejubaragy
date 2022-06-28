package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.MemberDao;

public class MemberIdCheckService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mid = request.getParameter("mid");
		MemberDao dao = MemberDao.getInstance();
		int result = dao.memberIdCheck(mid);
		if(result == MemberDao.EXISTENCE) {
			request.setAttribute("idCheckResult", "중복된 ID입니다");
		}else {
			request.setAttribute("idCheckResult", "ID 중복 확인 완료");
		}

	}

}
