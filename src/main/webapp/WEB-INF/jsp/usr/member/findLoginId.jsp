<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<c:set var="pageTitle" value="MEMBER LOGIN" />
	   	
	<%@ include file="../common/head.jsp" %>
   	<script>
   		function loginSubmit(e) {
   			e.name.value = e.name.value.trim();
   			e.email.value = e.email.value.trim();
   			e.cellphoneNum.value = e.cellphoneNum.value.trim();
   			
   			if(e.name.value.length == 0){
   				alert('이름을 입력해주세요');
   				e.name.focus();
   				return;
   			}
   			
   			if(e.email.value.length == 0){
   				alert('이메일을 입력해주세요');
   				e.email.focus();
   				return;
   			}

   			if(e.cellphoneNum.value.length == 0){
   				alert('전화번호를 입력해주세요');
   				e.cellphoneNum.focus();
   				return;
   			}
   			
   			e.submit();
		}
   	</script>
   	
	<section class="flex flex-col justify-center items-center">
		<form action="doFindLoginId" onsubmit="loginSubmit(this); return false;" method="post">
			<table class="table text-center border" >
				<tr>
					<th>이름</th>
					<td><input class="input input-bordered w-full max-w-xs" type="text" name="name" /></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input class="input input-bordered w-full max-w-xs" type="email" name="email" autocomplete="off"/></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input class="input input-bordered w-full max-w-xs" type="tel" name="cellphoneNum" /></td>
				</tr>
				<tr class="hover:bg-base-200">
					<th colspan="2" class="p-0">
						<button class="hover:bg-gray-200 w-full text-center p-4">아이디 찾기</button>
					</th>
				</tr>
			</table>
		</form>
	</section>
	
	<%@ include file="../common/foot.jsp" %>