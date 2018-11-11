<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp"%>
<html>
<head>
<title>Honey Jam</title>
</head>
<body>
	<div class="container" style="margin-bottom: 10px">
		<!-- Card -->
		<div class="card">

			<!-- Card body -->
			<div class="card-body "
				style="padding: 25%; padding-top: 5%; padding-bottom: 5%">

				<form action="MemberController?command=login" method="post">
					<p class="h4 text-center py-4">LOGIN</p>

					<!-- Material input text -->
					<div class="md-form">
						<i class="fa fa-user prefix grey-text"></i> <input type="text"
							name="id" id="materialFormCardNameEx" class="form-control">
						<label for="materialFormCardNameEx" class="font-weight-light">Your
							id</label>
					</div>

					<!-- Material input password -->
					<div class="md-form">
						<i class="fa fa-lock prefix grey-text"></i> <input type="password"
							name="pwd" id="materialFormCardPasswordEx" class="form-control">
						<label for="materialFormCardPasswordEx" class="font-weight-light">Your
							password</label>
					</div>

					<div class="text-center py-4 mt-3">
						<button class="btn btn-primary" type="submit">Login</button>
						<button type="button" class="btn btn-primary"
							onclick="location.href='join.jsp'">Sign up</button>
					</div>
				</form>
				<p
					class="font-small dark-grey-text text-right d-flex justify-content-center mb-3 pt-2">
					or Sign in with:</p>
				<div class="row my-3 d-flex justify-content-center">
					<!--Google +-->
					<button type="button" id="loginBtn" class="btn btn-white btn-rounded z-depth-1a" 
					onclick="login()">
			           <i class="fa fa-google-plus blue-text"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>