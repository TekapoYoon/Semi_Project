<%@page import="dao.CalendarDAO"%>
<%@page import="dao.CalendarDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>calendardelete</title>
</head>
<body>
<h3>일정 삭제하기</h3>

<%
request.setCharacterEncoding("utf-8");

String sseq = request.getParameter("seq");
int seq = Integer.parseInt(sseq);

String rdate = request.getParameter("rdate");

CalendarDAOImpl dao = CalendarDAO.getInstance();
boolean isS = dao.deleteDay(seq);

String url = String.format("%s?year=%s&month=%s", "calendar.jsp", rdate.substring(0, 4), rdate.substring(4, 6));

if(isS){
    //삭제 성공
    %>
    <script type="text/javascript">
    alert("일정 삭제 성공");
    location.href ="<%=url %>";
    </script>
    <%
}else{
    %>
    <script type="text/javascript">
    alert("일정 삭제 실패");
    location.href ="<%=url %>";
    </script>
    <%
}
%>
</body>
</html>