<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>Home</title>
</head>
<a href="/board/list">게시판</a><br/>
<script type="text/javascript">

	$(document).ready(function(){
		
		$("#logoutBtn").on("click", function(){
			location.href = "member/logout";
		});
		
		$("#registerBtn").on("click", function(){
			location.href = "member/register";
		});
		
		$("#memberUpdateBtn").on("click", function(){
			location.href = "member/memberUpdateView";
		});
		
		$("#deleteBtn").on("click", function(){
			location.href = "member/memberDeleteView";
		});
		
	});

</script>
<body>
	<form name="homeForm" method="post" action="/member/login">
		<c:if test="${member == null }">
			<div>
				<label for="userId"></label>
				<input type="text" id="userId" name="userId"/>
			</div>
			
			<div>
				<label for="userPass"></label>
				<input type="password" id="userPass" name="userPass"/>
			</div>
			<div>
				<button type="submit">로그인</button>
				<button type="button" id="registerBtn">회원가입</button>
			</div>
		</c:if>
		
		<c:if test="${member != null }">
			<div>
				<p>${member.userId }님 환영합니다.</p>
				<button type="button" id="memberUpdateBtn">회원정보수정</button>
				<button type="button" id="logoutBtn">로그아웃</button>
				<button type="button" id="deleteBtn">회원탈퇴</button>
			</div>
		</c:if>
		
		<c:if test="${msg == false }">
			<p style="color:red;">로그인 실패! 아이디와 비밀번호를 확인해주세요.</p>
		</c:if>
	</form>
</body>
</html>
