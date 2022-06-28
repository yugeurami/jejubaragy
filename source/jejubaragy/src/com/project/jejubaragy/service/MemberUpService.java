package com.project.jejubaragy.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.jejubaragy.dao.MemberDao;
import com.project.jejubaragy.dto.MemberDto;

public class MemberUpService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		MemberDao dao = MemberDao.getInstance();
		int result = MemberDao.FAIL;
		String[] members = request.getParameterValues("members");
		if(members != null ) {
			for(int i = 0 ; i<members.length ; i++) {
				result = dao.memberUp(members[i]);
				System.out.println(result == MemberDao.SUCCESS ? members[i]+"강등 성공" : members[i]+"강등 실패");
			}
			if(result == MemberDao.SUCCESS) {
				request.setAttribute("upResult", MemberDao.SUCCESS);
			}else {
				request.setAttribute("upResult", MemberDao.FAIL);
			}
		}
	}

}
