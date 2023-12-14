<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="member list" />

<%@ include file="../../usr/common/head.jsp"%>
	<section class="container mx-auto">
		<p>
			<c:if test="${searchType != null and searchType != ''}">${searchMsg } (으)로 검색된 </c:if>
			멤버 수 : ${memberCnt }
		</p>
		<table class="table text-[16px] text-center table-fixed">
			<thead>
				<tr>
					<th><input type="checkbox" class="checkbox-all-member-id" /></th>
					<th>번호</th>
					<th>가입날짜</th>
					<th>수정날짜</th>
					<th>아이디</th>
					<th>이름</th>
					<th>닉네임</th>
					<th>삭제여부</th>
					<th>삭제날짜</th>
				</tr>
			</thead>
			<tbody>
				<!-- 게시물 리스트 시작 -->
				<c:forEach var="member" items="${members}">
					<c:if test="${member.authLevel != 1 }">
						<tr class="hover">
							<c:choose>
								<c:when test="${member.delStatus != 1 }">
									<td><input type="checkbox" class="checkbox-member-id" name="ids" value="${member.id }" /></td>
								</c:when>
								<c:otherwise>
									<td><input type="checkbox" class="checkbox-member-id" name="ids" value="${member.id }" disabled /></td>
								</c:otherwise>
							</c:choose>
							<td>${member.id }</td>
							<td>${member.regDate.substring(2, 16) }</td>
							<td>${member.updateDate.substring(2, 16) }</td>
							<td>${member.loginId }</td>
							<td>${member.name }</td>
							<td>${member.nickname }</td>
							<td>${member.delStatus }</td>
							<td>${member.delDate }</td>
						</tr>
					</c:if>
				</c:forEach>
				<!-- 게시물 리스트 끝 -->
			</tbody>
		</table>
		
		<script>
			$('.checkbox-all-member-id').change(function() {
				const allCheck = $(this);
				const allChecked = allCheck.prop('checked');
				$('.checkbox-member-id').prop('checked', allChecked);
				$('.checkbox-member-id:is(:disabled)').prop('checked', false);
			})
			
			$('.checkbox-member-id').change(function() {
				const checkboxMemberIdCount = $('.checkbox-member-id').length;
				const checkboxMemberIdCheckedCount = $('.checkbox-member-id:checked').length;
				const checkboxDisabledCount = $('.checkbox-member-id:is(:disabled)').length;
				const allChecked = (checkboxMemberIdCount - checkboxDisabledCount) == checkboxMemberIdCheckedCount;
				$('.checkbox-all-member-id').prop('checked', allChecked);
			})
		</script>
		
		<c:if test="${memberCnt == 0}">
			<p class="text-[16px] text-center mt-4">
				멤버가 없습니다
			</p>
		</c:if>
	
		<div class="mt-2 flex justify-end">
			<button class="btn btn-outline btn-sm btn-delete-selected-members">회원 삭제</button>
			</div>
			
			<form action="doDeleteMembers" method="POST" name="do-delete-members-form">
				<input type="hidden" name="ids" value="" />
			</form>
			
			<script>
				$('.btn-delete-selected-members').click(function() {
					const values = $('.checkbox-member-id:checked').map((index, el) => el.value).toArray();
					if (values.length == 0) {
						alert('선택한 회원이 없습니다');
						return;
					}
					if (confirm('선택한 회원을 삭제하시겠습니까?') == false) {						
						return;
					}
					$('input[name=ids]').val(values.join(','));
					$('form[name=do-delete-members-form]').submit();
				})
			</script>
	
		<!-- 페이지 리스트 시작 -->
		<div class="flex justify-center items-center flex-wrap">
	
			<c:set var="baseUri"
				value="searchType=${searchType}&searchMsg=${searchMsg}"></c:set>
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
				<input name="boardPage" type="hidden" value="1" /> 
					<select name="searchType" data-value="${searchType}" class="px-2 max-w-xs border mr-4">
					<option value="loginId">아이디</option>
					<option value="name">이름</option>
					<option value="nickname">닉네임</option>
				</select> 
				<input name="searchMsg" class="input input-bordered w-full max-w-xs"
					type="text" value="${searchMsg }" placeholder="검색어를 입력해주세요" />
				<button class="btn ml-2">검색</button>
			</div>
		</form>
		<!-- 검색창 끝-->
	</section>

<%@ include file="../../usr/common/foot.jsp"%>