
<%@page import="dto.LiketoDto"%>
<%@page import="dao.BbsDAOImpl"%>
<%@page import="dao.BbsDAO"%>
<%@page import="dto.ReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/include/header.jsp"%>
<%
	BbsDto dto = (BbsDto)request.getAttribute("dto");
	List<ReplyDto> commentview = (List<ReplyDto>)request.getAttribute("Replylist");

	int likeCheck = (int)request.getAttribute("likeCheck");
	System.out.println("likeCheck = "+ likeCheck);

	BbsDAOImpl bbsdao = BbsDAO.getInstance();
	
	List<BbsDto> smaller = bbsdao.getSmallerSeq(dto.getSeq());
	List<BbsDto> bigger = bbsdao.getBiggerSeq(dto.getSeq());

%>
<html>
<head>

<title>Honey Jam</title>

<style type="text/css">
/*댓글부분 css  */
.purple-border textarea {
	border: 1px solid #ba68c8;
}

.purple-border .form-control:focus {
	border: 1px solid #ba68c8;
	box-shadow: 0 0 0 0.2rem rgba(186, 104, 200, .25);
}
/* 댓글부분 css부분 끝 */

/* 파일 버튼 css */
.btn-file {
	position: relative;
	overflow: hidden;
}

.btn-file input[type=file] {
	cursor: inherit;
	display: none;
}
/* 파일 버튼 css 끝 */
.div-hearder-navbar {
	margin-top: 15px;
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 15px;
	background-color: #f6f6f6;
}

.contents {
	max-width: 780px;
	margin: 0 auto;
	text-align: center;
}

img {
	max-width: 100%; /* 이미지의 최대사이즈 */
	width /***/: auto; /* IE8 */
	height: auto;
	vertical-align: bottom;
}
/* Necessary for full page carousel*/

/* comment classes */
.media .avatar {
	width: 64px;
}

.shadow-textarea textarea.form-control::placeholder {
	font-weight: 300;
}

.shadow-textarea textarea.form-control {
	padding-left: 0.8rem;
}

.green-border-focus .form-control:focus {
	border: 1px solid #8bc34a;
	box-shadow: 0 0 0 0.2rem rgba(139, 195, 74, .25);
}
</style>
</head>

<body id="page-top" class="index-page">

	<div class="container" style="margin-bottom: 30px">
		<div class="wrap-body">

			<!-- /////////////////////////////////////////Content -->
			<div id="page-content">

				<div class="box-content">
					<div class="container">
						<!-----------------Content-------------------->
						<article class="single-post">
							<div class="wrap-post">
								<!--Start Box-->
								<div class="entry-header text-center">
									<h1 class="entry-title"><%=dto.getTitle() %></h1>

								</div>

								<!--Carousel Wrapper-->
								<div id="carousel-example-1z"
									class="carousel slide carousel-fade" data-ride="carousel">
									<!--Indicators-->
								
									<!--/.Indicators-->
									<!--Slides-->
									<div class="carousel-inner" role="listbox">
										<!--First slide-->
										<div style="height: auto; max-width: 780px;"
											class="carousel-item active contents">
											<img class="d-block w-100"
												src="upload/<%=dto.getFilename() %>" alt="이미지가 없습니다">
										</div>


									</div>
									<!--/.Slides-->
									<!--Controls-->
									<a class="carousel-control-prev" href="#carousel-example-1z"
										role="button" data-slide="prev"> <span
										class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a> <a class="carousel-control-next" href="#carousel-example-1z"
										role="button" data-slide="next"> <span
										class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="sr-only">Next</span>
									</a>
									<!--/.Controls-->
								</div>
								<!-- card Content -->
								<div class="card-body text-center wow fadeIn"
									data-wow-delay="0.2s"
									style="animation-name: none; visibility: visible;">


									<div align="left" class="btn-group" role="group"
										aria-label="Basic example">
										<button type="button"
											class="btn btn-purple btn-rounded btn-sm">
											<i class="fa fa-television" aria-hidden="true"></i>&nbsp View
											:
											<%=dto.getReadcount() %></button>
											
										<%if(bbsdao.checkF(mem.getId(), dto.getSeq()) == 1){ %>
										<button type="button"
											class="btn btn-purple btn-rounded btn-sm heart" id="btn_fav"
											onclick="check_like()" value="<%=dto.getFavorite() %>">
											<i class="fa fa-heart-o heart-1" aria-hidden="true"></i>&nbsp<span id="favcount"><%=dto.getFavorite() %></span>
										</button>
										<%} else{%>
											
										<button type="button"
											class="btn btn-rounded btn-sm heart" id="btn_fav"
											onclick="check_like()" value="<%=dto.getFavorite() %>">
											<i class="fa fa-heart-o heart-1" aria-hidden="true"></i>&nbsp<span id="favcount"><%=dto.getFavorite() %></span>
										</button>
										<%} %>
										
										<%-- <input type="button"
											class="btn btn-purple btn-rounded btn-sm heart" id="favcount"
											value="<%=dto.getFavorite() %>" readonly="readonly"> --%>
										<!-- <i class="fa fa-heart-o heart-1" aria-hidden="true"></i> -->
										<button type="button"
											class="btn btn-purple btn-rounded btn-sm">
											<i class="fa fa-pencil" aria-hidden="true"></i>&nbsp Date :
											<%=dto.getWdate() %></button>
										<button type="button"
											class="btn btn-purple btn-rounded btn-sm">
											<i class="fa fa-user fa-sm pr-2" aria-hidden="true"></i>&nbsp
											Author :
											<%=dto.getId() %></button>
									</div>
								</div>


								<!-- / card Content -->


								<!--/.Carousel Wrapper-->
								<br> <br>
								<!-- 글내용들어오는곳  -->
								<div class="entry-content">
									<p align="center"><%=dto.getContent()%></p>
								</div>
							</div>
						</article>
					</div>
				</div>
			</div>

			<!-- 내용 수정 -->

			<div align="right">
				<button type="button" class="btn btn-rounded btn-amber"
					onclick="location.href='bbslist.jsp'">
					<i class="fa fa-th-list pr-2" aria-hidden="true"></i>목록
				</button>

				<%if(mem.getId().equals(dto.getId())){ %>

				<button type="button" data-toggle="modal" data-target="#deleteModal"
					class="btn btn-danger btn-rounded">
					<i class="fa fa-trash"></i>삭제
				</button>

				<button type="button" data-toggle="modal" data-target="#updateModal"
					class="btn btn-primary">
					<i class="fa fa-magic mr-1"></i>내용 수정
				</button>

				<!-- 사진 추가/수정 -->
				<button type="button" data-toggle="modal" data-target="#modalYT"
					class="btn btn-primary">
					<i class="fa fa-magic mr-1"></i>사진 수정
				</button>

				<%
					}
				%>
			</div>
<!--댓글부분 시작  -->
			<div class="media">
				<div class="media-body">

					<div class="diary-commant">
						<h4>댓글</h4>
						<div class="diary-commant"
							style="padding: 30px; -moz-border-radius: 10px; -webkit-border-radius: 10px; text-align: center; 
								background: #E6E6FA !important;">

							<%
								for (int i = 0; i < commentview.size(); i++) {
									System.out.println(mem.getId());
									System.out.println(commentview.get(i).getId());
							%>
							<div class="commant-view"
								style="margin-bottom: 20px; padding-left: 38px; padding-right: 38px;">
								<div class="commant-id"
									style="text-align: left; font-weight: 700; margin-bottom: 8px; display: table; width: 100%;">

									<p style="float: left;"><%=commentview.get(i).getId()%></p>
									<p
										style="float: left; margin-left: 10px; font-weight: 300; font-size: 12px; margin-top: 5px;">
										<%=commentview.get(i).getWdate().substring(0, 16)%></p>

									<%
										if (commentview.get(i).getId().equals(mem.getId())) {
												System.out.print(commentview.get(i).getId());
									%>
									<form action="BbsController">
										<input type="hidden" name="command" value="deletecomment">
										<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
										<input type="hidden" name="commentseq"
											value="<%=commentview.get(i).getSeq()%>">
										<button type="submit"
											class="btn btn-outline-secondary waves-effect px-3"
											style="float: right; cursor: pointer;">
											<i class="fa fa-close" aria-hidden="true"></i>
										</button>
									</form>
									<%
										}
									%>

								</div>

								<div class="commant-content"
									style="width: 88%; word-break: break-all; text-align: left; color: #696969">
									<%=commentview.get(i).getContent() %>
								</div>
								<hr>
							</div>

							<%
                           }
                        %>
							<form action="BbsController" method="get">
								<input type="hidden" name="command" value="commentwrite">

								<div class="form-group purple-border"
									style="text-align: left; margin-left: 40px; font-weight: 700; margin-bottom: 8px; padding-left: 20px">
									<label for="exampleFormControlTextarea4"><%=mem.getId() %></label>
									
									<div class="row">
									<div class="col-md-8" style="padding-left: 40px">
									<textarea class="form-control" id="exampleFormControlTextarea4"
										name="dcomment"
										style=" height: 80px; vertical-align: text-bottom;"></textarea>
									<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
									</div>
									
									  <div class="col-md-3" style="padding-left: 50px">
									<button type="submit" class="btn btn-secondary px-3"
										style="height: 68px; vertical-align: text-bottom;">
										<i class="fa fa-commenting" aria-hidden="true"></i>댓글달기
									</button>
									  </div>
									</div>
									
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!--댓글부분 끝  -->
		</div>
	</div>


	<!-- 내용 수정 Modal -->
	<form method="post"
		action="BbsController?command=update&sequence=<%=dto.getSeq() %>">
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalCenterTitle" aria-hidden="true">

			<!-- Add .modal-dialog-centered to .modal-dialog to vertically center the modal -->
			<div class="modal-dialog modal-dialog-centered" role="document">

				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLongTitle">내용 수정</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">

						<div class="form-group green-border-focus">
							<label for="exampleFormControlTextarea5"><input
								name="title" type="text" value="<%=dto.getTitle() %>"></label>
							<textarea name="content" class="form-control" id="updateForm"
								rows="15"><%=dto.getContent() %></textarea>
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<input id="changeBbs" type="submit" class="btn btn-primary"
							value="Save Changes">
					</div>
				</div>

			</div>
		</div>
	</form>

	<!-- 내용 수정 Modal -->

	<!-- 게시글 삭제 Modal -->
	<form method="post"
		action="BbsController?command=delete&sequence=<%=dto.getSeq() %>">
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">

			<!-- Change class .modal-sm to change the size of the modal -->
			<div class="modal-dialog modal-sm" role="document">

				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title w-100" id="myModalLabel">Message</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						게시글을 삭제하시겠습니까? <br> 다시 복구할 수 없습니다.
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-secondary btn-sm"
							data-dismiss="modal" value="아니요"> <input type="submit"
							class="btn btn-primary btn-sm" value="예">
					</div>
				</div>
			</div>
		</div>
	</form>
	<!-- 게시글 삭제 Modal -->
	
	
	<!-- 사진 수정  modal-->
<!--Modal: modalYT-->
<div class="modal fade" id="modalYT" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">

        <!--Content-->
        <div class="modal-content">

            <!--Body-->
            <div class="modal-body mb-0 p-0">
            
            	<img id="bbsimg" alt="" src="upload/<%=dto.getFilename() %>">

            </div>

            <!--Footer-->
            <div class="modal-footer justify-content-center flex-column flex-md-row">
            	<form action="BbsController?command=imgchange" method="post" enctype="multipart/form-data">
					<input type="file" name="imgname" onchange="readURL(this);">     
					<input type="hidden" name="bseq" value="<%=dto.getSeq() %>">
					<button type="submit" class="btn btn-outline-primary btn-rounded btn-md ml-4">완료</button>
            	</form>
            
                <button type="button" class="btn btn-outline-primary btn-rounded btn-md ml-4" data-dismiss="modal">취소</button>
			</div>
        </div>
        <!--/.Content-->
    </div>
</div>
<!--Modal: modalYT-->

<!-- before & next -->

  <div class="container">

    <!--Grid row-->
    <div class="row">
		<%for(int i = 0; i < smaller.size(); i++){ if(i == 3){break;}
		%> <!-- 작은 시퀀스 게시물 3개 -->
      <!--Grid column-->
      <div class="col-lg-2 col-md-6 mb-4">

        <!--Image-->
        <div class="view overlay z-depth-1-half" align="center">
          <img style="width: auto; height: auto; max-height: 178px; max-width: 320px" src="upload/<%=smaller.get(i).getFilename() %>" class="img-fluid" alt="이미지 없음">
          <a href="BbsController?command=detail&sequence=<%=smaller.get(i).getSeq() %>">
            <div class="mask flex-center waves-effect waves-light raba-red-slight">
            	<p class="white-text"><b><strong>[클릭] 이전글 보기</strong></b></p>
            </div>
          </a>
        </div>

      </div>
      <%} %>
      <!--Grid column-->
		<hr style="border-left:1px black solid; position:absolute; left:50%; height:100px;" >
      <!--Grid column-->
      <%for(int i = 0; i < bigger.size(); i++){ if(i == 3){break;}%> <!-- 큰 시퀀스 게시물 3개 -->
      <div class="col-lg-2 col-md-6 mb-4">

        <!--Image-->
         <div class="view overlay z-depth-1-half" align="center">
          <img style="width: auto; height: auto; max-height: 178px; max-width: 320px" src="upload/<%=bigger.get(i).getFilename() %>" class="img-fluid" alt="이미지 없음">
          <a href="BbsController?command=detail&sequence=<%=bigger.get(i).getSeq() %>">
            <div class="mask flex-center waves-effect waves-light raba-red-slight">
            	<p class="white-text"><b><strong>[클릭] 다음글 보기</strong></b></p>
            </div>
          </a>
        </div>

      </div>
      <%} %>
      <!--Grid column-->

    </div>
    <!--Grid row-->

  </div>
  <!-- Footer Elements -->

<!-- before & next -->
	
	<div>
		<input type="hidden" id="m_id" value="<%=mem.getId() %>"> 
		<input type="hidden" id="b_seq" value="<%=dto.getSeq() %>"> 
		<input type="hidden" id="b_fav" value="<%=dto.getFavorite() %>">
	</div>

	<script type="text/javascript">
		
function check_like() {
	var id = $("#m_id").val();
    var bbsSeq  = $("#b_seq").val();
    var favorite = $("#favcount").text();

    /* 
    alert("id =" + id);
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
           //  alert("체크했었음 -> 좋아요 취소");
             $("#favcount").text(jsonObj.favorite);
             offLike();
          }

          else {
          //   alert("체크 가능  -> 좋아요");
             $("#favcount").text(jsonObj.favorite);
             onLike();
          }
          
         // document.location.reload();

       },

       error : function(xhr, status) {
          alert(xhr + " : " + status)
       }
    })
	
}


function onLike(){
	
	$("#btn_fav").addClass("btn-purple");
	
}

function offLike(){
	
	$("#btn_fav").removeClass("btn-purple");
	
}

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#bbsimg').attr('src', e.target.result);

		}
		reader.readAsDataURL(input.files[0]);
	}
}

</script>
	<!-- Definity JS -->
	<script type="text/javascript" src="resources/js/sticky-kit.min.js"></script>
</body>
</html>
<%@ include file="/WEB-INF/include/footer.jsp"%>
