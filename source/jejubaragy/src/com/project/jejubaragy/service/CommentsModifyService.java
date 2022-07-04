package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.jejubaragy.dao.CommentsDao;
import com.project.jejubaragy.dto.AdminDto;
import com.project.jejubaragy.dto.MemberDto;

public class CommentsModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		CommentsDao dao = CommentsDao.getInstance();
		request.setAttribute("bnum", request.getParameter("bnum"));
		int cid = Integer.parseInt(request.getParameter("cid"));
		String ccontent = request.getParameter("ccontent");
		String cphoto = null;
		
		HttpSession session = request.getSession();
		AdminDto adto = (AdminDto) session.getAttribute("admin");
		MemberDto mdto = (MemberDto) session.getAttribute("member");
		String aid = adto.getAid();
		String mid = mdto.getMid();
		String cwriter = null;
		if(aid != null) {
			cwriter = "관리자";
		}else if(mid != null) {
			cwriter = mdto.getMname();
			cphoto = mdto.getMphoto();
		}
		int result = dao.commentsModify(ccontent, cid);
		if(result == CommentsDao.SUCCESS) {
			request.setAttribute("commentsModifyResult", CommentsDao.SUCCESS);
		}else {
			request.setAttribute("commentsModifyResult", CommentsDao.FAIL);
		}
	}

}
