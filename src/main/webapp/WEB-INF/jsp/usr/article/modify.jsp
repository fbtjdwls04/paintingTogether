<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="ARTICLE WRITE" />

<%@ include file="../common/head.jsp"%>

	<script>
		$(document).ready(function(){
			$.ajax({
				url: "getArticle",
				method: "get",
				data: {
						"id" : ${article.id },
					},
				dataType: "json",
				success: function(data) {
					editor.setHTML(data.data.body);
				},
				error: function(xhr, status, error) {
					console.error("ERROR : " + status + " - " + error);
				}
			})
		}) 
	
	</script>
	
	<section class="container mx-auto flex justify-center">
		<form action="doModify"
			onsubmit="submitForm(this); return false;" method="post">
			<input name="id" type="hidden" value="${article.id }" />
			<input name="body" type="hidden" />
			<table class="table">
				<tr>
					<th>번호</th>
					<td>${article.id}</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td>${article.regDate.substring(2,16)}</td>
				</tr>
				<tr>
					<th>수정일</th>
					<td>${article.updateDate.substring(2,16) }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${article.writerName}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input name="title" class="input input-bordered w-full" type="text" 
						placeholder="제목을 입력해주세요" value="${article.title}" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td id="editor"></td>
				</tr>
			</table>
			<div class="flex justify-end mr-4">
				<button class="btn">수정</button>
			</div>
		</form>
	</section>
	
<%@ include file="../common/toast_ui_init.jsp" %>	
<%@ include file="../common/editor_init.jsp" %>	
<%@ include file="../common/foot.jsp"%>