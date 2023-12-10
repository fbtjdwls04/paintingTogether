package com.koreaIT.paintingTogether.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.paintingTogether.service.CanvasService;
import com.koreaIT.paintingTogether.service.MemberService;
import com.koreaIT.paintingTogether.util.Util;
import com.koreaIT.paintingTogether.vo.ChatMessage;
import com.koreaIT.paintingTogether.vo.Member;
import com.koreaIT.paintingTogether.vo.Rq;

@Controller
public class UsrHomeWsContoroller {
	
	private Rq rq;
	private MemberService memberService;
	private CanvasService canvasService;
	
	public UsrHomeWsContoroller(Rq rq, MemberService memberService,CanvasService canvasService) {
		this.rq = rq;
		this.memberService = memberService;
		this.canvasService = canvasService;
	}
	
	@RequestMapping("/usr/ws/paintingRoom")
	public String showMain(Model model) {
		
		Member loginedMember = memberService.getMemberById(rq.getLoginedMemberId());
		
		model.addAttribute("nickname",loginedMember.getNickname());
		model.addAttribute("saveCanvasUrl",canvasService.getCanvasUrl());
		
		System.out.println(canvasService.getCanvasUrl());
		return "/usr/ws/paintingRoom";
	}
	
	@MessageMapping("/chat")
    @SendTo("/ws/chat")
    public ChatMessage sendMessage(ChatMessage message) {
		message.setSender(Util.cleanText(message.getSender()));
		message.setContent(Util.cleanText(message.getContent()));
        return message;
    }
	
	@MessageMapping("/canvas")
	@SendTo("/ws/canvas")
	public String sendCanvas(String url) {
		
		canvasService.doSaveCanvas(url);
		
		return url;
	}
}
