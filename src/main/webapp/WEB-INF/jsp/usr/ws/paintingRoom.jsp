<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   	
   	<c:set var="pageTitle" value="PaintingRoom" />
   	
   	<%@ include file="../common/head.jsp" %>
   	<script>
	   	$(function(){
	   		
	   		const canvas = document.getElementById('canvas');
            const canvasContainer = document.getElementById('canvasContainer');
            canvas.width = canvasContainer.offsetWidth;
            canvas.height = canvasContainer.offsetHeight;
            const ctx = canvas.getContext('2d');
            
            /* 웹소켓 연결 */
            
			const socket = new SockJS('/websocket-endpoint');
			const stompClient = Stomp.over(socket);
			
		    stompClient.connect({}, function (frame) {
		        stompClient.subscribe('/ws/chat', function (message) {
		        	const getMessage = JSON.parse(message.body);
		        	
		        	if(getMessage.sender == "${nickname}"){
			            $("#chatBox").append("<p class='text-[green]'>"+ getMessage.sender + " : " + getMessage.content + "</p>");
		        	}else{
		        		$("#chatBox").append("<p>"+ getMessage.sender + " : " + getMessage.content + "</p>");
		        	}
		        });
		        
		        stompClient.subscribe('/ws/canvas', function (message) {
		        	const getUrl = JSON.parse(message.body);
		        	
		        	const img = new Image();
					img.onload = function () {
						ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
					};		        	
					img.src = getUrl.url;
		        });
		    });
            
		    stompClient.reconnect_delay = 1000;
	   		/* 채팅 ws */
		    
			$("#chatInput").on("keydown", function(e){
				if(e.keyCode == 13){
					const content = $("#chatInput").val();
					const sender = "${nickname}"; // You can customize the sender logic
					const message = {'content': content, 'sender': sender};
			        
			        stompClient.send("/app/chat", {}, JSON.stringify(message));
			        
					$("#chatInput").val("");
					return false; 
				}
			});
			
			/* 그림판 ws */
			
            ctx.lineWidth = 5;
            ctx.lineCap = 'round';
            
            let painting = false;

            function startPosition(e) {
                painting = true;
                draw(e);
            }

            function endPosition() {
                painting = false;
                ctx.beginPath();
                const dataUrl = canvas.toDataURL(); 
                stompClient.send("/app/canvas",{}, JSON.stringify({'url' : dataUrl}));
            }

            function draw(e) {
                if (!painting) return;

                ctx.lineTo(e.clientX - canvas.offsetLeft, e.clientY - canvas.offsetTop);
                ctx.stroke();
                ctx.beginPath();
                ctx.moveTo(e.clientX - canvas.offsetLeft, e.clientY - canvas.offsetTop);
            }
            
            canvas.addEventListener('mousedown', startPosition);
            document.addEventListener('mouseup', endPosition);
            canvas.addEventListener('mousemove', draw);
	        
	        /* 선 굵기 */
			const lineWidthPicker = document.getElementById('lineWidthPicker');
			const lineWidthValue = document.getElementById('lineWidthValue');
			
	        lineWidthPicker.addEventListener("change",(e)=>{
	        	ctx.lineWidth = e.target.value;
	        	lineWidthValue.replaceChildren("선 굵기 : " + ctx.lineWidth + "px"); 
	        })
	        
	        /* 팔레트 */
	        const colorBtn = $('.colorBtn');
	        const colorList = ['white','black','gray','red','orange','gold','green','blue','skyblue','purple']
	        colorBtn.css("margin-left","10px");
	        
	        for(let i = 0; i < colorBtn.length; i++){
	        	colorBtn[i].addEventListener('click',()=>{
	        		colorBtn.css('border',"");
	        		colorBtn[i].style.border = "3px solid darkgray";
        			ctx.strokeStyle = colorList[i];
	        	})
	        }
	        
	        /* color picker */
	        const colorPicker = document.getElementById('colorPicker');
	        colorPicker.addEventListener("change",(e)=> {
				ctx.strokeStyle = e.target.value;
				colorBtn.css('border',"");
			})
	   	});
	   	
	   	
    </script>
   	<section class="flex justify-center">
		<div class="container h-[700px] border-2 flex">
			<div class="flex flex-col grow">
				<!-- 팔레트 영역-->
				<div class="h-[50px] border flex items-center">
					<div class="flex mx-4">
						<span id="lineWidthValue" class="w-[120px]">선 굵기 : 5px</span>
						<input id="lineWidthPicker" type="range" min="1" max="100" value="5" class="range w-[200px] ml-4" step="1" />
					</div>
					<div class="flex items-center justify-around ml-4">
						<button class="colorBtn btn-sm btn-circle"><i class="fa-solid fa-eraser text-[20px]"></i></button>
						<button class="colorBtn btn-sm btn-circle bg-black"></button>
						<button class="colorBtn btn-sm btn-circle bg-[gray]"></button>
						<button class="colorBtn btn-sm btn-circle bg-[red]"></button>
						<button class="colorBtn btn-sm btn-circle bg-[orange]"></button>
						<button class="colorBtn btn-sm btn-circle bg-[gold]"></button>
						<button class="colorBtn btn-sm btn-circle bg-[green]"></button>
						<button class="colorBtn btn-sm btn-circle bg-[blue]"></button>
						<button class="colorBtn btn-sm btn-circle bg-[skyblue]"></button>
						<button class="colorBtn btn-sm btn-circle bg-[purple]"></button>
					</div>
					<div class="flex ml-10">
						<span>사용자 색 정의 &nbsp;</span>
						<input id="colorPicker" type="color" />
					</div>
				</div>
				<!-- 팔레트 끝 -->
				<!-- 캔버스 영역 -->
				<div id="canvasContainer" class="grow">
					<canvas id="canvas" class="border"></canvas>
				</div>
				<!-- 캔버스 영역 끝 -->
			</div>
			
			<!-- 채팅창 -->
			<div class="w-[300px] border flex flex-col">
				<div class="h-[50px] border flex justify-center items-center">
					<span id="userCnt"></span>
				</div>
				<div id="chatBox" class="h-full p-2 overflow-y-auto"></div>
				<input id="chatInput" type="text" class="input input-bordered w-full" />
			</div>
		</div>
   	</section>
	
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<%@ include file="../common/foot.jsp" %>
	
