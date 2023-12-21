<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	
   	<c:set var="pageTitle" value="MAIN" />
   	
   	<%@ include file="../common/head.jsp" %>
   	
   	<section class="container mx-auto">
		<div class="flex justify-center">
			<div>
				<form action="/usr/ws/paintingRoom">
					<input type="hidden" name="roomId" value="public"/>
					<button class="btn mr-2">공개방 접속</button>
				</form>
			</div>
			<div><a href="/usr/ws/paintingRoom" class="btn">그림판 방만들기</a></div>
		</div>
   	</section>
	
	<%@ include file="../common/foot.jsp" %>
	
