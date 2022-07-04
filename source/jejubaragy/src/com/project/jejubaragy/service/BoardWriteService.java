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

public class BoardWriteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getRealPath("boardPhotoUp");
		int maxSize = 1024*1024*10; 
		MultipartRequest mRequest = null;
		String bmainphoto = ""; 
		try {
			mRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());			
			Enumeration<String> params = mRequest.getFileNames(); 
			String param = params.nextElement(); 
			bmainphoto = mRequest.getFilesystemName(param);
			
			
			HttpSession session = request.getSession();
			AdminDto adto = (AdminDto) session.getAttribute("admin");
			MemberDto mdto = (MemberDto) session.getAttribute("member");
			String aid = adto.getAid();
			String mid = mdto.getMid();
			String bwriter = null;
			if(aid != null) {
				bwriter = "관리자";
			}else if(mid != null) {
				bwriter = mdto.getMname();
			}
			String btitle = mRequest.getParameter("btitle");
			String rnumStr = mRequest.getParameter("rnum");
			int rnum = 0;
			if(rnumStr != "" || rnumStr != null) {
				rnum = Integer.parseInt(rnumStr);
			}
			String bcontent = request.getParameter("bcontent");
			String bip = request.getLocalAddr();
			
			BoardDao dao = BoardDao.getInstance();
			BoardDto dto = new BoardDto(0, mid, aid, bwriter, rnum, btitle, bcontent, bmainphoto, 0, bip, null);
			int result = dao.boardWrite(dto);
			if(result == BoardDao.SUCCESS) {
				request.setAttribute("boardWriteResult", MemberDao.SUCCESS);
			} else {
				request.setAttribute("boardWriteResult", MemberDao.FAIL);
			}			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		File serverFile = new File(path + "/" + bmainphoto);
		if(bmainphoto != null || bmainphoto != "") {
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
