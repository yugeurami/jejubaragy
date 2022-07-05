package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.CommentsDao;
import com.project.jejubaragy.dto.CommentsDto;

public class CommentsReplyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		CommentsDao dao = CommentsDao.getInstance();
		int cid = Integer.parseInt(request.getParameter("cid"));
		CommentsDto dto = dao.CommentsGet(cid);
		request.setAttribute("comment", dto);
	}

}
