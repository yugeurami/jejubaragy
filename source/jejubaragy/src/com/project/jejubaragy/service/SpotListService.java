package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.CategoryDao;
import com.project.jejubaragy.dao.SpotDao;

public class SpotListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		CategoryDao cdao = CategoryDao.getInstance();
		request.setAttribute("categoryList", cdao.categoryList());
		String ccode = request.getParameter("ccode");
		if(ccode == null ) {
			ccode = "AT4";
		}
		SpotDao sdao = SpotDao.getInstance();
		String sname = request.getParameter("sname");
		request.setAttribute("spotList", sdao.spotList(ccode, sname));
	}

}
