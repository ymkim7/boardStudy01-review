<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title></title>

<style type="text/css">
	li {
		list-style : none;
		display : inline;
		padding : 6px;
	}
</style>

</head>
<script type="text/javascript">
	
</script>
<body>

	<ul>
		<li><a href="/board/list">목록</a></li>
		<li><a href="/board/writeView">글 작성</a></li>
		<li>
			<c:if test="member != null"><a href="/member/logout">로그아웃</a></c:if>
			<c:if test="member == null"><a href="/member/login">로그인</a></c:if>
		</li>
		<li>
			<c:if test="${member != null }">
				<p>${member.userId }님 안녕하세요.</p>
			</c:if>
		</li>
	</ul>

</body>
</html>