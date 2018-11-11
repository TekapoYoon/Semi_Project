<%@page import="java.util.Calendar"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDAO"%>
<%@page import="dao.CalendarDAOImpl"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp"%>
<%!public String toDates(String mdate) {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");

      String s = mdate.substring(0, 4) + "-" // yyyy
            + mdate.substring(4, 6) + "-" // MM
            + mdate.substring(6, 8) + " " // dd
            + mdate.substring(8, 10) + ":" // hh
            + mdate.substring(10, 12) + ":00";
      Timestamp d = Timestamp.valueOf(s);

      return sdf.format(d);
   }

   public String toOne(String msg) { // 08 -> 8
      return msg.charAt(0) == '0' ? msg.charAt(1) + "" : msg.trim();
   }%>
<%
   request.setCharacterEncoding("utf-8");

   CalendarDto dto = (CalendarDto) request.getAttribute("dto");
   CalendarDAOImpl dao = CalendarDAO.getInstance();

   String year = dto.getRdate().substring(0, 4);
   String month = dto.getRdate().substring(4, 6);
   String day = dto.getRdate().substring(6, 8);

   System.out.println(dto.getRdate());
   System.out.println(year + month + day);

   Calendar cal = Calendar.getInstance();

   int tyear = cal.get(Calendar.YEAR);
   int tmonth = cal.get(Calendar.MONTH)+1;
   int tday = cal.get(Calendar.DATE);
   int thour = cal.get(Calendar.HOUR);
   int tmin = cal.get(Calendar.MINUTE);
%>
<html>
<head>
<style type="text/css">
#box {
   margin: 2px 0;
   border: 1px solid;
   border-color: #afeeee;
}
</style>
<title>Honey Jam</title>
</head>
<body>
   <div class="container" style="margin-bottom: 20px">
      <div style="margin-top: 20px; margin-bottom: 20px">
         <h3 align="center">Event Update</h3>
      </div>
      <form action="CalendarController" method="post"
         style="margin: 15px; margin-top: 20px">
         <div style="padding: 5%; padding-bottom: 1%" id="box">
            <input type="hidden" name="command" value="updateAF"> <input
               type="hidden" name="seq" value="<%=dto.getSeq()%>">

            <!-- 제목 -->
            <div class="form-group row">
               <!-- Material input -->
               <label class="col-sm-2 col-form-label">제목</label>
               <div class="col-sm-10">
                  <div class="md-form mt-0">
                     <input type="text" class="form-control" name="title"
                        value="<%=dto.getTitle()%>">
                  </div>
               </div>
            </div>
            <!-- 제목끝 -->

            <!--일정 -->
            <div class="form-group row">
               <!-- Material input -->
               <label class="col-sm-2 col-form-label">일정</label>
               <div class="col-sm-10">
                  <div class="md-form mt-0">

                     <select name="year">
                        <%
                           for (int i = tyear - 5; i < tyear + 6; i++) {
                        %>
                        <option <%=year.equals(i + "") ? "selected='selected'" : ""%>
                           value="<%=i%>"><%=i%></option>
                        <%
                           }
                        %>
                     </select>년 <select name="month">
                        <%
                           for (int i = 1; i <= 12; i++) {
                        %>
                        <option
                           <%=toOne(month).equals(i + "") ? "selected='selected'" : ""%>
                           value="<%=i%>"><%=i%></option>
                        <%
                           }
                        %>
                     </select>월 <select name="day" id="day">
                        <%
                           for (int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {
                        %>
                        <option
                           <%=toOne(day).equals(i + "") ? "selected='selected'" : ""%>
                           value="<%=i%>"><%=i%></option>
                        <%
                           }
                        %>
                     </select>일 <select name="hour">
                        <%
                           for (int i = 0; i < 24; i++) {
                        %>
                        <option
                           <%=(thour + "").equals(i + "") ? "selected='selected'" : ""%>
                           value="<%=i%>"><%=i%></option>
                        <%
                           }
                        %>
                     </select>시 <select name="min">
                        <%
                           for (int i = 0; i < 60; i++) {
                        %>
                        <option
                           <%=(tmin + "").equals(i + "") ? "selected='selected'" : ""%>
                           value="<%=i%>"><%=i%></option>
                        <%
                           }
                        %>
                     </select>분
                  </div>
               </div>
            </div>
            <!--일정끝 -->
            <!--내용 작성-->
        
            <div class="form-group">
				<label for="exampleFormControlTextarea3">내용</label>
				<textarea class="form-control" id="exampleFormControlTextarea3"
				 name="content"	rows="10" style="-ms-overflow-style: none;"> </textarea>
			</div>

            <!--내용 작성끝-->
            <div align="center">
               <button type="submit" class="btn btn-outline-info waves-effect"
                  onclick="location.href='CalendarController?command=update&seq=<%=dto.getSeq()%>'">
                  <i class="fa fa-undo" aria-hidden="true"></i>수정
               </button>
            </div>
         </div>
      </form>
   </div>
   <%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>