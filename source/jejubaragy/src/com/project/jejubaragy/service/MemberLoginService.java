package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.jejubaragy.dao.MemberDao;
import com.project.jejubaragy.dto.MemberDto;

public class MemberLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		MemberDao dao = MemberDao.getInstance();
		MemberDto member = dao.memberLogin(mid, mpw);
		request.setAttribute("memberLoginResulte", MemberDao.FAIL);
		if(member!=null) {
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			request.setAttribute("memberLoginResulte", MemberDao.SUCCESS);
		}
	}

}
