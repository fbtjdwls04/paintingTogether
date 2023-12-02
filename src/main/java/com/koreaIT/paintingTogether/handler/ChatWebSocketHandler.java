package com.koreaIT.paintingTogether.handler;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler{

	private static final ConcurrentHashMap<String, WebSocketSession> CLIENTS = new ConcurrentHashMap<String, WebSocketSession>();
	
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	String nickname = (String) session.getAttributes().get("loginedMemberNickname");
        CLIENTS.put(nickname, session);
        
        sendToSession(session ,nickname," 님이 입장하셨습니다.");
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	String nickname = (String) session.getAttributes().get("loginedMemberNickname");
        CLIENTS.remove(nickname);
        
        sendToSession(session ,nickname," 님이 퇴장하셨습니다.");
    }
	
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	String nickname = (String) session.getAttributes().get("loginedMemberNickname");  //메시지를 보낸 아이디
    	String payload = message.getPayload();
    	
    	sendToSession(session ,nickname," : " + payload);
    	// 클라이언트로부터 메시지를 받아 처리하는 로직
    }
    
    private void sendToSession(WebSocketSession session, String nickname,String message) throws IOException {

    	CLIENTS.entrySet().forEach( arg->{
            try {
                arg.getValue().sendMessage(new TextMessage(nickname + message));
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
}