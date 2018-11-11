<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberDto mem = (MemberDto) session.getAttribute("login");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Bootstrap core CSS -->
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="resources/css/mdb.min.css" rel="stylesheet">
<!-- Your custom styles (optional) -->
<link href="resources/css/style.css" rel="stylesheet">
<style type="text/css">
.div-hearder-navbar {
	margin-top: 15px;
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 15px;
	background-color: #f6f6f6;
}

/* Necessary for full page carousel*/
html, header, .view {
	height: 100%;
}

body {
	height: 100%;
	background: url('') no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

/* Carousel*/
.carousel, .carousel-item, .carousel-item.active {
	height: 100%;
}

.carousel-inner {
	height: 100%;
}

.container {
	width: 100%;
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
}

.navbar-toggler-icon {
	color: #E6E5E3;
	border-color: #E6E5E3;
	background-color: #E6E5E3;
}

@media ( min-width : 800px) and (max-width: 850px) {
	.navbar:not (.top-nav-collapse ) {
		background: #1C2331 !important;
	}
}
</style>
</head>
<body>
	<div class="container" id="header">
		<!--Main Navigation-->
		<div>
			<div class="div-hearder-navbar" align="center">
				<a href="index.jsp"><img
					src="https://user-images.githubusercontent.com/38531104/44904424-3f8a1800-ad4a-11e8-8bde-fbbbff45912b.png"
					class="img-fluid" alt="Responsive image"></a>
			</div>
			<!--Navbar-->
			<nav class="navbar navbar-expand-lg navbar-dark"
				style="backgroud-color : white; margin-left : auto; margin-right : auto; margin-bottom : 15px;">

			<!-- Collapse button -->
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#basicExampleNav" aria-controls="basicExampleNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Collapsible content -->
			<div
				class="collapse navbar-collapse justify-content-center font-weight-bold"
				id="basicExampleNav">

				<!-- Links -->
				<ul class="navbar-nav">
					<li class="nav-item hoverable"><a class="nav-link"
						href="index.jsp"
						style="color: black; padding-left: 25px; padding-right: 25px;">Home</a></li>
					<li class="nav-item hoverable"><a class="nav-link"
						href="CalendarController?command=movePage"
						style="color: black; padding-left: 25px; padding-right: 25px;">Event</a></li>
					<li class="nav-item hoverable"><a class="nav-link"
						href="BbsController?command=movePage"
						style="color: black; padding-left: 25px; padding-right: 25px;">Board</a></li>

					<%
						if (mem != null && !mem.getId().equals("")) {
					%>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdownMenuLink"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
						style="color: black">Welcome</a>
						<div class="dropdown-menu dropdown-primary"
							aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="userMyPage.jsp">Mypage</a> 
							<a class="dropdown-item" onclick="logout()">로그아웃</a>
						</div></li>

					<%
						} else {
					%>
					<li class="nav-item hoverable"><a class="nav-link"
						href="login.jsp"
						style="color: black; padding-left: 25px; padding-right: 25px;">Login</a></li>
					<%
						}
					%>
					<%
						if (mem != null && mem.getAuth() == 1) {
					%>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdownMenuLink"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
						style="color: black">Manage</a>
						<div class="dropdown-menu dropdown-primary"
							aria-labelledby="navbarDropdownMenuLink">
							<a class="dropdown-item" href="MemberController?command=userinfo">User
								info</a> <a class="dropdown-item" href="calendar.jsp">Event
								update</a>
						</div></li>
					<%
						}
					%>

				</ul>
				<!-- Links -->
			</div>
			</nav>
			<!--/.Navbar-->
		</div>
	</div>
	<input type="hidden" id="loginStatusCheck" value="">
	<script type="text/javascript">
		function init() {
			console.log('init');
		  gapi.load('auth2', function() {
			  console.log('auth2');
			 window.gauth = gapi.auth2.init({ // gapi.auth2.GoogleAuth 반환
				  client_id:'409625888327-jrr1vc8hdtpd54alerh46jr08rorsirj.apps.googleusercontent.com'
			  })
			  gauth.then(function () {
				  console.log('googleAuth success');
				  window.loginStatusCheck = document.querySelector('#loginStatusCheck');
				  if(gauth.isSignedIn.get()){
					  console.log('logined');
					  loginStatusCheck.value = 'true';
					  console.log(loginStatusCheck.value);
				  }else{
					  console.log('logouted');
					  loginStatusCheck.value = 'false';
					  console.log(loginStatusCheck.value);
				  }
			}, function () {
				console.log('googleAuth fail');
			});
		  });
		}
		
		function login() {
			console.log('로그인 준비 '+loginStatusCheck.value);
				gauth.signIn().then(function() {
			          var profile = gauth.currentUser.get().getBasicProfile();
			          location.href = "MemberController?command=gooleLogin&id="+profile.getId()+"&email="+profile.getEmail()+
						"&name="+profile.getName()+"&img="+profile.getImageUrl();
			        })
				console.log('로그인 성공');
		}
		
		function logout() {
			console.log('로그아웃 준비 '+loginStatusCheck.value);
			if(loginStatusCheck.value == 'true'){
				loginStatusCheck.value = 'false';
				gauth.signOut();
			}
			location.href='MemberController?command=logout';
			console.log('로그아웃 성공');
		}
	</script>
	<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
</body>
</html>