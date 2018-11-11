<%@page import="java.util.ArrayList"%>
<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDAO"%>
<%@page import="dao.BbsDAOImpl"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDAO"%>
<%@page import="dao.CalendarDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp"%>

<%
   CalendarDAOImpl dao = CalendarDAO.getInstance();
   int paging = 1;
   int jcount = dao.getcountlist();

   if (null != request.getParameter("page") && !"".equals(request.getParameter("page"))) {
      paging = Integer.parseInt(request.getParameter("page"));
   }

   List<CalendarDto> indexCalList = dao.indexCalList(paging);
   int pagecount = 0;
   if (jcount != 0) {

      pagecount = jcount / 3;

      if (pagecount % jcount > 0) {
         pagecount++;
      }
   }
   int startPage = 0;
   int endPage = 0;
   if (paging > 3) {
      startPage = paging - 2;
   }
   if (pagecount < 3) {

   } else if (pagecount < paging + 1) {
      startPage = pagecount - 4;
   }
   if (pagecount < 2) {
      startPage = 0;
   }
   if (paging < 2) {
      endPage = 4;
   } else {
      endPage = paging + 2;
   }

   BbsDAOImpl bbsdao = BbsDAO.getInstance();
   List<BbsDto> bbslist = bbsdao.getBestList();
%>
<%!public String toDates(String mdate) {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      String s = mdate.substring(0, 4) + "-" // yyyy
            + mdate.substring(4, 6) + "-" // MM
            + mdate.substring(6, 8) + " " // dd
            + mdate.substring(8, 10) + ":" // hh
            + mdate.substring(10, 12) + ":00";

      Timestamp d = Timestamp.valueOf(s);

      return sdf.format(d);
   }%>
<html>
<head>
<title>Honey Jam</title>
<style type="text/css">
.sortable tr {
	cursor: pointer;
}
</style>
</head>
<body>
	<!--Main layout-->
	<div class="container">

		<!--Carousel Wrapper-->
		<div id="carousel-example-1z" class="carousel slide carousel-fade"
			data-ride="carousel"
			style="margin-left: auto; margin-right: auto; margin-bottom: 15px;">
			<!--Indicators-->
			<ol class="carousel-indicators">
				<li data-target="#carousel-example-1z" data-slide-to="0"
					class="active"></li>
				<li data-target="#carousel-example-1z" data-slide-to="1"></li>
				<li data-target="#carousel-example-1z" data-slide-to="2"></li>
			</ol>
			<!--/.Indicators-->
			<!--Slides-->
			<div class="carousel-inner" role="listbox">
				<!--First slide-->
				<div class="carousel-item active">
					<img class="d-block w-100"
						src="https://user-images.githubusercontent.com/38531104/45260934-0d09aa80-b42f-11e8-852d-1f0e546afac1.png"
						alt="First slide">
				</div>
				<!--/First slide-->
				<!--Second slide-->
				<div class="carousel-item">
					<img class="d-block w-100"
						src="https://user-images.githubusercontent.com/38531104/45261918-2ff38900-b446-11e8-8bb2-81a3eff688c6.png"
						alt="Second slide">
				</div>
				<!--/Second slide-->
				<!--Third slide-->
				<div class="carousel-item">
					<img class="d-block w-100"
						src="https://user-images.githubusercontent.com/38531104/45261919-2ff38900-b446-11e8-9f2d-f01f2314028c.png"
						alt="Third slide">
				</div>
				<!--/Third slide-->
			</div>
			<!--/.Slides-->
			<!--Controls-->
			<a class="carousel-control-prev" href="#carousel-example-1z"
				role="button" data-slide="prev"> <span
				class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="sr-only">Previous</span>
			</a> <a class="carousel-control-next" href="#carousel-example-1z"
				role="button" data-slide="next"> <span
				class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="sr-only">Next</span>
			</a>
			<!--/.Controls-->
		</div>
		<!--/.Carousel Wrapper-->

		<!-- List Table -->
		<div class="z-depth-1"
			style="margin-bottom: 15px; display: flex; flex-wrap: wrap;">

			<!-- Calendar List Table -->
			<div class="col-md-6" style="padding: 5px;">
				<table class="table table-hover sortable">
					<colgroup>
						<col style="width: 30%">
						<col style="width: 70%">
					</colgroup>
					<thead>
						<tr style="background-color: #F6F6F6;">
							<th scope="col" align="center">일정</th>
							<th scope="col" align="center">행사</th>
						</tr>
					</thead>
					<tbody>
						<%if(mem == null){ %>
						<tr>
							<td colspan="2" align="center">로그인이 필요합니다.</td>
						</tr>
						<%}else{ %>
						<%if (indexCalList == null || indexCalList.size() == 0) {%>
						<tr>
							<td colspan="2" align="center">다가오는 일정이 없습니다.</td>
						</tr>

						<% } else if (mem != null && !mem.getId().equals("")) { %>

						<%for (int i = 0; i < indexCalList.size(); i++) { %>
						<tr>
							<th><%=toDates(indexCalList.get(i).getRdate())%></th>
							<th><a
								href="calendardetail.jsp?seq=<%=indexCalList.get(i).getSeq()%>"><%=indexCalList.get(i).getTitle()%></a></th>
						</tr>
						<% } %>
						<tr>
							<td align="center" colspan="2">
								<div>
									<%
                              if (paging != 1 || pagecount == 0) {
                           %>
									<a href="./index.jsp?page=<%=paging - 1%>">&lt;</a>
									<%
                              }
                           %>
									<%
                              for (int i = startPage; i < pagecount; i++) {
                                    if (i + 1 != paging) {
                           %>
									<a href="./index.jsp?page=<%=i + 1%>"><%=i + 1%></a>
									<%
                              } else {
                           %>
									<strong><%=paging%></strong>
									<%
                              }
                                    if (i + 1 == endPage) {
                                       break;
                                    }
                                 }
                                 if (paging != pagecount || pagecount == 0) {
                           %>
									<a href="./index.jsp?page=<%=paging + 1%>">&gt;</a>
									<%
                              }
                           %>
								</div>
							</td>
						</tr>
						<%
                     }}
                  %>
					</tbody>

				</table>
			</div>
			<!-- // Calendar List Table -->

			<!-- BestBbsList Table -->
			<div class="col-md-6" style="padding: 5px;">
				<table class="table table-hover sortable"
					style="text-align: center;">
					<colgroup>
						<col style="width: 20%">
						<col style="width: 60%">
						<col style="width: 20%">
					</colgroup>
					<thead>
						<tr style="background-color: #F6F6F6;">
							<th scope="col">순위</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
						</tr>
					</thead>
					<tbody>
						<%if(mem == null){ %>
						<tr>
							<td style="font-family: fantasy" colspan="3">로그인이 필요합니다.</td>
						</tr>
						<%}else{ %>
						<%if (bbslist == null || bbslist.size() == 0) {%>
						<tr>
							<td style="font-family: fantasy" colspan="3">게시글이 없습니다</td>
						</tr>
						<%}else if(bbslist.size() > 0 && bbslist.size() < 3){
                  for (int i = 0; i < bbslist.size(); i++) {%>
						<tr>
							<td><%=i+1 %></td>
							<td><a
								href="BbsController?command=detail&sequence=<%=bbslist.get(i).getSeq()%>"><%=bbslist.get(i).getTitle()%></a></td>
							<td><%=bbslist.get(i).getId() %></td>
						</tr>
						<%}}else if(bbslist.size() >= 3){
                     for(int i = 0; i < 3; i++){%>
						<tr>
							<td><%=i+1 %></td>
							<td><a
								href="BbsController?command=detail&sequence=<%=bbslist.get(i).getSeq()%>"><%=bbslist.get(i).getTitle()%></a>
							</td>
							<td><%=bbslist.get(i).getId() %></td>
						</tr>
						<%}}} %>
						
					</tbody>
				</table>
			</div>
			<!-- BestBbsList Table -->
		</div>
		<!-- // List Table -->
	</div>
	<!-- // Main layout -->
	<script src="https://code.jquery.com/jquery-3.3.1.js"
		integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
		crossorigin="anonymous">
      
   </script>
	<script type="text/javascript">
      $(function() {
         $(".toDetail").click(function() {
            window.location.href = 'bbsdetail.jsp';
         });
      });
   </script>
	<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>