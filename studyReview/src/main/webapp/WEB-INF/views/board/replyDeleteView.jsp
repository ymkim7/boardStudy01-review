<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<title>게시판</title>
</head>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		var formObj = $("form[name='deleteForm']");
		
		$(".cancel_btn").on("click", function(){
			location.href = "/board/readView?bno=${replyDelete.bno}"
				 + "&page=${scri.page}"
				 + "&perPageNum=${scri.perPageNum}"
				 + "&searchType=${scri.searchType}"
				 + "&keyword=${scri.keyword}";
		});
		
	});
	
</script>
<body>
	<div id="root">
		<header><h1>게시판</h1></header>
		<hr/>
		
		<div><%@include file="/WEB-INF/views/board/nav.jsp" %></div>
		<hr/>
		
		<section id="container">
			<form name="deleteForm" method="post" action="/board/replyDelete">
				<input type="hidden" id="bno" name="bno"value="${replyDelete.bno }"/>
				<input type="hidden" id="rno" name="rno"value="${replyDelete.rno }"/>
				<input type="hidden" id="page" name="page"value="${scri.page }"/>
				<input type="hidden" id="perPageNum" name="perPageNum"value="${scri.perPageNum }"/>
				<input type="hidden" id="searchType" name="searchType"value="${scri.searchType }"/>
				<input type="hidden" id="keyword" name="keyword"value="${scri.keyword }"/>
				
				<div>
					<p>삭제 하시겠습니까?</p>
					<button type="submit" class="delete_btn">삭제</button>
					<button type="button" class="cancel_btn">취소</button>
				</div>
			</form>
		</section>
		<hr/>
	</div>
</body>
</html>