package com.koreaIT.paintingTogether.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistration;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.koreaIT.paintingTogether.handler.WebSocketHandler;

@Configuration
@EnableWebSocket
public class MyWebSocketConfigurer implements WebSocketConfigurer {
	
	private WebSocketHandler webSocketHandler;
	
	public MyWebSocketConfigurer(WebSocketHandler webSocketHandler) {
		this.webSocketHandler = webSocketHandler;
	}
	
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    	WebSocketHandlerRegistration ws;
    	ws = registry.addHandler(webSocketHandler, "/chat");
    	ws.setAllowedOrigins("*");
    	ws.addInterceptors(new HttpSessionHandshakeInterceptor());
    }
}