package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.BoardDao;
import com.project.jejubaragy.dao.CommentsDao;

public class BoardDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		BoardDao dao = BoardDao.getInstance();
		CommentsDao cdao = CommentsDao.getInstance();
		int result = cdao.boardDelete(bnum);
		if(result == CommentsDao.SUCCESS) {
			result = dao.boardDelete(bnum);
			if(result == BoardDao.SUCCESS) {
				request.setAttribute("BoardDeleteResult", BoardDao.SUCCESS);
			}
		}else {
			request.setAttribute("BoardDeleteResult", BoardDao.FAIL);
		}
	}

}
