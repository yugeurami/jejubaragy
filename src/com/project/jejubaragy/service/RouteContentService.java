package com.project.jejubaragy.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.DetailRouteDao;
import com.project.jejubaragy.dao.SpotDao;
import com.project.jejubaragy.dto.DetailRouteDto;
import com.project.jejubaragy.dto.SpotDto;

public class RouteContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		DetailRouteDao dao = DetailRouteDao.getInstance();
		int rnum = Integer.parseInt(request.getParameter("rnum"));
		ArrayList<DetailRouteDto> dtos = dao.detailRouteList(rnum);
		request.setAttribute("detailRoute", dtos);
		request.setAttribute("days", dao.routeDays(rnum));
	}
}
