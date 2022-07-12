package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.jejubaragy.dao.CommentsDao;
import com.project.jejubaragy.dto.AdminDto;
import com.project.jejubaragy.dto.CommentsDto;
import com.project.jejubaragy.dto.MemberDto;

public class CommnetsWriteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String pageNum = request.getParameter("pageNum");
		request.setAttribute("pageNum", pageNum);
		
		CommentsDao dao = CommentsDao.getInstance();
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String ccontent = request.getParameter("ccontent");
		String cphoto = null;
		HttpSession session = request.getSession();
		AdminDto adto = (AdminDto) session.getAttribute("admin");
		MemberDto mdto = (MemberDto) session.getAttribute("member");
		String aid = null;
		String mid = null;
		String cwriter = null;
		if(adto != null) {
			aid = adto.getAid();
			cwriter = "관리자";
		}else if(mdto != null) {
			mid = mdto.getMid();
			cwriter = mdto.getMname();
			cphoto = mdto.getMphoto();
		}
		String cip = request.getLocalAddr();
		int result = dao.commentsWrite(new CommentsDto(0, mid, aid, cwriter, cphoto, bnum, ccontent, 0, 0, 0, null, cip));
		request.setAttribute("bnum", bnum);
		session.setAttribute("bnum", bnum);
		if(result == CommentsDao.SUCCESS) {
			request.setAttribute("commentsWriteResult", CommentsDao.SUCCESS);
		}else {
			request.setAttribute("commentsWriteResult", CommentsDao.FAIL);
		}
	}

}
