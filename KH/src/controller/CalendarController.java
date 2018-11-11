package controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CalendarDAO;
import dao.CalendarDAOImpl;
import dto.CalendarDto;
import dto.MemberDto;

public class CalendarController extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");
		
		String command = req.getParameter("command");
		CalendarDAO dao = CalendarDAO.getInstance();		
	
		if(command.equals("write")) {
		
			String id = req.getParameter("id");
			String rdate = ""+req.getParameter("year")
							+formatTwo(req.getParameter("month"))
							+formatTwo(req.getParameter("day"))
							+formatTwo(req.getParameter("hour"))
							+formatTwo(req.getParameter("min"));
			
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			CalendarDto dto = new CalendarDto(id, title, content, rdate);

			boolean result = dao.addCalendar(dto);

			if(result == true){

				PrintWriter out = resp.getWriter();						
				out.println("<script>alert(\"성공적으로 일정을 입력했습니다.\");location.href = \"calendar.jsp\"</script>");		
				
			}else{
				PrintWriter out = resp.getWriter();				
				out.println("<script>alert(\"성공적으로 일정을 입력했습니다.\");location.href = \"calendar.jsp\"</script>");		
			}
		}
		else if(command.equals("delete")) {

			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			boolean result =dao.deleteDay(seq);
			
			if(result == true){

				PrintWriter out = resp.getWriter();						
				out.println("<script>alert(\"삭제했습니다.\");location.href = \"calendar.jsp\"</script>");		
				
			}else{
				PrintWriter out = resp.getWriter();				
				out.println("<script>alert(\"삭제 실패 했습니다.\");location.href = \"calendar.jsp\"</script>");		
			}
		}
		else if(command.equals("update")) {
			
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);
			
			CalendarDto dto = dao.getDay(seq);
			
			req.setAttribute("dto", dto);
			
			this.dispatch("calendarupdate.jsp", req, resp);
			
		}
		else if(command.equals("updateAF")) {
			
			String rdate = ""+req.getParameter("year")
			+formatTwo(req.getParameter("month"))
			+formatTwo(req.getParameter("day"))
			+formatTwo(req.getParameter("hour"))
			+formatTwo(req.getParameter("min"));

			String title = req.getParameter("title");
			String content = req.getParameter("content");
			
			int seq = Integer.parseInt(req.getParameter("seq"));
			
			CalendarDto dto = new CalendarDto("111", title, content, rdate);
			
			boolean result = dao.updateDay(dto, seq);
			
			if(result == true){

				PrintWriter out = resp.getWriter();						
				out.println("<script>alert(\"수정했습니다.\");location.href = \"calendar.jsp\"</script>");		
				
				
			}else{
				PrintWriter out = resp.getWriter();				
				out.println("<script>alert(\"수정 실패 했습니다.\");location.href = \"calendar.jsp\"</script>");		
			}
		}
		else if(command.equals("list")) {
			String sseq = req.getParameter("seq");
			int seq = Integer.parseInt(sseq);

			CalendarDto dto = dao.getDay(seq);
			
			req.setAttribute("dto", dto);
			
			this.dispatch("calendarlist.jsp", req, resp);
		}
		else if(command.equals("movePage")) {
			HttpSession session = req.getSession();
			MemberDto ss = (MemberDto)session.getAttribute("login");
			if(ss == null) {
				dispatch("login.jsp", req, resp);
			}else if(ss != null){
				dispatch("calendar.jsp", req, resp);
			}
		}
	}

	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		
		dispatch.forward(req, resp);
	}
	
	public String formatTwo(String month) {
		if(month.length()== 1) {
			month = "0"+month;
		}
		return month;
	}

}
