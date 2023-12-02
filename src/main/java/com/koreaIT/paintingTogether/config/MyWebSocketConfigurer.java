package com.koreaIT.paintingTogether.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistration;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.koreaIT.paintingTogether.handler.ChatWebSocketHandler;
import com.koreaIT.paintingTogether.handler.ConnectedUsersWebSocketHandler;
import com.koreaIT.paintingTogether.handler.PaintingWebSocketHandler;

@Configuration
@EnableWebSocket
public class MyWebSocketConfigurer implements WebSocketConfigurer {
	
	private ChatWebSocketHandler chatWebSocketHandler;
	private ConnectedUsersWebSocketHandler connectedUsersWebSocketHandler;
	private PaintingWebSocketHandler paintingWebSocketHandler;
	
	public MyWebSocketConfigurer(ChatWebSocketHandler chatWebSocketHandler, ConnectedUsersWebSocketHandler connectedUsersWebSocketHandler, PaintingWebSocketHandler paintingWebSocketHandler) {
		this.chatWebSocketHandler = chatWebSocketHandler;
		this.connectedUsersWebSocketHandler = connectedUsersWebSocketHandler;
		this.paintingWebSocketHandler = paintingWebSocketHandler;
	}
	
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    	WebSocketHandlerRegistration ws;
    	ws = registry.addHandler(chatWebSocketHandler, "/chat");
    	ws.addHandler(connectedUsersWebSocketHandler, "/connectedUsers");
    	ws.addHandler(paintingWebSocketHandler, "/painting");
    	ws.setAllowedOrigins("*");
    	ws.addInterceptors(new HttpSessionHandshakeInterceptor());
    }
}