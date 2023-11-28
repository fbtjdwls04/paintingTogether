package com.koreaIT.paintingTogether.vo;

import java.io.IOException;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.koreaIT.paintingTogether.util.Util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	
	@Getter
	private int loginedMemberId;
	HttpServletResponse res;
	HttpSession session;
	HttpServletRequest req;
	
	public Rq(HttpServletRequest req, HttpServletResponse response) {
		this.res = response;
		this.req = req;
		this.session = req.getSession();
		
		int loginedMemberId = 0;
		
		if(session.getAttribute("loginedMemberId") != null) {
			loginedMemberId = (int)session.getAttribute("loginedMemberId");
		}
		
		this.loginedMemberId = loginedMemberId;
		
		this.req.setAttribute("rq", this);
	}

	public void jsPrintHistoryBack(String msg) {
		res.setContentType("text/html; charset=UTF-8;");
		
		try {
			res.getWriter().append(Util.jsHistoryBack(msg));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void login(int memberId) {
		this.session.setAttribute("loginedMemberId", memberId);
	}

	public void logout() {
		this.session.removeAttribute("loginedMemberId");
	}

	public String jsReturnOnView(String msg) {
		
		req.setAttribute("msg", msg);
		
		return "usr/common/js";
	}

	public void init() {
	}

}
