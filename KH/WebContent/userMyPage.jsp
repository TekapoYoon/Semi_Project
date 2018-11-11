<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDAO"%>
<%@page import="dao.BbsDAOImpl"%>
<%@page import="dao.MemberDAO"%>
<%@page import="dao.MemberDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp"%>
<html>
<head>
<title>Honey Jam</title>
<%
	MemberDAOImpl memdao = MemberDAO.getInstance();
	BbsDAOImpl bbsdao = BbsDAO.getInstance();

	MemberDto memdto = null;
	List<BbsDto> bbslist = null;

	String id = request.getParameter("userId");

	if (id == null) {
		memdto = memdao.getUserDto(mem.getId());
		bbslist = bbsdao.getUserBbsList(mem.getId());
	} else {
		memdto = memdao.getUserDto(id);
		bbslist = bbsdao.getUserBbsList(id);
	}
%>
</head>
<body>
	<div class="container" style="padding: 0px">
		<!-- Main layout -->
		<div style="padding-left: 10px; padding-right: 10px">
			<!-- Main content -->
			<div id="main_content" class="row">
				<!-- User Profile DtoList -->
				<div class="col-md-6 sticky_column" data-sticky_column
					style="height: 640px;">
					<!-- Profile Div -->
					<div class="modal-dialog modal-sm cascading-modal modal-avatar"
						role="document">
						<!--Content-->
						<div class="modal-content">
							<!--Header-->
							<div class="modal-header">
								<%
									if (memdto.getImg() == null) {
								%>
								<img
									style="width: auto; height: auto; min-height: 120px; min-width: 120px; max-height: 120px; max-width: 120px"
									src="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png"
									class="rounded-circle" alt="avatar">
								<%
									} else {
										int temp = memdto.getImg().indexOf("http");
										if (temp != -1) { // url 이미지 : true
								%>
								<img
									style="width: auto; height: auto; max-height: 120px; max-width: 120px"
									src="<%=memdto.getImg()%>" class="rounded-circle" alt="avatar">
								<%
									} else {
								%>
								<img
									style="width: auto; height: auto; max-height: 120px; max-width: 120px"
									src="upload/<%=memdto.getImg()%>" class="rounded-circle"
									alt="avatar">
								<%
									}
									}
								%>
							</div>
							<!--Body-->
							<div class="modal-body text-center mb-1">
								<h5 class="mt-1 mb-2"><%=memdto.getId()%></h5>
								<div class="md-form ml-0 mr-0"
									style="border-bottom: 1px solid; border-top: 1px solid; padding-top: 8px; padding-bottom: 8px">
									<table>
										<colgroup>
											<col style="width: 30%">
											<col style="width: 70%">
										</colgroup>
										<tbody>
											<tr>
												<th>Name</th>
												<td style="text-align: left;"><%=memdto.getName()%></td>
											</tr>
											<tr>
												<th>Phone</th>
												<td style="text-align: left;"><%=memdto.getPhone()%></td>
											</tr>
											<tr>
												<th>Email</th>
												<td style="text-align: left;"><%=memdto.getEmail()%></td>
											</tr>
											<tr>
												<th>Address</th>
												<td style="text-align: left;"><%=memdto.getAddress()%></td>
											</tr>
										</tbody>
									</table>
								</div>
								<%
									if (id == null) {
								%>
								<div>
									<a href="" data-toggle="modal" data-target="#centralModalSm"><button
											type="button" class="btn btn-outline-secondary waves-effect">
											<i class="fa fa-refresh" aria-hidden="true"></i> 회원정보 수정
										</button></a> <a href="" data-toggle="modal"
										data-target="#modalLoginAvatar"><button type="button"
											class="btn btn-outline-secondary waves-effect">
											<i class="fa fa-picture-o" aria-hidden="true"></i> 이미지 추가
										</button></a>
								</div>
								<%
									}
								%>
							</div>
						</div>
						<!--/.Content-->
					</div>
					<!-- // Profile Div -->
				</div>
				<!-- // User Profile DtoList -->

				<!-- User BbsList View -->
				<div class="col-md-6">
					<div>
						<%
							for (int i = 0; i < bbslist.size(); i++) {
						%>
						<div class="card promoting-card" style="margin-bottom: 15px">

							<!-- Card content -->
							<div class="card-body d-flex flex-row">

								<!-- Avatar -->
								<%
									if (bbslist.get(i).getProfilename().equals("null")) {
								%>
								<img
									style="width: auto; height: auto; max-height: 50px; max-width: 50px"
									src="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png"
									class="rounded-circle mr-3" height="50px" width="50px" alt="">
								<%
									} else {
											int temp = bbslist.get(i).getProfilename().indexOf("http");
											if (temp != -1) { // url 이미지 : true
								%>
								<img
									style="width: auto; height: auto; max-height: 50px; max-width: 50px"
									src="<%=bbslist.get(i).getProfilename()%>"
									class="rounded-circle mr-3" height="50px" width="50px"
									alt="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png">
								<%
									} else {
								%>
								<img
									style="width: auto; height: auto; max-height: 50px; max-width: 50px"
									src="upload/<%=bbslist.get(i).getProfilename()%>"
									class="rounded-circle mr-3" height="50px" width="50px"
									alt="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png">
								<%
									}
										}
								%>
								<!-- Content -->
								<div>
									<!-- Title -->
									<a href="userMyPage.jsp?userId=<%=bbslist.get(i).getId()%>"
										style="color: black; font-size: 24px"
										class="card-title font-weight-bold mb-2"><%=bbslist.get(i).getId()%></a>
									<!-- Subtitle -->
									<p class="card-text">
										<i class="fa fa-clock-o pr-2"></i><%=bbslist.get(i).getWdate()%>
									</p>
								</div>
							</div>
							<!-- Card image -->
							<div class="view overlay" style="margin: 10px" align="center">
								<img
									style="width: auto; height: auto; max-height: 270px; max-width: 480px"
									src="upload/<%=bbslist.get(i).getFilename()%>"
									class="img-fluid " alt="이미지 없음"> <a
									href="BbsController?command=detail&sequence=<%=bbslist.get(i).getSeq()%>">
									<div
										class="mask flex-center waves-effect waves-light rgba-red-slight">
										<p class="white-text">[클릭] 게시글 보기</p>
									</div>
								</a>
							</div>
							<!-- Card content -->
							<div align="right"
								style="padding-right: 10px; margin-top: 5px; margin-bottom: 5px;">
								<div class="btn-group btn-group-sm" role="group"
									aria-label="Basic example">
									<%if(bbsdao.checkF(mem.getId(), bbslist.get(i).getSeq()) == 1){ %>
										<button type="button" id=bbsSeq class="btn btn-unique btn-sm" onclick="check_like(<%=bbslist.get(i).getSeq() %>)" >
										<i class="fa fa-heart" aria-hidden="true" ></i>Like : <span id="likecount"><%=bbslist.get(i).getFavorite() %></span>
										</button> 
										<%} else{%>
											
										<button type="button" id=bbsSeq class="btn btn-sm" onclick="check_like(<%=bbslist.get(i).getSeq() %>)" >
										<i class="fa fa-heart" aria-hidden="true" ></i>Like : <span id="likecount"><%=bbslist.get(i).getFavorite() %></span>
										</button>
										<%} %>
										<input type="hidden" id="loginId" value="<%=mem.getId() %>">
								</div>
							</div>
							<div class="card-body" style="padding-top: 0px">
								<div>
									<!-- Text -->
									<p>
										<%=bbslist.get(i).getTitle()%>
									</p>
								</div>
							</div>
						</div>
						<%
							}
						%>
					</div>
				</div>
				<!-- // User BbsList View -->

			</div>
			<!-- // Main content -->
		</div>
		<!-- // Main layout -->
	</div>

	<!-- Replace Modal -->
	<!-- Central Modal Small -->
	<div class="modal fade" id="centralModalSm" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="container"
			style="padding-left: 10%; padding-right: 10%; margin-top: 30px">
			<div class="modal-header text-center" style="background-color: white">
				<h4 class="modal-title w-100 font-weight-bold">회원정보 수정</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<jsp:include page="memUpdate.jsp"></jsp:include>
		</div>
		<!-- Change class .modal-sm to change the size of the modal -->
		<div class="modal-dialog modal-sm" role="document"></div>
	</div>
	<!-- // Replace Modal -->

	<!-- Change Img Modal -->
	<div class="modal fade" id="modalLoginAvatar" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cascading-modal modal-avatar modal-sm"
			role="document">
			<!--Content-->
			<div class="modal-content">

				<!--Header-->
				<div class="modal-header">
					<%
						if (mem.getImg() == null) {
					%>
					<img
						style="width: auto; height: auto; min-height: 120px; min-width: 120px; max-height: 120px; max-width: 120px"
						src="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png"
						id="img" class="rounded-circle" alt="avatar">
					<%
						} else {
					%>
					<img
						style="width: auto; height: auto; max-height: 120px; max-width: 120px"
						id="img" src="upload/<%=mem.getImg()%>" class="rounded-circle"
						alt="avatar">
					<%
						}
					%>
				</div>
				<!--Body-->
				<div class="modal-body text-center mb-1">

					<form id="add_img" enctype="multipart/form-data" method="post"
						action="MemberController?command=changeimg">

						<div class="md-form ml-0 mr-0">
							<input type="hidden" name="userId" value="<%=mem.getId()%>">
							<input type="file" name="filename" onchange="readURL(this);">
						</div>

						<div class="text-center mt-4">
							<a href="#" onclick="document.getElementById('add_img').submit()"><button
									type="button" class="btn btn-outline-info waves-effect"
									style="padding: 5px; width: 100px">사진 수정</button></a>
						</div>
					</form>

				</div>

			</div>
			<!--/.Content-->
		</div>
	</div>
	<!-- // Change Img Modal -->

	<!-- pageController -->
	<div style="position: fixed; bottom: 100px; right: 80px;">
		<div style="font-size: 40px">
			<a href="#header" style="color: #AEADAD;"><i
				class="fa fa-arrow-circle-o-up" aria-hidden="true"></i></a><br> <a
				href="#footer" style="color: #AEADAD;"><i
				class="fa fa-arrow-circle-o-down" aria-hidden="true"></i></a>
		</div>
	</div>
	<!-- // pageController -->
	<%@ include file="/WEB-INF/include/footer.jsp"%>
	<!-- JQuery -->
	<script type="text/javascript" src="resources/js/sticky-kit.min.js"></script>
	<script type="text/javascript">
		$(".sticky_column").stick_in_parent();

		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#img').attr('src', e.target.result);

				}
				reader.readAsDataURL(input.files[0]);
			}
		}
		
		function check_like(seq) {
	         var id = $("#loginId").val();
	         var bbsSeq  = seq;
	         var favorite =  $("#likecount").text(); 
	   
	         
	       /*   alert("id =" + id);
	         alert("bbsSeq =" + bbsSeq);
	         alert("favorite =" + favorite); */
	             
	         $.ajax({
	            url : "BbsController?command=favorite",
	            type : "get",
	            data : {
	               id : id ,
	               bbsSeq : bbsSeq,
	               favorite : favorite
	            },
	            success : function(obj) {

	               var jsonObj = JSON.parse(obj);
	               if (jsonObj.duplicated == 1) {
	                 // alert("체크했었음 -> 좋아요 취소");
	                  //$("#likecount").val(jsonObj.favorite);
	                  //offLike();
	               }

	               else {
	                  //alert("체크 가능  -> 좋아요");
	                 // $("#likecount").val(jsonObj.favorite);
	                 // onLike();
	               
	               }
	               
	             	location.reload();

	            },

	            error : function(xhr, status) {
	               alert(xhr + " : " + status)
	            }
	         })
	      }
	</script>
</body>
</html>