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
import com.project.jejubaragy.dao.BoardDao;
import com.project.jejubaragy.dao.MemberDao;
import com.project.jejubaragy.dto.AdminDto;
import com.project.jejubaragy.dto.BoardDto;
import com.project.jejubaragy.dto.MemberDto;

public class BoardModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("boardPhotoUp");
		int maxSize = 1024*1024*10; 
		MultipartRequest mRequest = null;
		String bmainphoto = ""; 
		String bfile = "";
		String bcontent = null;
		String oldbcontent = null;
		try {
			mRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());			
			Enumeration<String> params = mRequest.getFileNames(); 
			while (params.hasMoreElements()) {
				String param = (String) params.nextElement();
				bfile = mRequest.getFilesystemName(param);
				bmainphoto = mRequest.getFilesystemName(param);
				System.out.println("첨부파일 넘어온 파라미터 이름"+param+" / 첨부파일이름 : "+bfile);
			}
			
			int bnum = Integer.parseInt(request.getParameter("bnum"));
			HttpSession session = request.getSession();
			String btitle = mRequest.getParameter("btitle");
			bcontent = mRequest.getParameter("bcontent");
			oldbcontent = mRequest.getParameter("oldbcontent");
			BoardDao dao = BoardDao.getInstance();
			int result = dao.boardModify(btitle, bcontent, bmainphoto, bnum);
			if(result == BoardDao.SUCCESS) {
				request.setAttribute("bnum", bnum);
				request.setAttribute("boardModifyResult", MemberDao.SUCCESS);
			} else {
				request.setAttribute("boardModifyResult", MemberDao.FAIL);
			}			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		File serverFile = new File(path + "/" + bmainphoto);
		if(bcontent != null && !bcontent.equals(oldbcontent)) {
			InputStream is = null;
			OutputStream os = null;
			try {
				is = new FileInputStream(serverFile);
				os = new FileOutputStream("D:\\yujin\\jejubaragy\\source\\jejubaragy\\WebContent\\boardPhotoUp\\"+bmainphoto); 
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
