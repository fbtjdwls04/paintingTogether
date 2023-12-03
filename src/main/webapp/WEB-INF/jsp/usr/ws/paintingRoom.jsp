<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	
   	<c:set var="pageTitle" value="PaintingRoom" />
   	
   	<%@ include file="../common/head.jsp" %>
   	<script>
	   	$(function(){
			const ws = new WebSocket("ws://localhost:8081/chat");
			   
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
				$("#chatBox").append(line);
			}
			
			const ws_UserCnt = new WebSocket("ws://localhost:8081/connectedUsers");
			
			ws_UserCnt.onmessage  = function(e){
				let line = $("<div>");
				line.append(e.data);
				$("#userCnt").html(line);
			}
			
			const ws_painting = new WebSocket('ws://localhost:8081/painting');
			
            const canvas = document.getElementById('canvas');
            const canvasContainer = document.getElementById('canvasContainer');
            canvas.width = canvasContainer.offsetWidth;
            canvas.height = canvasContainer.offsetHeight;
            
            const ctx = canvas.getContext('2d');
		   	
            let painting = false;

            function startPosition(e) {
                painting = true;
                draw(e);
            }

            function endPosition() {
                painting = false;
                ctx.beginPath();
                ws_painting.send(canvas.toDataURL('image/jpeg', 0.5));
            }

            function draw(e) {
                if (!painting) return;

                ctx.lineWidth = 5;
                ctx.lineCap = 'round';
                ctx.strokeStyle = '#000';

                ctx.lineTo(e.clientX - canvas.offsetLeft, e.clientY - canvas.offsetTop);
                ctx.stroke();
                ctx.beginPath();
                ctx.moveTo(e.clientX - canvas.offsetLeft, e.clientY - canvas.offsetTop);
            }
			
            canvas.addEventListener('mousedown', startPosition);
            document.addEventListener('mouseup', endPosition);
            canvas.addEventListener('mousemove', draw);
			
            ws_painting.onmessage = function(e){
	            const drawing = new Image();
	            drawing.onload = function () {
	                ctx.drawImage(drawing, 0, 0);
	            };
	            drawing.src = e.data;
	        };
	   	})
    </script>
   	<section class="flex justify-center">
		<div class="container h-[700px] border-2 flex">
			<div id="canvasContainer" class="grow">
				<canvas id="canvas" class="border"></canvas>
			</div>
			<div class="w-[300px] border flex flex-col">
				<div class="h-[50px] border flex justify-center items-center">
					<span></span>
					&nbsp;
					<span id="userCnt"></span>
				</div>
				<div id="chatBox" class="h-full p-2 overflow-y-auto"></div>
				<input id="chatInput" type="text" class="input input-bordered w-full" />
			</div>
		</div>
   	</section>
	
	<%@ include file="../common/foot.jsp" %>
	
