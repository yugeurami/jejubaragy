package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.DetailRouteDao;
import com.project.jejubaragy.dao.SpotDao;

public class DetailRouteMakeService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		DetailRouteDao dao = DetailRouteDao.getInstance();
		SpotDao sdao = SpotDao.getInstance();
		int rnum = Integer.parseInt(request.getParameter("rnum"));
		int sid = Integer.parseInt(request.getParameter("sid"));
		int days = Integer.parseInt(request.getParameter("days"));
		String rname = request.getParameter("rname");
		int result = dao.detailRouteMake(rnum, sid, 1, 1);
		if(result == DetailRouteDao.SUCCESS) {
			request.setAttribute("DetailRouteMakeResult", DetailRouteDao.SUCCESS);
			request.setAttribute("detailRoute", dao.detailRouteList(rnum));
			request.setAttribute("days", days);
			request.setAttribute("rnum", rnum);
			request.setAttribute("rname", rname);
			request.setAttribute("spotList", sdao.spotList("", ""));
		}else {
			request.setAttribute("DetailRouteMakeResult", DetailRouteDao.FAIL);
		}
	}

}
