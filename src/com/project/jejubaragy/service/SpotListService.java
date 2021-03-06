package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.CategoryDao;
import com.project.jejubaragy.dao.SpotDao;

public class SpotListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String ccode = request.getParameter("ccode");
		if(ccode == null) {
			ccode = "";
		}
		SpotDao sdao = SpotDao.getInstance();
		String search = request.getParameter("search");
		request.setAttribute("spotList", sdao.spotList(ccode, search));
		request.setAttribute("ccode", ccode);
		request.setAttribute("search", search);
	}

}
