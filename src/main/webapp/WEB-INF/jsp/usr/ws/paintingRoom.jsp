<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	
   	<c:set var="pageTitle" value="PaintingRoom" />
   	
   	<%@ include file="../common/head.jsp" %>
   	<script>
   	$(function(){
		let ws = new WebSocket("ws://localhost:8081/chat");
		   
		$("#chatInput").on("keydown", function(e){
			if(e.keyCode == 13){
				let text = $("#chatInput").val(); 
				let line = $("<div>"); 
				line.append(text); 
				
				$("#chatInput").val(""); 
				ws.send(text);
				
				return false; 
			}
		});
		
		ws.onmessage  = function(e){
			let line = $("<div>");
			line.append(e.data);
			console.log(e)
			$("#chatBox").append(line);
		}
   	})
   	</script>
   	
   	<section class="flex justify-center h-[700px]">
		<div class="container border-2 flex">
			<div class="grow"></div>
			<div class="w-[300px] border flex flex-col">
				<div id="chatBox" class="h-full"></div>
				<input id="chatInput" type="text" class="input input-bordered w-full" />
			</div>
		</div>
   	</section>
	
	<%@ include file="../common/foot.jsp" %>
	
