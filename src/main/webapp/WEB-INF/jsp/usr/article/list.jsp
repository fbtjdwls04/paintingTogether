<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name } 게시판" />

<%@ include file="../common/head.jsp"%>

<section class="container mx-auto">
	<p>
		<c:if test="${searchType != null and searchType != ''}">${searchMsg } (으)로 검색된 </c:if>
		게시물 수 : ${articleCnt }
	</p>
	<table class="table text-[16px] text-center table-fixed">
		<thead>
			<tr>
				<th width="150">번호</th>
				<th>제목</th>
				<th width="150">작성자</th>
				<th width="200">작성일</th>
				<th width="100">조회수</th>
				<th width="40">추천수</th>
			</tr>
		</thead>
		<tbody>
			<!-- 게시물 리스트 시작 -->
			<c:forEach var="article" items="${articles}">
				<tr>
					<td>${article.id}</td>
					<td class="hover:underline truncate">
						<a href="detail?id=${article.id}">
							<span>${article.title}</span>
							<c:if test="${article.replyCnt > 0 }">
								<span class="text-[red]">[${article.replyCnt }]</span>
							</c:if>
						</a>
					</td>
					<td>${article.writerName}</td>
					<td>${article.regDate.substring(2,16)}</td>
					<td>${article.hitCount}</td>
					<td>${article.point}</td>
				</tr>
			</c:forEach>
			<!-- 게시물 리스트 끝 -->
		</tbody>
	</table>

	<c:if test="${articleCnt == 0}">
		<p class="text-[16px] text-center mt-4">
			게시물이 없습니다.
		</p]>
	</c:if>

	<div class="flex justify-end">
		<a class="px-2 hover:underline btn" href="write">글쓰기</a>
	</div>

	<!-- 페이지 리스트 시작 -->
	<div class="flex justify-center items-center flex-wrap">

		<c:set var="baseUri"
			value="boardId=${board.id }&searchType=${searchType}&searchMsg=${searchMsg}"></c:set>
		<!-- 페이지 처음으로 시작 -->
		<c:if test="${beginPage > pageSize}">
			<a class="text-[20px] mx-6"
				href="list?boardPage=1&${baseUri}"> 
				<i class="fa-solid fa-backward flex items-center"></i>
			</a>
		</c:if>
		<!-- 페이지 처음으로 끝 -->
		<!-- 이전 화살표 시작 -->
		<c:if test="${beginPage > 1}">
			<a class="flex justify-center items-center"
				href="list?boardPage=${beginPage-pageSize}&${baseUri}">
				<i class="fa-solid fa-caret-left text-2xl"></i> <span>이전 | </span>
			</a>
		</c:if>
		<!-- 이전 화살표 끝 -->
		<!-- 페이지 번호 시작 -->
		<div class="mx-4">
			<c:forEach var="i" begin="${beginPage }" end="${endPage }" step="1">
				<c:if test="${i <= totalPage }">
					<a
						class="mx-2 hover:underline ${i == boardPage ? 'text-2xl bg-gray-100 text-green-500' : ''}"
						href="list?boardPage=${i}&${baseUri}">${i}</a>
				</c:if>
			</c:forEach>
		</div>
		<!-- 페이지 번호 끝 -->
		<!-- 다음 화살표 시작 -->
		<c:if test="${endPage < totalPage }">
			<a class="flex justify-center items-center"
				href="list?boardPage=${beginPage+pageSize}&${baseUri}">
				<span> | 다음</span> <i class="fa-solid fa-caret-right text-2xl"></i>
			</a>
		</c:if>
		<!-- 다음 화살표 끝 -->
		<!-- 페이지 끝으로 시작 -->
		<c:if test="${beginPage + pageSize < totalPage }">
			<a class="text-[20px] mx-6"
				href="list?boardPage=${totalPage}&${baseUri}">
				<i class="fa-solid fa-forward flex items-center"></i>
			</a>
		</c:if>
		<!-- 페이지 끝으로 끝 -->
	</div>
	<!-- 페이지 리스트 끝 -->
	<!-- 검색창 시작-->
	<script>
		function searchSubmit(e) {
			if (e.searchMsg.value.trim().length == 0) {
				alert('검색어를 입력해주세요');
				e.searchMsg.focus();
				return;
			}

			e.submit();
		}
	</script>

	<form onsubmit="searchSubmit(this); return false;">
		<div class="flex justify-center mt-4">
			<input name="boardId" type="hidden" value="${board.id }" /> 
			<input name="boardPage" type="hidden" value="1" /> 
				<select name="searchType" data-value="${searchType}" class="px-2 max-w-xs border mr-4">
				<option value="title">제목</option>
				<option value="body">내용</option>
				<option value="titleOrBody">제목 + 내용</option>
				<option value="writerName">작성자</option>
			</select> 
			<input name="searchMsg" class="input input-bordered w-full max-w-xs"
				type="text" value="${searchMsg }" placeholder="검색어를 입력해주세요" />
			<button class="btn ml-2">검색</button>
		</div>
	</form>
	<!-- 검색창 끝-->
</section>

<%@ include file="../common/foot.jsp"%>