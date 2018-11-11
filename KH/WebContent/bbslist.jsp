<%@page import="dto.LiketoDto"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDAO"%>
<%@page import="dao.BbsDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp"%>
<html>
<head>
<title>Honey Jam</title>
<%
	BbsDAOImpl dao = BbsDAO.getInstance();
	List<BbsDto> list = null;
	String search = request.getParameter("search");

	if (search != null) {
		list = dao.getSearchList(search);
		if (list.size() == 0) {
			list = dao.getBbsList();
			out.println("<script>alert('검색된 내용이 없습니다');</script>");
		}
	} else {
		list = dao.getBbsList();
	}

	List<BbsDto> bestList = dao.getBestList();
	
%>
</head>
<body>
	<div class="container" style="padding: 0px">
		<!--Main layout-->
		<div style="padding-left: 10px; padding-right: 10px">

			<!-- Search Bar -->
			<div class="row" style="margin-bottom: 20px; padding: 20px">
				<div class="col-md-8" id="allpost" style="padding: 10px">
					<a href="bbslist.jsp" class="grey-text">All Posts</a>
				</div>
				<div class="col-md-4" style="padding: 0px">
					<form class="form-inline form-sm active-pink-2">
						<input class="form-control form-control-sm mr-3 w-75" type="text"
							placeholder="제목+본문" aria-label="제목+본문" id="search"> <a
							href="#" onclick="searchBbs()"><i class="fa fa-search"
							aria-hidden="true"></i></a>
					</form>
				</div>
			</div>
			<!-- // Search Bar -->

			<!-- Main Content -->
			<div id="main_content" class="row"
				style="margin-top: 15px; padding-bottom: 15px">

				<!-- BbsWrite layer -->
				<div class="col-md-3 sticky_column" data-sticky_column
					style="height: 640px;">
					<form id="regi_bbs" enctype="multipart/form-data" method="post"
						action="BbsController?command=bbsWrite">

						<!-- layer header -->
						<div
							style="padding: 15px; text-align: left; font-family: inherit; border-bottom: 1px solid;">
							<h4>
								<i class="fa fa-pencil" aria-hidden="true"></i> New Post
							</h4>
						</div>
						<!-- layer title -->
						<div class="card-body d-flex flex-row" style="padding: 10px">
							<input type="hidden" name="userImg" value="<%=mem.getImg()%>">
							<!-- Avatar -->
							<%
								if (mem.getImg() == null) {
							%>
							<img
								src="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png"
								class="rounded-circle mr-3" height="50px" width="50px"
								alt="avatar">
							<%
								} else {
									int temp = mem.getImg().indexOf("http");
									if (temp != -1) { // url 이미지 : true
							%>
							<img
								style="width: auto; height: auto; max-height: 50px; max-width: 50px"
								src="<%=mem.getImg()%>" class="rounded-circle mr-3" alt="avatar">
							<%
								} else {
							%>
							<img
								style="width: auto; height: auto; max-height: 50px; max-width: 50px"
								src="upload/<%=mem.getImg()%>" class="rounded-circle mr-3"
								alt="avatar">
							<%
								}
								}
							%>

							<!-- userId -->
							<input type="hidden" name="userId" id="userId"
								value="<%=mem.getId()%>">
							<h6 style="font-family: inherit; margin: 0; padding-top: 10px"><%=mem.getId()%></h6>
						</div>
						<!-- input title -->
						<div class="z-depth-1" style="padding: 10px">
							<input class="form-control form-control-sm" type="text"
								placeholder="Title"
								style="margin-top: 20px; padding-top: 10px; padding-bottom: 10px"
								name="title">
							<!-- input content -->
							<div class="form-group shadow-textarea" style="margin-top: 10px;">
								<textarea name="content" class="form-control z-depth-1"
									id="exampleFormControlTextarea6" rows="3" placeholder="Content"
									style="height: 200px"></textarea>
							</div>
							<!-- Hash Tag -->
							<input class="form-control form-control-sm" type="text"
								placeholder="#HashCode" name="hashtag"
								style="margin-bottom: 10px">

							<!-- write layer buttons -->
							<div style="margin: 5px; font-size: 10px">
								<input type="file" name="files">
							</div>
							<div align="center">
								<a href="#"
									onclick="document.getElementById('regi_bbs').submit()"><button
										type="button" class="btn btn-outline-info waves-effect"
										style="padding: 5px; width: 100px">게시글 올리기</button></a>
							</div>
						</div>
					</form>
				</div>
				<!-- // BbsWrite layer -->

				<!-- View BBS -->
				<div class="col-md-6">
					<%
						for (int i = 0; i < list.size(); i++) {
					%>
					<div class="card promoting-card" style="margin-bottom: 15px">
						<!-- Card content -->
						<div class="card-body d-flex flex-row">
							<!-- Avatar -->
							<%
								if (list.get(i).getProfilename().equals("null")) {
							%>
							<img
								src="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png"
								class="rounded-circle mr-3" height="50px" width="50px" alt="">
							<%
								} else {
									int temp = list.get(i).getProfilename().indexOf("http");
									if(temp != -1){	// url 이미지 : true
										%>
							<img
								style="width: auto; height: auto; max-height: 50px; max-width: 50px"
								src="
								<%=list.get(i).getProfilename()%>"
								class="rounded-circle mr-3" height="50px" width="50px"
								alt="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png">
							<%
									}else{
							%>
							<img
								style="width: auto; height: auto; max-height: 50px; max-width: 50px"
								src="
								upload/<%=list.get(i).getProfilename()%>"
								class="rounded-circle mr-3" height="50px" width="50px"
								alt="https://user-images.githubusercontent.com/38531104/45137275-e0615300-b1e2-11e8-9dbb-05378ea956b6.png">
							<%
									}}
							%>
							<!-- Content -->
							<div>
								<!-- Title -->
								<a href="userMyPage.jsp?userId=<%=list.get(i).getId()%>"
									style="color: black; font-size: 24px"
									class="card-title font-weight-bold mb-2"><%=list.get(i).getId()%></a>
								<!-- Subtitle -->
								<p class="card-text">
									<i class="fa fa-clock-o pr-2"></i><%=list.get(i).getWdate()%>
								</p>
							</div>

						</div>
						<!-- Card image -->
						<div class="view overlay" style="margin: 10px" align="center">
							<img
								style="width: auto; height: auto; max-height: 270px; max-width: 480px"
								src="upload/<%=list.get(i).getFilename()%>" class="img-fluid "
								alt="이미지 없음"> <a
								href="BbsController?command=detail&sequence=<%=list.get(i).getSeq()%>">
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
								<%if(dao.checkF(mem.getId(), list.get(i).getSeq()) == 1){ %>
										<button type="button" id=bbsSeq class="btn btn-unique btn-sm" onclick="check_like(<%=list.get(i).getSeq() %>)" >
										<i class="fa fa-heart" aria-hidden="true" ></i>Like : <span id="likecount"><%=list.get(i).getFavorite() %></span>
										</button> 
										<%} else{%>
											
										<button type="button" id=bbsSeq class="btn btn-sm" onclick="check_like(<%=list.get(i).getSeq() %>)" >
										<i class="fa fa-heart" aria-hidden="true" ></i>Like : <span id="likecount"><%=list.get(i).getFavorite() %></span>
										</button>
										<%} %>
							</div>
						</div>
						<div class="card-body" style="padding-top: 0px">
							<div>
								<!-- Text -->
								<p>
									<%=list.get(i).getTitle()%>
								</p>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
				<!-- // View BBS -->

				<!-- best bbsList -->
				<div class="col-md-3">
					<!-- best bbsList title -->
					<div
						style="border-bottom: 1px solid; padding: 15px; padding-bottom: 0px; margin-bottom: 10px">
						<h3 style="font-family: inherit">
							<img alt=""
								src="https://user-images.githubusercontent.com/38531104/44955785-291fc000-aef4-11e8-9ee2-e3f0d2eba058.png">
							best 3
						</h3>
					</div>
					<jsp:include page="bestbbslist.jsp"></jsp:include>
				</div>
				<!-- // best bbsList -->
			</div>
			<!-- //  Main Content -->
		</div>
		<!-- // Main layout-->
	</div>
	<div style="position: fixed; bottom: 100px; right: 80px;">
		<div style="font-size: 40px">
			<a href="#header" style="color: #AEADAD;"><i
				class="fa fa-arrow-circle-o-up" aria-hidden="true"></i></a><br> <a
				href="#footer" style="color: #AEADAD;"><i
				class="fa fa-arrow-circle-o-down" aria-hidden="true"></i></a>
		</div>
	</div>
	<%@ include file="/WEB-INF/include/footer.jsp"%>
	<!-- JQuery -->
	<script type="text/javascript" src="resources/js/sticky-kit.min.js"></script>
	<script type="text/javascript">
		$(".sticky_column").stick_in_parent();

		function searchBbs() {
			var word = document.getElementById("search").value;
			location.href = "bbslist.jsp?search=" + word;
		}
		
		
		function check_like(seq) {
	         var id = $("#userId").val();
	         var bbsSeq  = seq;
	         var favorite =  $("#likecount").text(); 
	   
	         
	       /*   alert("id =" + id);
	         alert("bbsSeq =" + bbsSeq);
	         alert("favorite =" + favorite);
	               */
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
	                  //alert("체크했었음 -> 좋아요 취소");
	                  //$("#likecount").val(jsonObj.favorite);
	                  //offLike();
	               }

	               else {
	                 // alert("체크 가능  -> 좋아요");
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

		
		function onLike(){
			
			$("#bbsSeq").addClass("btn-unique");
			
		}
		
		function offLike(){
			
			$("#bbsSeq").removeClass("btn-unique");
			
		}
		
	



	</script>
</body>
</html>