<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	
   	<c:set var="pageTitle" value="MAIN" />
   	
   	<%@ include file="../common/head.jsp" %>
   	
   	<script>
   		
   	</script>
   	
   	<section class="container mx-auto">
		<div class="flex justify-center">
			<div>
				<form action="/usr/ws/paintingRoom">
					<input type="hidden" name="roomId" value="public"/>
					<button class="btn mr-2">공개방 접속</button>
				</form>
			</div>
			<div id="createRoom">
				<form action="/usr/ws/paintingRoom" onsubmit="roomSubmit(this); return false;">
					<table>
						<tr>
							<th>방제</th>
						</tr>
						<tr>
							<td><input type="text" name="roomId" class="input input-bordered" autocomplete="off"/></td>
						</tr>
						<tr>
							<th>비밀번호</th>
						</tr>
						<tr>
							<td><input type="password" name="roomPw" class="input input-bordered"/></td>
						</tr>
						<tr>
							<th>
								<button class="btn mr-2">생성</button>
							</th>
						</tr>
					</table>
				</form>
			</div>
		</div>
   	</section>
	
	<%@ include file="../common/foot.jsp" %>
	
