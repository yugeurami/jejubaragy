package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.CommentsDao;

public class CommentsModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		CommentsDao dao = CommentsDao.getInstance();
		int cid = Integer.parseInt(request.getParameter("cid"));
		String ccontent = request.getParameter("ccontent");
		int result = dao.commentsModify(ccontent, cid);
		if(result == CommentsDao.SUCCESS) {
			request.setAttribute("commentsModifyResult", CommentsDao.SUCCESS);
		}else {
			request.setAttribute("commentsModifyResult", CommentsDao.FAIL);
		}
	}

}
