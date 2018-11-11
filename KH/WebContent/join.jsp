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

				<!-- Material form register -->
				<form action="MemberController" onsubmit="return joincheck()">
					<p class="h4 text-center py-4">회원가입</p>

					<!-- Material input text -->
					<div class="md-form row">
						<div class="col-md-8">
							<i class="fa fa-user prefix grey-text"></i> <input type="text"
								name="id" id="id" class="form-control" required> <label
								for="id" class="font-weight-light" style="margin-left: 3.5rem;">Your
								id</label>
						</div>
						<div class="col-md-4">
							<button type="button"
								class="btn btn-outline-default waves-effect"
								onclick="idcheck()">
								<i class="fa fa-check-square-o" aria-hidden="true"></i> 중복확인
							</button>
						</div>
					</div>

					<!-- Password confirm -->
					<div class="md-form row" style="margin-bottom: 0px">
						<!-- Material input password -->
						<div class="col-md-6">
							<i class="fa fa-lock prefix grey-text"></i> <input
								type="password" name="pwd" id="pwd" class="form-control"
								onkeyup="pwcheck()" required> <label for="pwd"
								class="font-weight-light" style="margin-left: 3.5rem;">
								Your password</label>
						</div>
						<!-- Material input password confirm -->
						<div class="col-md-6">
							<i class="fa fa-lock prefix grey-text"></i> <input
								type="password" id="pwd2" class="form-control"
								onkeyup="pwcheck()" required> <label for="pwd2"
								class="font-weight-light" style="margin-left: 3.5rem;">
								Your password confirm</label>
						</div>
					</div>

					<!-- Material input password confirm message -->
					<div class="md-form" style="margin-top: 0px;">
						<input type="text" id="pwdname" class="form-control" value=""
							placeholder="비밀번호를 동일하게 입력하세요" disabled
							style="border-bottom: none"> <label for="pwdname"
							class="font-weight-light"></label>
					</div>

					<!-- Material input name -->
					<div class="md-form">
						<i class="fa fa-user prefix grey-text"></i> <input type="text"
							name="name" id="name" class="form-control" required> <label
							for="name" class="font-weight-light">Name</label>
					</div>

					<!-- Material input email -->
					<div class="md-form row">
						<div class="col-md-6">
							<i class="fa fa-envelope prefix grey-text"></i> <input
								type="text" name="email" id="email" class="form-control"
								onkeyup="emailCheck()" required> <label for="email"
								class="font-weight-light" style="margin-left: 3.5rem;">Email</label>
						</div>
						<div class="com-md-6">
							<input type="text" id="emailname" class="form-control" value=""
								placeholder="" disabled style="border-bottom: none"> <label
								for="pwdname" class="font-weight-light"></label>
						</div>
					</div>

					<!-- Material input phone -->
					<div class="md-form">
						<i class="fa fa-phone-square prefix grey-text"></i> <input
							type="text" name="phone" id="phone" class="form-control" required>
						<label for="phone" class="font-weight-light">Confirm your
							phone</label>
					</div>

					<!-- Material input address -->
					<div class="md-form row">
						<div class="col-md-8">
							<i class="fa fa-address-book prefix grey-text"></i> <input
								class="form-control" type="text" id="address_num"
								name="address_num" placeholder="Address Number"
								readonly="readonly" required style="border-bottom: none">
						</div>
						<div class="col-md-4">
							<button type="button"
								class="btn btn-outline-default waves-effect"
								onclick="sample6_execDaumPostcode()">
								<i class="fa fa-search" aria-hidden="true"></i> 주소찾기
							</button>
						</div>
					</div>
					
					<!-- address search button -->
					<div class="md-form">
						<input class="form-control" type="text" id="address"
							name="address" placeholder="Confirm your address"
							readonly="readonly" required>
					</div>
					<div class="md-form">
						<input class="form-control" type="text" id="Detail_Address"
							name="Detail_Address" placeholder="Address Detail" required>
					</div>

					<!-- Sign up -->
					<div class="text-center py-4 mt-3">
						<button class="btn btn-primary" type="submit">Sign Up</button>
						<input type="hidden" name="command" value="join">
					</div>
				</form>
				<!-- Material form register -->

			</div>
			<!-- Card body -->

		</div>
		<!-- search address func -->
	</div>
	<!-- Search Address script -->
	<script>
		function sample6_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var fullAddr = ''; // 최종 주소 변수
							var extraAddr = ''; // 조합형 주소 변수

							// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								fullAddr = data.roadAddress;

							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								fullAddr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
							if (data.userSelectedType === 'R') {
								//법정동명이 있을 경우 추가한다.
								if (data.bname !== '') {
									extraAddr += data.bname;
								}
								// 건물명이 있을 경우 추가한다.
								if (data.buildingName !== '') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
								fullAddr += (extraAddr !== '' ? ' ('
										+ extraAddr + ')' : '');
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('address_num').value = data.zonecode; //5자리 새우편번호 사용
							document.getElementById('address').value = fullAddr;

							// 커서를 상세주소 필드로 이동한다.
							document.getElementById('Detail_Address').focus();
						}
					}).open();
		}
	</script>
	<script type="text/javascript">
		var idok = "false";
		var passwordcheck = "false";
		var emailcheck = "false";

		function idcheck() {

			var id = $("#id").val();

			if (id == "" || null) {

				alert("이메일을 입력하세요.");

				return false;

			}

			$.ajax({
				url : "MemberController?command=idCheck",
				type : "get",
				data : {
					id : $("#id").val()
				},
				success : function(obj) {

					var jsonObj = JSON.parse(obj);
					
					if (jsonObj.duplicated) {
						alert("아이디가 중복됩니다.");
						$("#id").val("");
						idok = "false";
					}

					else {
						alert("중복되는 아이디가 없습니다.");
						idok = "ok";

					}

				},

				error : function(xhr, status) {
					alert(xhr + " : " + status)
				}
			})

		}

		function joincheck() { //id 및 비밀번호 확인후 회원가입 처리페이지로 이동

			if (idok == "false") {

				alert("ID체크를 하세요");

				return false;
			}

			if (passwordcheck == "false") {

				alert("비밀번호 체크를 하세요");

				return false;
			}

			if (emailcheck == "false") {
				alert("email을 확인하세요");
				return false;
			}

			return true;

		}

		function pwcheck() { //비밀번호 재입력 확인 메소드

			var pw1 = "";
			var pw2 = "";

			pw1 = $("#pwd").val();

			pw2 = $("#pwd2").val();

			if (pw1 == pw2 && pw1 != "") {

				$("#pwdname").val("비밀번호가 일치합니다").css("color", "blue");
				;

				passwordcheck = "true";

			} else {
				$("#pwdname").val("비밀번호가 불일치합니다").css("color", "red");
				passwordcheck = "false";
			}

		}

		function emailCheck() {

			var email = $("#email").val();

			if (email == "" || null) {

				$("#emailname").val("빈칸은 허용하지 않습니다").css("color", "red");

				return false;

			}

			$
					.ajax({
						url : "MemberController?command=emailCheck",
						type : "get",
						data : {
							email : $("#email").val()
						},
						success : function(obj) {

							var jsonObj = JSON.parse(obj);
							if (jsonObj.duplicated) {
								$("#emailname").val("이메일이 중복되었습니다").css(
										"color", "red");
								//$("#email").val("");
								emailcheck = "false";
							}

							else {
								$("#emailname").val("이메일이 사용가능").css("color",
										"blue");
								emailcheck = "ok";

							}

						},

						error : function(xhr, status) {
							alert(xhr + " : " + status)
						}
					})
		}
	</script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>



















