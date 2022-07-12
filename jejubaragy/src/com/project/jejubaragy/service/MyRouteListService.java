package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.jejubaragy.dao.RouteDao;
import com.project.jejubaragy.dto.MemberDto;

public class MyRouteListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		RouteDao dao = RouteDao.getInstance();
		HttpSession session = request.getSession();
		MemberDto member = null;
		if(session.getAttribute("member") != null) {
			member = (MemberDto) session.getAttribute("member");
			String mid = member.getMid();
			request.setAttribute("myRouteList", dao.myRouteList(mid));
		}
	}

}
