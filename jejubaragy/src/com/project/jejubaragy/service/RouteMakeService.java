package com.project.jejubaragy.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.jejubaragy.dao.RouteDao;
import com.project.jejubaragy.dao.SpotDao;
import com.project.jejubaragy.dto.MemberDto;
import com.project.jejubaragy.dto.RouteDto;

public class RouteMakeService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		RouteDao dao = RouteDao.getInstance();
		SpotDao sdao = SpotDao.getInstance();
		HttpSession session = request.getSession();
		MemberDto member = (MemberDto) session.getAttribute("member");
		String mid = member.getMid();
		String rname = request.getParameter("rname");
		Date rstartdate = Date.valueOf(request.getParameter("rstartdate"));
		Date renddate = Date.valueOf(request.getParameter("renddate"));
		
		long days = (renddate.getTime() - rstartdate.getTime()) / (24*60*60*1000);
		int rprivate = Integer.parseInt(request.getParameter("rprivate"));
		int result = dao.routeMake(rname, mid, rstartdate, renddate, rprivate);
		int rnum = dao.getROUTE_SEQ();
		if(result == RouteDao.SUCCESS) {
			request.setAttribute("routeMakeResult", RouteDao.SUCCESS);
			request.setAttribute("rnum", rnum);
			request.setAttribute("rname", rname);
			request.setAttribute("days", days);
			request.setAttribute("spotList", sdao.spotList("", ""));
		}else {
			request.setAttribute("routeMakeResult", RouteDao.FAIL);
		}
	}

}
