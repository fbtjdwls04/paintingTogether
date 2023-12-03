<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="ARTICLE WRITE" />
   	
<%@ include file="../common/head.jsp" %>
	
	<section class="container mx-auto flex justify-center">
		<form action="doWrite" onsubmit="writeSubmit(this); return false;" method="post">
			<input name="body" type="hidden"/>
			<table class="table">
				<tr>
					<th>게시판</th>
					<td class="flex">
						<label class="mr-4 flex items-center">
							<input name="boardId" type="radio" value="1" <c:if test="${rq.getLoginedMemberId() != 1}">disabled</c:if>/>
							&nbsp;&nbsp;공지사항
						</label>
						<label class="flex items-center">
							<input name="boardId" type="radio" value="2" checked/>
							&nbsp;&nbsp;자유게시판
						</label>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input name="title" class="input input-bordered w-full " type="text" placeholder="제목을 입력해주세요"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td id="editor"></td>
				</tr>
			</table>
			<div class="flex justify-end">
				<button class="btn btn-success text-[17px]">작성</button>
			</div>
		</form>
	</section>
	
<%@ include file="../common/toast_ui_init.jsp" %>	
<%@ include file="../common/editor_init.jsp" %>	
<%@ include file="../common/foot.jsp" %>