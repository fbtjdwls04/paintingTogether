<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="MEMBER JOIN" />
	   	
	<%@ include file="../common/head.jsp" %>
   	
   	<script>
   		function joinSubmit(e) {
   			
   			if(e.nickname.value.trim().length == 0){
   				alert('닉네임을 입력해주세요');
   				e.nickname.focus();
   				return;
   			}
   			//수정 필요
   			if(e.cellphoneNum.value.trim().length == 0){
   				alert('전화번호를 입력해주세요');
   				e.cellphoneNum.focus();
   				return;
   			}
   			if(e.email.value.trim().length == 0){
   				alert('이메일을 입력해주세요');
   				e.email.focus();
   				return;
   			}
   			
   			e.submit();
		}
   	</script>
   	
	<section class="flex flex-col items-center">
		<form action="doModify" onsubmit="joinSubmit(this); return false;" method="post">
			<table class="table text-center border">
				<tr>
					<th>아이디</th>
					<td>${loginedMember.loginId }</td>
				</tr>
				<tr>
					<th>가입일</th>
					<td>${loginedMember.regDate }</td>
				</tr>
				<tr>
					<th>회원 수정일</th>
					<td>${loginedMember.updateDate }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${loginedMember.name }</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input name="nickName" type="text" value="${loginedMember.nickname }" class="input input-bordered"/></td>
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
		<table class="table text-center border w-[200px]">
			<tr>
				<th class="p-0"><a class="hover:bg-gray-200 text-center p-4 block" href="/usr/member/pwModify">비밀번호 변경</a></th>
			</tr>
			<tr>
				<td class="p-0"><a class="hover:bg-gray-200 w-full text-center p-4 block"  href="/usr/member/resign">회원 탈퇴</a></td>
			</tr>
		</table>
	</section>
	
	<%@ include file="../common/foot.jsp" %>