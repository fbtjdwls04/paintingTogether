<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>  	

   	<c:set var="pageTitle" value="PaintingRoom" />
   	
   	<%@ include file="../common/head.jsp" %>
   	<script>
	   	$(function(){
	   		/* 웹소켓 연결 */
            /* 채팅 */
            /* 그림판 */
			const socket = new SockJS('/websocket-endpoint');
			const stompClient = Stomp.over(socket);
			stompClient.reconnect_delay = 1000;
			
		    stompClient.connect({}, function (frame) {

		    	// 채팅 구독
		        stompClient.subscribe('/ws/chat/${roomId}', function (message) {
		        	const getMessage = JSON.parse(message.body);
		        	
		        	if(getMessage.sender == `${nickname}`){
			            $("#chatBox").append("<p class='text-[green]'>"+ getMessage.sender + getMessage.content + "</p>");
		        	}else{
		        		$("#chatBox").append("<p>"+ getMessage.sender + getMessage.content + "</p>");
		        	}
		        });
		        
		    	// 그림판 구독
		        stompClient.subscribe('/ws/canvas/${roomId}', function (message) {
		        	const getUrl = message.body;
		        	printCanvasImg(getUrl);
		        });
		    	
		        sendChat("님이 입장하셨습니다");
		    	
		    	printCanvasImg(`${saveCanvasUrl}`);
		    });
		    
	   		/* 채팅 */
			$("#chatInput").on("keydown", function(e){
				if(e.keyCode == 13){
					const content = " : " + $("#chatInput").val();
			        
					sendChat(content);
			        
					$("#chatInput").val("");
					return false; 
				}
			});
	   		
	   		function sendChat(content) {
	   			stompClient.send("/app/chat/${roomId}", {}, JSON.stringify({
		    		'sender' : `${nickname}`, 
		    		'content' : content
		    		})
		    	);
			}
	   		
	   		//퇴장 시
		    window.onbeforeunload = function(){
		    	sendChat("님이 퇴장하셨습니다")
		    }
	   		
			/* 그림판 */
	   		const canvas = document.getElementById('canvas');
            
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = "#fff";
            ctx.fillRect(0,0,canvas.width, canvas.height);
            ctx.lineWidth = 5;
            ctx.lineCap = 'round';
            
            let painting = false;
			
            function printCanvasImg(url) {
				const img = new Image();
				img.onload = function () {
					ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
				};		        	
				img.src = url;
			}
            
            function startPosition(e) {
                painting = true;
                draw(e);
            }

            function draw(e) {
                if (!painting) return;

                ctx.lineTo(e.offsetX, e.offsetY);
                ctx.stroke();
                ctx.beginPath();
                ctx.moveTo(e.offsetX, e.offsetY);
            }
            
            function endPosition() {
                painting = false;
                ctx.beginPath();
                
                const dataUrl = canvas.toDataURL(); 
                stompClient.send("/app/canvas/${roomId}",{}, dataUrl);
            }

            
            canvas.addEventListener('mousedown', startPosition);
            document.addEventListener('mouseup', endPosition);
            canvas.addEventListener('mousemove', draw);
            
            /* 붓 윤곽선이 마우스를 따라다님 */
            const circle = $('#circle');
            function chaser(e) {
            	circle.css({"left" : e.offsetX + "px", "top" : e.offsetY + "px"});
			}
            
            canvasContainer.addEventListener('mousemove', chaser);

            /* 선 굵기 */
			const lineWidthPicker = document.getElementById('lineWidthPicker');
			const lineWidthValue = document.getElementById('lineWidthValue');
			
	        lineWidthPicker.addEventListener("change",(e)=>{
	        	changeLineWidth();
	        })
	        
	        /* 휠 이벤트로 선 굵기 조절 */
	        canvasContainer.addEventListener('wheel', (e)=>{
            	if (e.deltaY > 0) {
            		lineWidthPicker.value--;
            		changeLineWidth();
            	  } else {
            		lineWidthPicker.value++;
            		changeLineWidth();
            	  }
            });
	        
	        function changeLineWidth() {
	        	ctx.lineWidth = lineWidthPicker.value;
	        	circle.css({"width" : ctx.lineWidth + "px", "height" : ctx.lineWidth + "px"});  // 붓 굵기 윤곽선
	        	lineWidthValue.replaceChildren("선 굵기 : " + ctx.lineWidth + "px");
	        }
	        
	        /* 팔레트 */
	        const colorSelectBtn = $('.colorSelectBtn');
	        const colorList = ['white','black','gray','red','orange','gold','green','blue','skyblue','purple']
	        colorSelectBtn.css("margin-left","10px");
	        
	        for(let i = 0; i < colorSelectBtn.length; i++){
	        	colorSelectBtn[i].addEventListener('click',()=>{
	        		colorSelectBtn.css('border',"");
	        		colorSelectBtn[i].style.border = "3px solid darkgray";
        			ctx.strokeStyle = colorList[i];
	        	})
	        }
	        
	        /* color picker */
	        const colorPicker = document.getElementById('colorPicker');
	        colorPicker.addEventListener("change",(e)=> {
				ctx.strokeStyle = e.target.value;
				colorSelectBtn.css('border',"");
			})
			
			/* 그림 다운로드 */
			const downloadCanvasImage = document.getElementById('downloadCanvasImage');
			downloadCanvasImage.addEventListener('click', function() {
				let a = document.createElement('a');
				a.href = canvas.toDataURL(); 
                a.download = 'canvas_image.png'; // 다운로드될 파일 이름
                a.click();
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
						<button class="colorSelectBtn btn-sm btn-circle flex items-center"><i class="fa-solid fa-eraser text-[20px]"></i></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-black"></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-[gray]"></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-[red]"></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-[orange]"></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-[gold]"></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-[green]"></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-[blue]"></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-[skyblue]"></button>
						<button class="colorSelectBtn btn-sm btn-circle bg-[purple]"></button>
					</div>
					<div class="flex ml-10 items-center">
						<span>사용자 색 정의 &nbsp;</span>
						<input id="colorPicker" type="color" />
					</div>
					
					<div class="ml-20 hover:bg-gray-200">
						<button id="downloadCanvasImage"><i class="fa-solid fa-download text-[20px] p-2"></i></button>
					</div>
				</div>
				<!-- 팔레트 끝 -->
				<!-- 캔버스 영역 -->
				<div id="canvasContainer" class="grow overflow-hidden relative">
					<div id="circle" class="absolute border border-gray-400 rounded-full translate-x-[-49%] translate-y-[-49%] pointer-events-none"></div>
					<canvas id="canvas" class="border" width="512" height="512"></canvas>
				</div>
				<!-- 캔버스 영역 끝 -->
			</div>
			
			<!-- 채팅창 -->
			<div class="w-[300px] border flex flex-col">
				<div class="h-[50px] border flex justify-center items-center">
					<span id="userCnt"></span>
				</div>
				<div id="chatBox" class="h-full p-2 overflow-y-auto border"></div>
				<input id="chatInput" type="text" class="input input-bordered w-full" />
			</div>
		</div>
   	</section>

	<%@ include file="../common/foot.jsp" %>
	
