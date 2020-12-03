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
		
		var formObj = $("form[name='readForm']");
		
		//수정
		$(".update_btn").on("click", function(){
			formObj.attr("action", "/board/updateView");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		//삭제
		$(".delete_btn").on("click", function(){
			
			var deleteYN = confirm("삭제하시겠습니까?");
			
			if(deleteYN == true){
				formObj.attr("action", "/board/delete");
				formObj.attr("method", "post");
				formObj.submit();
			}
			
		});
		
		//목록
		$(".list_btn").on("click", function(){
			location = "/board/list?page=${scri.page}"
					 + "&perPageNum=${scri.perPageNum}"
					 + "&searchType=${scri.searchType}"
					 + "&keyword=${scri.keyword}";
		});
		
		//댓글 작성
		$(".replyWriteBtn").on("click", function(){
			
			var formObj = $("form[name='replyForm']");
			
			formObj.attr("action", "/board/replyWrite");
			formObj.submit();
			
		});
		
		//댓굴 수정
		$(".replyUpdateBtn").on("click", function(){
			location.href = "/board/replyUpdateView?bno=${read.bno}"
					 + "&page=${scri.page}"
					 + "&perPageNum=${scri.perPageNum}"
				 	 + "&searchType=${scri.searchType}"
				 	 + "&keyword=${scri.keyword}"
				 	 + "&rno="+$(this).attr("data-rno");
		});
		
		//댓굴 삭제
		$(".replyDeleteBtn").on("click", function(){
			location.href = "/board/replyDeleteView?bno=${read.bno}"
					 + "&page=${scri.page}"
					 + "&perPageNum=${scri.perPageNum}"
				 	 + "&searchType=${scri.searchType}"
				 	 + "&keyword=${scri.keyword}"
				 	 + "&rno="+$(this).attr("data-rno");
		});
		
	});
	
	function fn_fileDown(fileNo) {
		
		var formObj = $("form[name='readForm']");
		$("#FILENO").attr("value", FILENO);
		formObj.attr("action", "/board/fileDown");
		formObj.submit();
		
	}
	
</script>
<body>
	<div id="container">
		<header><h1>게시판</h1></header>
		<hr/>
		
		<div><%@include file="/WEB-INF/views/board/nav.jsp" %></div>
		
		<section id="container">
			<form name="readForm" method="post">
				<input type="hidden" id="bno" name="bno" value="${read.bno }"/>
				<input type="hidden" id="page" name="page" value="${scri.page }"/>
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum }"/>
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType }"/>
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword }"/>
				<input type="hidden" id="FILENO" name="FILENO" value=""/>
			</form>
			
			<div class="form-group">
				<label class="col-sm-2 control-label" for="title">제목</label>
				<input class="form-control" type="text" id="title" name="title" value="${read.title }" readonly="readonly"/>
			</div>
			
			<div class="form-group">
				<label class="col-sm-2 control-label" for="content">내용</label>
				<textarea class="form-control" id="content" name="content" readonly="readonly"><c:out value="${read.content }"/></textarea>
			</div>
			
			<div class="form-group">
				<label class="col-sm-2 control-label" for="writer">작성자</label>
				<input class="form-control" type="text" id="writer" name="writer" value="${read.writer }" readonly="readonly"/>
			</div>
			
			<div class="form-group">
				<label class="col-sm-2 control-label" for="regdate">작성날짜</label>
				<fmt:formatDate value="${read.regdate }" pattern="yyyy-MM-dd"/>
			</div>
			<hr/>
			
			<span>파일 목록</span>
			<div class="form-group" style="border:1px solid #dbdbdb;">
				<c:forEach items="${file }" var="file">
					<a href="#" onclick="fn_fileDown('${file.FILENO}'); return false;">${file.ORGFILENAME }</a>(${file.FILESIZE }kb)<br/>
				</c:forEach>
			</div>
			<hr/>
			
			<div>
				<button type="button" class="update_btn btn btn-warning">수정</button>
				<button type="button" class="delete_btn btn btn-danger">삭제</button>
				<button type="button" class="list_btn btn btn-primary">목록</button>
			</div>
			<br/>
			
			<!-- 댓글 -->
			<div id="reply">
				<ol class="replyList">
					<c:forEach items="${replyList }" var="replyList">
						<li>
							<p>작성자 : ${replyList.writer }</p>
							<p>작성날짜 : <fmt:formatDate value="${replyList.regdate }" pattern="yyyy-MM-dd"/></p>
							<p>${replyList.content }</p>
							
							<div>
								<button type="button" class="replyUpdateBtn btn btn-warning" data-rno="${replyList.rno }">수정</button>
								<button type="button" class="replyDeleteBtn btn btn-danger" data-rno="${replyList.rno }">삭제</button>
							</div>
						</li>
					</c:forEach>
				</ol>
			</div>
			
			<form class="form-horizontal" name="replyForm" method="post">
				<input type="hidden" id="bno" name="bno" value="${read.bno }"/>
				<input type="hidden" id="page" name="page" value="${scri.page }"/>
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum }"/>
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType }"/>
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword }"/>
			
				<div class="form-group">
					<label class="col-sm-2 control-label" for="writer">댓글 작성자</label>
					<div class="col-sm-10">
						<input class="form-control" type="text" id="writer" name="writer"/>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-2 control-label" for="content">댓글 내용</label>
					<div class="col-sm-10">
						<input class="form-control" type="text" id="content" name="content"/>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="button" class="replyWriteBtn btn btn-success">작성</button>
					</div>
				</div>
			
			</form>
			
		</section>
		<hr/>
	</div>
</body>
</html>