package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sun.glass.ui.Application;
import com.sun.java.swing.plaf.windows.resources.windows;

import dao.BbsDAO;
import dao.BbsDAOImpl;
import dto.BbsDto;

import dto.MemberDto;
import dto.ReplyDto;

public class BbsController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");

		String command = req.getParameter("command");

		BbsDAOImpl bbsDao = BbsDAO.getInstance();

		PrintWriter out = resp.getWriter();

		// 댓글쓰기
		if (command.equals("commentwrite")) {

			int seq = Integer.parseInt(req.getParameter("seq"));
			String loginid = ((MemberDto) req.getSession().getAttribute("login")).getId();
			String dcomment = req.getParameter("dcomment");

			int write = bbsDao.CommentWrite(seq, loginid, dcomment);
			if (write == 1) {
				System.out.print("댓글 성공");
			} else {
				System.out.print("댓글 실패");
			}
			resp.sendRedirect("BbsController?command=detail&sequence=" + seq);
		} else if (command.equals("deletecomment")) {

			int commentseq = Integer.parseInt(req.getParameter("commentseq"));
			int count = bbsDao.CommentDelete(commentseq);
			if (count == 1) {
				System.out.println("댓글 삭제완료");
			} else {
				System.out.println("댓글 삭제실패");
			}

			int seq = Integer.parseInt(req.getParameter("seq"));

			resp.sendRedirect("BbsController?command=detail&sequence=" + seq);
		}

		// 게시판글 작성
		else if (command.equals("bbsWrite")) {
			String savePath = req.getServletContext().getRealPath("/upload");

			int sizeLimit = 1024 * 1024 * 15;
			System.out.println("check1");
			try {
				MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, "utf-8",
						new DefaultFileRenamePolicy());
				
				String id = multi.getParameter("userId");
				String profilename = multi.getParameter("userImg");
				String title = multi.getParameter("title");
				String content = multi.getParameter("content");
				String hashtag = multi.getParameter("hashtag");

				String fileName = multi.getFilesystemName("files");
				System.out.println("check2");
				if (title.equals("") || content.equals("") || hashtag.equals("") || fileName == null) {
					out.println("<script>alert('양식을 모두 작성해 주세요'); location.href='bbslist.jsp';</script>");
					out.flush();
					return;
				}

				if (!checkFileForm(fileName)) {
					out.println(
							"<script>alert('png, jpg, jpeg의 확장자의 이미지 파일을 사용할 수 있습니다.'); location.href='bbslist.jsp';</script>");
					out.flush();
					return;
				}

				BbsDto dto = new BbsDto(0, id, title, content, null, 0, 0, 0, fileName, profilename, 0, hashtag);
				boolean isS = bbsDao.addBbs(dto);
				System.out.println("check3");
				if (!isS) {
					out.println("<script>alert('게시글등록 실패'); location.href='bbslist.jsp';</script>");
					out.flush();
				}
				//dispatch("bbslist.jsp", req, resp);
				resp.sendRedirect("bbslist.jsp");
			} catch (Exception e) {

			}
		}

		// 디테일 뷰
		else if (command.equals("detail")) {

			String sequence = req.getParameter("sequence");
			int seq = Integer.parseInt(sequence);

			BbsDto dto = bbsDao.getContent(seq);
			List<ReplyDto> list = bbsDao.commentview(seq);
			
			String id = req.getParameter("userId");
			int b = bbsDao.checkF(id, seq);
			
			req.setAttribute("likeCheck", b);
			req.setAttribute("Replylist", list);
			req.setAttribute("dto", dto);

			dispatch("bbsdetail.jsp", req, resp);
		}

		// 업데이트
		else if (command.equals("update")) {
						
			String title = req.getParameter("title");
			
			String content = req.getParameter("content");
			String id = req.getParameter("userId");
			int b_seq = Integer.parseInt(req.getParameter("sequence"));
						
			boolean yes = bbsDao.BbsUpdate(title, content, b_seq);
			
			if (yes == true) {
				updateBbsDetail(b_seq,id,req,resp);
			}else {
				updateBbsDetail(b_seq,id,req,resp);
			}
		}
		
		// 삭제
		else if (command.equals("delete")) {
			
			System.out.println("들어왔음");
			
			String seq = req.getParameter("sequence");
			int b_seq = Integer.parseInt(seq);
			
			System.out.println("sequence = " + b_seq);
			BbsDAOImpl bbsdao = BbsDAO.getInstance();
			
			boolean yes = bbsdao.BbsDelete(b_seq);
			
			if(yes == true){
				out = resp.getWriter();						
				out.println("<script>alert(\"삭제했습니다.\");location.href = \"bbslist.jsp\"</script>");		
				
			}else{
				out = resp.getWriter();				
				out.println("<script>alert(\"삭제 실패 했습니다.\");location.href = \"bbslist.jsp\"</script>");		
			}
			
			//resp.sendRedirect("bbslist.jsp");
		}

		// 좋아요 체크
	      else if(command.equals("favorite")) {
	         System.out.println("doProcess 실행");

	         String id = req.getParameter("id");
	         System.out.println("id = " + id);
	         
	         int seq = Integer.parseInt(req.getParameter("bbsSeq"));
	         System.out.println("seq = " + seq);
	         
	         int favorite = Integer.parseInt(req.getParameter("favorite"));
	         System.out.println("favorite = " + favorite);
	         
	         boolean f = bbsDao.findLiketo(id, seq);
	         if(!f) {
	            bbsDao.addLiketo(id,seq);
	         }

	         int b = bbsDao.checkF(id, seq);
	         
	         if(b == 1) {   // 체크했었음
	            bbsDao.readLikeDown(seq);
	            bbsDao.fckDown(id, seq);
	            
	         }
	         else {   // 체크안했었음
	            bbsDao.readLike(seq);
	            bbsDao.fck(id, seq);
	         }
	         
	        favorite = bbsDao.getLikeCount(seq);
	    
	         
	         StringBuffer json = new StringBuffer();
	         json.append("{");
	         json.append(" \"status\" : \"success\", "); // 요청한 것 잘 처리했고,
	         json.append(" \"favorite\" : " + favorite +",");
	         json.append(" \"duplicated\" : " + b);
	         json.append(" } ");

	         PrintWriter writer = resp.getWriter();
	         writer.write(json.toString());
	         writer.flush();
	         writer.close();
	      }
		
		// 게시판 디테일 이미지 변경
	      else if(command.equals("imgchange")) {
	    	  
	    	  System.out.println("doProcess 실행");
	    	  
	    	  String savePath = req.getServletContext().getRealPath("/upload");
	    	  int sizeLimit = 1024 * 1024 * 15;
	    	  
	    	  try {
					MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, "utf-8",
							new DefaultFileRenamePolicy());
					
					int seq = Integer.parseInt(multi.getParameter("bseq"));
					String imgname = multi.getFilesystemName("imgname");
					String id = req.getParameter("userId");

					if (!checkFileForm(imgname)) {
						updateBbsDetail(seq,id,req,resp);
						return;
					}

					boolean isS = bbsDao.setBbsImg(seq, imgname);

					if (isS) {
						updateBbsDetail(seq,id,req,resp);
					}
				} catch (Exception e) {

				}
	      }
		
	     
	      
		

		// 페이지이동 확인
		else if (command.equals("movePage")) {
			HttpSession session = req.getSession();
			MemberDto ss = (MemberDto) session.getAttribute("login");
			if (ss == null) {
				dispatch("login.jsp", req, resp);
			}else if(ss != null) {
				dispatch("bbslist.jsp", req, resp);
			}
		}
		
		out.close(); // printwriter 마무리
	}
	
	// bbsDetail 수정 함수
	public void updateBbsDetail(int seq,String id, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BbsDAOImpl bbsDao = BbsDAO.getInstance();
		BbsDto dto = bbsDao.getContent(seq);
		List<ReplyDto> list = bbsDao.commentview(seq);
		int b = bbsDao.checkF(id, seq);
		
		req.setAttribute("likeCheck", b);
		req.setAttribute("Replylist", list);
		req.setAttribute("dto", dto);
		
		dispatch("bbsdetail.jsp", req, resp);
	}

	// 업로드파일 확장자 확인
	public boolean checkFileForm(String fileName) {
		boolean check = false;
		int i = fileName.lastIndexOf(".");

		String str = fileName.substring(i, fileName.length());
		str = str.toLowerCase();

		if (str.equals(".png") || str.equals(".jpg") || str.equals(".jpeg")) {
			check = true;
		}

		return check;
	}

	// dispatch method
	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}
}
