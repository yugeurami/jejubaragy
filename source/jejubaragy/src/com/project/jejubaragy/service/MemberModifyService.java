package com.project.jejubaragy.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.project.jejubaragy.dao.MemberDao;
import com.project.jejubaragy.dto.MemberDto;

public class MemberModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("memberPhotoUp");
		int maxSize = 1024*1024; // 사진 업로드 제한 용량 : 1MB
		String mphoto = ""; // 첨부된 파일이 저장된 이름
		HttpSession session = request.getSession();
		MemberDto mdto = (MemberDto) session.getAttribute("member");
		try {
			MultipartRequest mRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());			
			Enumeration<String> params = mRequest.getFileNames(); 
			String param = params.nextElement(); 
			mphoto = mRequest.getFilesystemName(param);
			
			String mid = mRequest.getParameter("mid");
			String oldmpw = mRequest.getParameter("oldmpw");
			String newmpw = mRequest.getParameter("newmpw");
			if(newmpw == "") {
				newmpw = oldmpw;
			}
			String mname = mRequest.getParameter("mname");
			if(mphoto == null){
				mphoto = mdto.getMphoto();
			}
			MemberDao dao = MemberDao.getInstance();
			int result = dao.memberModify(mid, newmpw, mname, mphoto);
			System.out.println(result == MemberDao.SUCCESS ? "수정 완료" : "수정 실패");
			if(result == MemberDao.SUCCESS) {
				session.setAttribute("member", dao.memberLogin(mid, newmpw));
				request.setAttribute("memberModifyResult", MemberDao.SUCCESS);
			} else {
				request.setAttribute("memberModifyResult", MemberDao.FAIL);
			}			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		File serverFile = new File(path + "/" + mphoto);
		if(!mphoto.equals(mdto.getMphoto())) {
			InputStream is = null;
			OutputStream os = null;
			try {
				is = new FileInputStream(serverFile);
				os = new FileOutputStream("D:\\yujin\\jejubaragy\\source\\jejubaragy\\WebContent\\memberPhotoUp\\"+mphoto); 
				byte[] bs = new byte[(int)serverFile.length()];
				while(true) {
					int readByteCnt = is.read(bs);
					if(readByteCnt == -1) {
						break;
					}
					os.write(bs, 0, readByteCnt);
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			} finally {
				try {
					if(os!=null) os.close();
					if(is!=null) is.close();
				} catch (IOException e) {
					System.out.println(e.getMessage());
				}
			}
		}

	}

}
