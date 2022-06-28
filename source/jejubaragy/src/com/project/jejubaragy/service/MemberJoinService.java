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

public class MemberJoinService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("memberPhotoUp");
		int maxSize = 1024*1024; 
		String mphoto = ""; 
		try {
			MultipartRequest mRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());			
			Enumeration<String> params = mRequest.getFileNames(); 
			String param = params.nextElement(); 
			mphoto = mRequest.getFilesystemName(param);
			
			String mid = mRequest.getParameter("mid");
			String mpw = mRequest.getParameter("mpw");
			String mname = mRequest.getParameter("mname");
			if(mphoto == null){
				mphoto = "noImage.png";
			}
			MemberDao dao = MemberDao.getInstance();
			MemberDto dto = new MemberDto(mid, mpw, mname, mphoto, null, 1);
			int result = dao.memberJoin(dto);
			if(result == MemberDao.SUCCESS) {
				HttpSession session = request.getSession();
				session.setAttribute("mid", mid);
				request.setAttribute("memberJoinResult", MemberDao.SUCCESS);
			} else {
				request.setAttribute("memberJoinResult", MemberDao.FAIL);
			}			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		File serverFile = new File(path + "/" + mphoto);
		if(!mphoto.equals("noImage.png")) {
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
