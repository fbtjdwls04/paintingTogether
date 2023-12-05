<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="MY PAGE" />
	   	
	<%@ include file="../common/head.jsp" %>
   	
   	<script>
   		function doPwModify(e) {
   			e.loginPw.value = e.loginPw.value.trim();
   			e.modifyPw.value = e.modifyPw.value.trim();
   			e.modifyPwChk.value = e.modifyPwChk.value.trim();
   			
   			if(e.loginPw.value.length == 0){
   				alert('현재 비밀번호를 입력해주세요');
   				e.loginPw.focus();
   				return;
   			}
   			if(e.modifyPw.value.length == 0){
   				alert('새로운 비밀번호를 입력해주세요');
   				e.modifyPw.focus();
   				return;
   			}
   			if(e.modifyPwChk.value.length == 0){
   				alert('비밀번호 확인을 입력해주세요');
   				e.modifyPwChk.focus();
   				return;
   			}
   			if(e.modifyPw.value != e.modifyPwChk.value){
   				alert('새로운 비밀번호와 비밀번호 확인이 다릅니다');
   				e.modifyPwChk.focus();
   				return;
   			}
   			
   			e.submit();
		}
   	</script>
   	
	<section class="flex flex-col items-center">
		<form action="doPwModify" onsubmit="doPwModify(this); return false;" method="post">
			<table class="table text-center border">
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="loginPw" class="input input-bordered"/></td>
				</tr>
				<tr>
					<th>새로운 비밀번호</th>
					<td><input type="password" name="modifyPw" class="input input-bordered"/></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="modifyPwChk" class="input input-bordered"/></td>
				</tr>
				<tr>
					<td colspan="2" class="p-0">
						<button class="hover:bg-gray-200 w-full text-center p-4">비밀번호 변경</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	
	<%@ include file="../common/foot.jsp" %>