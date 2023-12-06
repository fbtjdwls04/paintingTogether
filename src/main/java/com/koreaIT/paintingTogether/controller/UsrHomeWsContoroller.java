package com.koreaIT.paintingTogether.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreaIT.paintingTogether.service.MemberService;
import com.koreaIT.paintingTogether.vo.ChatMessage;
import com.koreaIT.paintingTogether.vo.Member;
import com.koreaIT.paintingTogether.vo.Rq;

@Controller
public class UsrHomeWsContoroller {
	
	private Rq rq;
	private MemberService memberService;
	
	public UsrHomeWsContoroller(Rq rq, MemberService memberService) {
		this.rq = rq;
		this.memberService = memberService;
	}
	
	@RequestMapping("/usr/ws/paintingRoom")
	public String showMain(Model model) {
		
		Member loginedMember = memberService.getMemberById(rq.getLoginedMemberId());
		
		model.addAttribute("nickname",loginedMember.getNickname());
		
		return "/usr/ws/paintingRoom";
	}
	
	@MessageMapping("/chat")
    @SendTo("/ws/messages")
    public ChatMessage sendMessage(ChatMessage message) {
		
        return message;
    }
	
}
