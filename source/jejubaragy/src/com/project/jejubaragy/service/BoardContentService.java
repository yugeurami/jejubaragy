package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.jejubaragy.dao.BoardDao;
import com.project.jejubaragy.dao.CommentsDao;

public class BoardContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		BoardDao bdao = BoardDao.getInstance();
		CommentsDao cdao = CommentsDao.getInstance();
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String pageNum = request.getParameter("pageNum");
		bdao.hitup(bnum);
		request.setAttribute("boardContent", bdao.boardContent(bnum));
		request.setAttribute("commentsList", cdao.CommentsList(bnum));
		request.setAttribute("pageNum", pageNum);
	}

}
