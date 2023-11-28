<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="MEMBER LOGIN" />
	   	
	<%@ include file="../common/head.jsp" %>
   	<script>
   		function loginSubmit(e) {
   			
   			if(e.loginId.value.trim().length == 0){
   				alert('아이디를 입력해주세요');
   				e.loginId.focus();
   				return;
   			}

   			if(e.loginPw.value.trim().length == 0){
   				alert('비밀번호를 입력해주세요');
   				e.loginPw.focus();
   				return;
   			}
   			
   			e.submit();
		}
   	</script>
   	
	<section class="flex justify-center">
		<form action="doLogin" onsubmit="loginSubmit(this); return false;" method="post">
			<table class="table text-center border" >
				<tr>
					<th>아이디</th>
					<td><input class="input input-bordered w-full max-w-xs" type="text" name="loginId" autocomplete="off"/></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input class="input input-bordered w-full max-w-xs" type="password" name="loginPw" /></td>
				</tr>
				<tr class="hover:bg-base-200">
					<td colspan="2" class="p-0">
						<button class="hover:bg-gray-200 w-full text-center p-4">로그인</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	
	<%@ include file="../common/foot.jsp" %>