package com.koreaIT.paintingTogether.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrHomeArticleContoroller {
	
	@RequestMapping("/usr/article/list")
	public String showMain() {
		return "usr/article/list";
	}
	
}
