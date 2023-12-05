<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="MY PAGE" />
	   	
	<%@ include file="../common/head.jsp" %>
   	
   	<script>
   		function doModify(e) {
   			e.name.value = e.name.value.trim();
   			e.nickname.value = e.nickname.value.trim();
   			e.cellphoneNum.value = e.cellphoneNum.value.trim();
   			e.email.value = e.email.value.trim();
   			
   			if(e.name.value.length == 0){
   				alert('이름을 입력해주세요');
   				e.name.focus();
   				return;
   			}
   			if(e.nickname.value.length == 0){
   				alert('닉네임을 입력해주세요');
   				e.nickname.focus();
   				return;
   			}
   			//수정 필요
   			if(e.cellphoneNum.value.length == 0){
   				alert('전화번호를 입력해주세요');
   				e.cellphoneNum.focus();
   				return;
   			}
   			if(e.email.value.length == 0){
   				alert('이메일을 입력해주세요');
   				e.email.focus();
   				return;
   			}
   			
   			e.submit();
		}
   		
   		const pwModify = function(e) {
   			if(confirm('정말 '))
   			
			e.submit();
		}
   	</script>
   	
	<section class="flex flex-col items-center">
		<form action="doModify" onsubmit="doModify(this); return false;" method="post">
			<input type="hidden" name="id" value="${loginedMember.id }"/>
			<table class="table text-center border">
				<tr>
					<th>가입일</th>
					<td>${loginedMember.regDate }</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>${loginedMember.loginId }</td>
				</tr>
				<tr>
					<th>회원 수정일</th>
					<td>${loginedMember.updateDate }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input name="name" type="text" value="${loginedMember.name }" class="input input-bordered"/></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input name="nickname" type="text" value="${loginedMember.nickname }" class="input input-bordered"/></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input name="cellphoneNum" type="tel" value="${loginedMember.cellphoneNum }" class="input input-bordered"/></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input name="email" type="email" value="${loginedMember.email }" class="input input-bordered"/></td>
				</tr>
				<tr>
					<td colspan="2" class="p-0">
						<button class="hover:bg-gray-200 w-full text-center p-4">회원 수정 완료</button>
					</td>
				</tr>
			</table>
		</form>
		<div class="h-10"></div>
		<div class="flex justify-around w-[300px]">
			<button class="btn btn-xs btn-outline">
				<a href="/usr/member/pwModify?id=${loginedMember.id }">비밀번호 변경</a>
			</button>
		</div>
	</section>
	
	<%@ include file="../common/foot.jsp" %>