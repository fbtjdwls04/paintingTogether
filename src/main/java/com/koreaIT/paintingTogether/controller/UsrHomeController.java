package com.koreaIT.paintingTogether.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrHomeController {
	
	@RequestMapping("/usr/home/main")
	public String showMain() {
		return "usr/home/main";
	}
	
	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
	
	@RequestMapping("/usr/home/popUp")
	public String popUp() {
		return "/usr/home/popUp";
	}
	
	@RequestMapping("/usr/home/apiTest")
	public String apiTest() {
		return "/usr/home/apiTest";
	}
	
	@RequestMapping("/usr/home/apiTest2")
	public String apiTest2() {
		return "/usr/home/apiTest2";
	}
}
