package com.koreaIT.paintingTogether.handler;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WebSocketHandler extends TextWebSocketHandler{

	private static final ConcurrentHashMap<Integer, WebSocketSession> CLIENTS = new ConcurrentHashMap<Integer, WebSocketSession>();
	
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        CLIENTS.put((Integer) session.getAttributes().get("loginedMemberId"), session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        CLIENTS.remove(session.getAttributes().get("loginedMemberId"));
    }
	
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	int id = (Integer) session.getAttributes().get("loginedMemberId");  //메시지를 보낸 아이디
    	String payload = message.getPayload();
    	session.sendMessage(new TextMessage(id + " : " + payload));
        CLIENTS.entrySet().forEach( arg->{
            if(!arg.getKey().equals(id)) {  //같은 아이디가 아니면 메시지를 전달합니다.
                try {
                    arg.getValue().sendMessage(new TextMessage(id + " : " + payload));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        });
    	
        System.out.println(message);
    	// 클라이언트로부터 메시지를 받아 처리하는 로직
    }
}