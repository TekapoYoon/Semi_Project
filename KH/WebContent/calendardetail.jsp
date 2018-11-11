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
   }
%>
<%
   request.setCharacterEncoding("utf-8");

   String sseq = request.getParameter("seq");
   int seq = Integer.parseInt(sseq);

   CalendarDAOImpl dao = CalendarDAO.getInstance();
   CalendarDto dto = dao.getDay(seq);
%>
<html>
<head>
<style type="text/css">
.active-pink-textarea-2 textarea.md-textarea {
   border-bottom: 1px solid #afeeee;
   box-shadow: 0 1px 0 0 #afeeee;
}

.active-pink-textarea-2.md-form label.active {
   color: #1e90ff;
}

.active-pink-textarea-2.md-form label {
   color: black;
}

.active-pink-textarea-2.md-form .prefix {
   color: #1e90ff;
}

#box {
   margin: 2px 0;
   border: 1px solid;
   border-color: #afeeee;
}
::-webkit-scrollbar {

display:none;

}
</style>
<title>Honey Jam</title>
</head>
<body>
   <div class="container" style="margin-bottom: 20px">
      <div style="margin-top: 20px; margin-bottom: 20px">
         <h3 align="center">Event Detail</h3>
      </div>
		<div style="padding: 8%; padding-bottom: 1%; margin: 5px" id="box">
			<!-- 제목 -->
			<div class="form-group row">
				<!-- Material input -->
				<label class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<div class="md-form mt-0">
						<input type="text" class="form-control"
							value="<%=dto.getTitle()%>" disabled>
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
						<input type="text" class="form-control"
							value=" <%=toDates(dto.getRdate())%>" disabled>

					</div>
				</div>
			</div>
			<!--일정끝 -->
			<!--내용들어오기-->
			<div class="form-group">
				<label for="exampleFormControlTextarea3">내용</label>
				<textarea class="form-control" id="exampleFormControlTextarea3"
					rows="10" style="-ms-overflow-style: none;"><%=dto.getContent()%> </textarea>
			</div>
		</div>
		<!--내용들어오기 끝-->
         <div align="center">
            <!--버튼부분  -->
            <%
            	if (mem.getAuth() == 1) {
            %>
            <button type="button" class="btn btn-outline-info waves-effect"
               onclick="location.href='CalendarController?command=update&seq=<%=dto.getSeq()%>'">
               <i class="fa fa-undo" aria-hidden="true"></i>수정
            </button>
            <button type="button" class="btn btn-outline-info waves-effect"
               onclick="location.href='CalendarController?command=delete&seq=<%=dto.getSeq()%>'">
               <i class="fa fa-trash-o" aria-hidden="true"></i>삭제
            </button>

            <%
               }
            %>
            <button type="button" class="btn btn-outline-info waves-effect"
               onclick="location.href='calendar.jsp'">
               <i class="fa fa-undo" aria-hidden="true"></i>목록
            </button>
         </div>
      </div>
   </div>
   <%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>