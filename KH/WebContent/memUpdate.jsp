<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	MemberDto mem = (MemberDto) session.getAttribute("login");
%>
<div>
	<!-- Card -->
	<div class="card">

		<!-- Card body -->
		<div class="card-body "
			style="padding: 25%; padding-top: 5%; padding-bottom: 5%">

			<!-- Material form register -->
			<form action="MemberController?command=replace" method="post"
				<% if(mem.getAuth() != 2){%>onsubmit="return joincheck()"<%}%>>
				<!-- Material input text -->
				<div class="md-form row">
					<div class="col-md-8">
						<input type="hidden" name="id" value="<%=mem.getId()%>"> <i
							class="fa fa-user prefix grey-text"></i> <input type="text"
							value="<%=mem.getId()%>" class="form-control" required disabled>
					</div>
					<div class="col-md-4">수정불가</div>
				</div>
				<%
					if(mem.getAuth() == 2){
						%>
				<!-- Password confirm -->
				<div class="md-form row" style="margin-bottom: 0px">
					<!-- Material input password -->
					<div class="col-md-6">
						<i class="fa fa-lock prefix grey-text"></i> <input type="password"
							name="pwd" id="pwd" class="form-control" onkeyup=""
							required disabled> <label for="pwd" class="font-weight-light"
							style="margin-left: 3.5rem;"> -보안-</label>
					</div>
					<!-- Material input password confirm -->
					<div class="col-md-6">
						<i class="fa fa-lock prefix grey-text"></i> <input type="password"
							id="pwd2" class="form-control" onkeyup="" required disabled>
						<label for="pwd2" class="font-weight-light"
							style="margin-left: 3.5rem;"> -보안-</label>
					</div>
				</div>
				
				<input type="hidden" name="pwd" value="<%=mem.getPwd() %>">
				<input type="hidden" name="pwd2" value="<%=mem.getPwd() %>">
				
				<!-- Material input password confirm message -->
				<div class="md-form" style="margin-top: 0px;">
					<input type="text" id="pwdname" class="form-control" value=""
						placeholder="비밀번호 수정불가" disabled
						style="border-bottom: none"> <label for="pwdname"
						class="font-weight-light"></label>
				</div>
				<%
					}else{
				%>
				<!-- Password confirm -->
				<div class="md-form row" style="margin-bottom: 0px">
					<!-- Material input password -->
					<div class="col-md-6">
						<i class="fa fa-lock prefix grey-text"></i> <input type="password"
							name="pwd" id="pwd" class="form-control" onkeyup="pwcheck()"
							required> <label for="pwd" class="font-weight-light"
							style="margin-left: 3.5rem;"> Your password</label>
					</div>
					<!-- Material input password confirm -->
					<div class="col-md-6">
						<i class="fa fa-lock prefix grey-text"></i> <input type="password"
							id="pwd2" class="form-control" onkeyup="pwcheck()" required>
						<label for="pwd2" class="font-weight-light"
							style="margin-left: 3.5rem;"> password confirm</label>
					</div>
				</div>

				<!-- Material input password confirm message -->
				<div class="md-form" style="margin-top: 0px;">
					<input type="text" id="pwdname" class="form-control" value=""
						placeholder="비밀번호를 동일하게 입력하세요" disabled
						style="border-bottom: none"> <label for="pwdname"
						class="font-weight-light"></label>
				</div>
				<%} %>
				<!-- Material input name -->
				<div class="md-form">
					<i class="fa fa-user prefix grey-text"></i> <input type="text"
						name="name" id="name" class="form-control" required> <label
						for="name" class="font-weight-light">Name</label>
				</div>

				<!-- Material input email -->
				<div class="md-form row">
					<div class="col-md-6">
						<input type="hidden" name="email" value="<%=mem.getEmail()%>">
						<i class="fa fa-envelope prefix grey-text"></i> <input type="text"
							name="email" id="email" value="<%=mem.getEmail()%>"
							class="form-control" onkeyup="emailCheck()" required disabled>
					</div>
					<div class="com-md-6">수정불가</div>
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
						<button type="button" class="btn btn-outline-default waves-effect"
							onclick="sample6_execDaumPostcode()"
							style="padding-left: 10px; padding-right: 10px">
							<i class="fa fa-search" aria-hidden="true"></i> 주소찾기
						</button>
					</div>
				</div>

				<!-- address search button -->
				<div class="md-form">
					<input class="form-control" type="text" id="address" name="address"
						placeholder="Confirm your address" readonly="readonly" required>
				</div>
				<div class="md-form">
					<input class="form-control" type="text" id="Detail_Address"
						name="Detail_Address" placeholder="Address Detail" required>
				</div>

				<!-- Sign up -->
				<div class="text-center py-4 mt-3">
					<input type="hidden" name="auth" value="<%=mem.getAuth()%>">
					<input type="hidden" name="img" value="<%=mem.getImg()%>">
					<button class="btn btn-primary" type="submit">수정완료</button>
				</div>

			</form>
			<!-- Material form register -->

		</div>
		<!-- Card body -->

	</div>
	<!-- search address func -->
</div>
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
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
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
	var passwordcheck = "false";

	function joincheck() {
		if (passwordcheck == "false") {
			alert("비밀번호 체크를 하세요");
			return false;
		}
		return true;
	}

	function pwcheck() {
		var pw1 = "";
		var pw2 = "";

		pw1 = $("#pwd").val();
		pw2 = $("#pwd2").val();

		if (pw1 == pw2 && pw1 != "") {
			$("#pwdname").val("비밀번호가 일치합니다").css("color", "blue");
			passwordcheck = "true";
		} else {
			$("#pwdname").val("비밀번호가 불일치합니다").css("color", "red");
			passwordcheck = "false";
		}
	}
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>