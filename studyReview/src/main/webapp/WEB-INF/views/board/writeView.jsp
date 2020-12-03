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
		
		var formObj = $("form[name='writeForm']");
		
		$(".write_btn").on("click", function(){
			if(fn_valiChk()) {
				return false;
			}
			
			formObj.attr("action", "/board/write");
			formObj.attr("method", "post");
			formObj.submit();
		});
		
	});
	
	function fn_valiChk() {
		
		var regForm = $("form[name='writeForm'] .chk").length;
		
		for(var i = 0; i<regForm; i++) {
			if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
		
	}
	
</script>
<body>
	<div id="root">
		<header><h1>게시판</h1></header>
		<hr/>
		
		<div><%@include file="/WEB-INF/views/board/nav.jsp" %></div>
		<hr/>
		
		<section id="container">
			<form name="writeForm" method="post" action="/board/write" enctype="multipart/form-data">
				<table>
					<tbody>
						<c:if test="${member != null }">
							<tr>
								<td>
									<label for="title">제목</label>
									<input class="chk" type="text" id="title" name="title" title="제목을 입력하세요."/>
								</td>
							</tr>
							<tr>
								<td>
									<label for="content">내용</label>
									<textarea class="chk" id="content" name="content" title="내용을 입력하세요."></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer">작성자</label>
									<input class="chk" type="text" id="writer" name="writer" title="작성자를 입력하세요."/>
								</td>
							</tr>
							<tr>
								<td>
									<input type="file" name="file"/>
								</td>
							</tr>
							<tr>
								<td>
									<button class="write_btn" type="button">작성</button>
								</td>
							</tr>
						</c:if>
						
						<c:if test="${member == null }">
							<p>로그인 후에 작성하실 수 있습니다.</p>
						</c:if>
					</tbody>
				</table>
			</form>
		</section>
		<hr/>
	</div>
</body>
</html>