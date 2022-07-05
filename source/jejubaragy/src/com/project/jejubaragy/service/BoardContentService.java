package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.jejubaragy.dao.BoardDao;
import com.project.jejubaragy.dao.CommentsDao;

public class BoardContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		BoardDao bdao = BoardDao.getInstance();
		CommentsDao cdao = CommentsDao.getInstance();
		String bnumStr = request.getParameter("bnum");
		int bnum;
		if(bnumStr!=null) {
			bnum = Integer.parseInt(bnumStr);
		}else {
			HttpSession session = request.getSession();
			bnum = (Integer)session.getAttribute("bnum");
			session.removeAttribute("bnum");
		}
		System.out.println("contentService : "+ bnum);
		String pageNum = request.getParameter("pageNum");
		bdao.hitup(bnum);
		request.setAttribute("boardContent", bdao.boardContent(bnum));
		request.setAttribute("commentsList", cdao.CommentsList(bnum));
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("bnum", bnum);
	}

}
