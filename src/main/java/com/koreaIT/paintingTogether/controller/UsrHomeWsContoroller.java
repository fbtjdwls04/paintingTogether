package com.koreaIT.paintingTogether.controller;

import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String showMain(Model model, String roomId, @RequestParam(defaultValue = "") String roomPw) {
		Member loginedMember = memberService.getMemberById(rq.getLoginedMemberId());
		
		if(Util.empty(roomId)) {
			return rq.jsReturnOnView("방 제목을 입력해주세요");
		}
		
		model.addAttribute("roomId",roomId);
		model.addAttribute("roomPw",roomPw);
		model.addAttribute("nickname",loginedMember.getNickname());
		model.addAttribute("saveCanvasUrl",canvasService.getCanvasUrl());
		
		return "/usr/ws/paintingRoom";
	}
	
	@MessageMapping("/chat/{roomId}")
    @SendTo("/ws/chat/{roomId}")
    public ChatMessage sendMessage(ChatMessage message) {
		message.setSender(Util.cleanText(message.getSender()));
		message.setContent(Util.cleanText(message.getContent()));
		
		return message;
    }
	
	@MessageMapping("/canvas/{roomId}")
	@SendTo("/ws/canvas/{roomId}")
	public String sendCanvas(String url) {
		
		if(canvasService.getCanvasUrl() == null) {
			canvasService.doSaveCanvas(url);
		}
		else {
			canvasService.doUpdateCanvas(url);
		}
		return url;
	}
}
