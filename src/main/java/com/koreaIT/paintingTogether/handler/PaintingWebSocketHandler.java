package com.koreaIT.paintingTogether.handler;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class PaintingWebSocketHandler extends TextWebSocketHandler{

	private static final ConcurrentHashMap<String, WebSocketSession> CLIENTS = new ConcurrentHashMap<String, WebSocketSession>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	String nickname = (String) session.getAttributes().get("loginedMemberNickname");
        CLIENTS.put(nickname, session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
    	String nickname = (String) session.getAttributes().get("loginedMemberNickname");
        CLIENTS.remove(nickname);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	String drawing = message.getPayload();
    	CLIENTS.entrySet().forEach( arg->{
            try {
                arg.getValue().sendMessage(new TextMessage(drawing));
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    	// 클라이언트로부터 메시지를 받아 처리하는 로직
    }
}