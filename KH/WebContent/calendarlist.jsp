<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDAO"%>
<%@page import="dao.CalendarDAOImpl"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp"%>

<%
request.setCharacterEncoding("utf-8");

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String dates = year + two(month) + two(day); // 20180901

CalendarDAOImpl dao = CalendarDAO.getInstance();
List<CalendarDto> list = dao.getDayList(dates); // 해당 일의 행사리스트 반환
System.out.println("리스트 사이즈 : " + list.size());
/* String url = String.format("%s?year=%s&month=%s", "location.href='calendar.jsp'", year, month); */
%>

<%!
public String two(String msg) {
   return msg.trim().length() < 2 ? "0" + msg : msg.trim();// 1~9->01
}
   //yyyy-mm-dd hh:mm:ss Timestemp <- String
   //yyyy-mm-dd Date <- String
public String toDates(String mdate) {
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");

    String s = mdate.substring(0, 4) + "-" // yyyy
            + mdate.substring(4, 6) + "-" // MM
            + mdate.substring(6, 8) + " " // dd
            + mdate.substring(8, 10) + ":" // hh
            + mdate.substring(10, 12) + ":00";
    Timestamp d = Timestamp.valueOf(s);

    return sdf.format(d);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>calendarlist</title>
<style type="text/css">
.table-wrapper {
   background: #fff;
   padding: 20px;
   margin: 0px 0;
   box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}

.table-title {
   padding-bottom: 10px;
   margin: 0 0 10px;
}

table.table tr th, table.table tr td {
   border-color: #e9e9e9;
}

table.table-striped tbody tr:nth-of-type(odd) {
   background-color: #fcfcfc;
}

table.table-striped.table-hover tbody tr:hover {
   background: #f5f5f5;
}

table.table th i {
   font-size: 13px;
   margin: 0 5px;
   cursor: pointer;
}

table.table td:last-child {
   width: 130px;
}

table.table td a {
   color: #a0a5b1;
   display: inline-block;
   margin: 0 5px;
}

table.table td i {
   font-size: 19px;
}

table.table td a.delete {
   color: #E34724;
   align-items: center;
}
</style>
</head>
<body>

<div class="container" style="margin-bottom: 20px">
<form action="CalendarController" method="post">
<input type="hidden" name="command" value="detail">

     <div class="table-wrapper" align="center">
   <h3 align="center">Event List</h3>
   <hr>
         <table border="1" align="center"
            class="table table-striped table-hover table-bordered">
            <col width="100">
            <col width="150">
            <col width="400">
            <col width="50">
            <tr>
               <td align="center"><b>번호</b></td>
               <td align="center"><b>날짜</b></td>
               <td align="center"><b>제목</b></td>

               <%
                  if (mem.getAuth() == 1) {
               %>
               <td align="center">삭제</td>
            </tr>
            <%
               }
            %>
            </tr>
            <%
               if (list == null || list.size() == 0) {
                  //getauth가 뭐야 권한주는거던데 0이면 회원 1이면 관리자 회원도 볼수 있는거 아님?네네 다보는거 ㅈ
            %>
            <tr>
               <td colspan="3" align="center">입력된 일정이 없습니다.</td>
            </tr>
            
            <%   
               }else{
               for (int i = 0; i < list.size(); i++) {
                     CalendarDto caldto = list.get(i);
            %>

            <tr>
               <td align="center"><%=i + 1%></td>
               <td align="center"><%=toDates(caldto.getRdate())%></td>
               <td align="center"><a
                  href="calendardetail.jsp?seq=<%=caldto.getSeq()%>"><%=caldto.getTitle()%></a>
               </td>
               <%
                  if (mem.getAuth() == 1) {
               %>
               <td align="center"><a href="#" class="delete" title="Delete"
                  onclick="location.href='CalendarController?command=delete&seq=<%=caldto.getSeq()%>'"
                  data-toggle="tooltip"> <i class="fa fa-trash-o"
                     aria-hidden="true"></i>
               </a></td>
               <%
                  }
               %>
            </tr>
            <%
               }
            %>
            <%
               }
            %>
         </table>
         <div align="center">
         <button type="button" class="btn btn-outline-info waves-effect" onclick="location.href='calendar.jsp'">
               <i class="fa fa-undo" aria-hidden="true"></i>목록   </button>
      </div>      
      </div>
   </form>
</div>

         
<script type="text/javascript">
$(document).ready(function() {
   $('[data-toggle="tooltip"]').tooltip();
});
</script>

   <%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>