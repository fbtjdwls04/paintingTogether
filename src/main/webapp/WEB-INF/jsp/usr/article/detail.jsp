<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="ARTICLE DETAIL" />
	
	<%@ include file="../common/head.jsp" %>
  	
  	<script>
	  	$(document).ready(function(){
			getRecommendPoint();
			
			$('#recommendBtn').click(function(){
				
				let recommendBtn = $('#recommendBtn').hasClass('btn-active');
				
				$.ajax({
					url: "../recommendPoint/doRecommendPoint",
					method: "get",
					data: {
							"relTypeCode" : "article",
							"relId" : ${article.id },
							"recommendBtn" : recommendBtn
						},
					dataType: "text",
					success: function(data) {
						console.log(data);
					},
					error: function(xhr, status, error) {
						console.error("ERROR : " + status + " - " + error);
					}
				})
				
				location.reload();
			})
		})
		
		const getRecommendPoint = function(){
				$.ajax({
					url: "../recommendPoint/getRecommendPoint",
					method: "get",
					data: {
							"relTypeCode" : "article",
							"relId" : ${article.id }
						},
					dataType: "json",
					success: function(data) {
						if (data.success) {
							$('#recommendBtn').addClass('btn-active');
						}
					},
					error: function(xhr, status, error) {
						console.error("ERROR : " + status + " - " + error);
					}
				})
			}
	</script>
  	
	<section class="flex justify-center">
		<div class="container">
			<!-- 게시물 -->
			<table class="table table-fixed break-words" >
				<tr>
					<td>번호 : ${article.id}</td>
				</tr>
				<tr>
					<td>
						<p class="text-bold text-3xl" >${article.title }</p>
						<br />
						<p class="text-base font-bold">
							<i class="fa-regular fa-user"></i>
							${article.writerName}
						</p>
						<span>${article.updateDate.substring(2,16) }</span>
						&nbsp;
						<span>조회 ${article.hitCount }</span>
						&nbsp;
						<span>추천 ${article.point}</span>
						
					</td>
				</tr>
				<tr>
					<td id="viewer">
						${article.body }
					</td>
				</tr>
			</table>
			<hr />
			<!-- 수정 삭제버튼 시작 -->
			<div class="flex mt-[20px]">
				<c:if test="${loginedMemberId == article.memberId }">
					<button class="btn btn-outline btn-s ml-2"><a href="modify?id=${article.id }">수정</a></button>
					<button class="btn btn-outline btn-s ml-2" onclick="if(confirm('${article.id }번 글을 삭제하시겠습니까?')) location.replace('doDelete?id=${article.id}');">삭제</button>
				</c:if>
			</div>
			<!-- 수정 삭제버튼 끝 -->
		</div>
	</section>
	
	<script>
		/* 댓글 작성 */
		const replyWriteSubmit = function(e) {
			const body = e.body;
			
			if(body.value.trim().length == 0){
				alert('내용을 입력해주세요');
				body.focus();
			}
			
			e.submit();
		}
		/* 댓글 수정 */
		const replyModifySubmit = function(e) {
			const body = e.body;
			
			if(body.value.trim().length == 0){
				alert('내용을 입력해주세요');
				body.focus();
			}
			
			e.submit();
		}
		/* 수정 입력칸 열기 */
		const replyModify_getForm = function(id) {
			/* 해당 댓글을 제외한 나머지는 댓글만 보이게 (수정 입력칸 여러개 안켜지게) */
			$('.reply').css("display", "flex");
			$('.modifyReplyForm').css("display", "none");
			/*  */
			
			$('#reply' + id).css("display", "none");
			$('#modifyReplyForm' + id).css("display", "flex");
		}
		
		/* 수정 입력칸 닫기 */
		const replyModify_cancle = function(id) {
			$('#reply' + id).css("display", "flex");
			$('#modifyReplyForm' + id).css("display", "none");
		}
		
	</script>
	<!-- 댓글 -->
	<section class="flex justify-center my-4">
		<div class="container">
			<div class="p-4">
				<c:if test="${rq.getLoginedMemberId() != 0 }">
					<button id="recommendBtn" class="mr-4 btn-text-color btn btn-sm">좋아요👍</button>
				</c:if>
				<span>댓글 ${replies.size() }</span>
			</div>
			<div class="border px-10 rounded-[10px]">
				<h2 class="text-2xl py-4">댓글</h2>
				<!-- 댓글 입력창 -->
				<c:if test="${rq.getLoginedMemberId() != 0 }">
					<form action="/usr/reply/doWrite" onsubmit="replyWriteSubmit(this); return false;">
						<input name="relId" value="${article.id }" type="hidden" />
						<input name="relTypeCode" value="article" type="hidden" />
						<div class="font-semibold ml-2 mb-2">${loginedMember.getNickname()}</div>
						<div class="flex">
							<textarea name="body" rows="1" class="textarea textarea-bordered w-full" placeholder="댓글을 입력해주세요"></textarea>
							<button class="btn">등록</button>
						</div>
					</form>
				</c:if>
				<c:if test="${rq.getLoginedMemberId() == 0 }">
					<span>댓글은 로그인 후 이용이 가능합니다</span>
				</c:if>
				
				<!-- 댓글 리스트 -->
				<div class="mt-8">
					<c:forEach var="reply" items="${replies }">
						<div id="reply${reply.id }" class="reply flex mt-4">
							<div class="w-[50px]"></div>
							<div>
								<div class="font-semibold">${reply.writerName }</div>
								<div class="whitespace-pre-wrap ml-2">${reply.body}</div>
								<div class="ml-2 text-sm text-[gray]">${reply.updateDate}</div>
							</div>
							<!-- 수정, 삭제 버튼 -->
							<c:if test="${reply.memberId == rq.getLoginedMemberId() }">
								<div class="dropdown dropdown-end ml-auto">
									<button class="btn btn-square btn-ghost ml-auto">
		      							<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
		    						</button>
		    						<ul class="p-2 shadow menu dropdown-content z-[1] bg-base-100 rounded-box w-20">
									    <li><button onclick="replyModify_getForm(${reply.id })">수정</button></li>
									    <li><a href="/usr/reply/doDelete?id=${reply.id }" onclick="if(confirm('정말 삭제하시겠습니까?')== false) return false;">삭제</a></li>
								  	</ul>
								</div>
							</c:if>
							<!-- 수정, 삭제 버튼 끝-->
						</div>
						<!-- 댓글 수정 Form, 수정버튼 누르기 전에는 display none -->
						<c:if test="${reply.memberId == rq.getLoginedMemberId() }">
							<div id="modifyReplyForm${reply.id }" class="modifyReplyForm hidden mt-4" >
								<div class="w-[50px]"></div>
								<form action="/usr/reply/doModify" onsubmit="replyModifySubmit(this); return false;" class="grow">
									<input name="id" value="${reply.id }" type="hidden" />
									<div class="font-semibold ml-2 mb-2">${loginedMember.getNickname()}</div>
									<textarea name="body" class="textarea textarea-bordered w-full" placeholder="댓글을 입력해주세요">${reply.body }</textarea>
									<div class="flex justify-end">
										<button class="btn btn-sm" type="button" onclick="replyModify_cancle(${reply.id })">취소</button>
										<button class="btn btn-sm">등록</button>
									</div>
								</form>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
<%@ include file="../common/toast_ui_init.jsp" %>
<%@ include file="../common/viewer_init.jsp" %>	
<%@ include file="../common/foot.jsp" %>