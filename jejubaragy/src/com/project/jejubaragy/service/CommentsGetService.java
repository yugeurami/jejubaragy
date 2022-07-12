package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.CommentsDao;

public class CommentsGetService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		CommentsDao dao = CommentsDao.getInstance();
		int cid = Integer.parseInt(request.getParameter("cid"));
		request.setAttribute("comment", dao.CommentsGet(cid));
	}

}
