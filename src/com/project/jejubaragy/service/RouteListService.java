package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.RouteDao;

public class RouteListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		RouteDao dao = RouteDao.getInstance();
		request.setAttribute("routeList", dao.AllRouteList());
	}

}
