package com.koreaIT.paintingTogether.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.paintingTogether.service.MemberService;
import com.koreaIT.paintingTogether.util.Util;
import com.koreaIT.paintingTogether.vo.Member;
import com.koreaIT.paintingTogether.vo.ResultData;
import com.koreaIT.paintingTogether.vo.Rq;

@Controller
public class UsrHomeMemberController {
	
	private MemberService memberService;
	private Rq rq;
	
	public UsrHomeMemberController(MemberService memberService,Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}
	@RequestMapping("/usr/member/join")
	public String join() {
		
		return "/usr/member/join";
	}
	
	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		
		if(Util.empty(loginId)) {
			return Util.jsHistoryBack("아이디를 입력해주세요");
		}
		
		if(Util.empty(loginPw)) {
			return Util.jsHistoryBack("비밀번호를 입력해주세요");
		}
		
		if(Util.empty(name)) {
			return Util.jsHistoryBack("이름을 입력해주세요");
		}
		
		if(Util.empty(nickname)) {
			return Util.jsHistoryBack("닉네임을 입력해주세요");
		}
		
		if(Util.empty(cellphoneNum)) {
			return Util.jsHistoryBack("전화번호를 입력해주세요");
		}
		
		if(Util.empty(email)) {
			return Util.jsHistoryBack("이메일을 입력해주세요");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member != null) {
			return Util.jsHistoryBack(Util.f("%s (은)는 이미 사용중인 아이디입니다", loginId));
		}
		
		memberService.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
		return Util.jsReplace("회원가입이 완료되었습니다", "/");
	}
	
	@RequestMapping("/usr/member/login")
	public String login() {
		
		return "/usr/member/login";
	}
	
	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {
		
		if(Util.empty(loginId)) {
			return Util.jsHistoryBack("아이디를 입력해주세요");
		}
		
		if(Util.empty(loginPw)) {
			return Util.jsHistoryBack("비밀번호를 입력해주세요");
		}
		
		Member member = memberService.doLogin(loginId, loginPw);
		
		if(member == null) {
			return Util.jsHistoryBack("아이디 또는 비밀번호를 확인해주세요");
		}

		rq.login(member.getId(), member.getNickname());
		
		return Util.jsReplace(Util.f("%s님 환영합니다", member.getNickname()), "/");
	}
	
	@RequestMapping("/usr/member/myPage")
	public String showMyPage( Model model, int id) {

		if (rq.getLoginedMemberId() != id) {
			return rq.jsReturnOnView("권한이 없습니다");
		}
		
		Member loginedMember = memberService.getMemberById(id);
		
		model.addAttribute("loginedMember", loginedMember);
		
		return "/usr/member/myPage";
	}
	
	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	public String doModify(int id, String name, String nickname, String cellphoneNum, String email) {
		
		if(rq.getLoginedMemberId() != id) {
			return Util.jsHistoryBack("권한이 없습니다");
		}
		if(Util.empty(name)) {
			return Util.jsHistoryBack("이름을 입력해주세요");
		}
		if(Util.empty(nickname)) {
			return Util.jsHistoryBack("닉네임을 입력해주세요");
		}
		if(Util.empty(cellphoneNum)) {
			return Util.jsHistoryBack("전화번호를 입력해주세요");
		}
		if(Util.empty(email)) {
			return Util.jsHistoryBack("이메일을 입력해주세요");
		}
		
		memberService.doModify(rq.getLoginedMemberId(),name, nickname, cellphoneNum, email);
		
		return Util.jsReplace("회원정보가 수정되었습니다", "/");
	}
	
	@RequestMapping("/usr/member/pwModify")
	public String pwModify(int id) {
		
		if(rq.getLoginedMemberId() != id) {
			return Util.jsHistoryBack("권한이 없습니다");
		}
		
		return "/usr/member/pwModify";
	}
	
	@RequestMapping("/usr/member/doPwModify")
	@ResponseBody
	public String doPwModify(String modifyPw, String modifyPwChk) {
		
		if(Util.empty(modifyPw)) {
			return Util.jsHistoryBack("새로운 비밀번호를 입력해주세요");
		}
		if(Util.empty(modifyPwChk)) {
			return Util.jsHistoryBack("비밀번호 확인을 입력해주세요");
		}
		
		if(modifyPw.equals(modifyPwChk) == false) {
			return Util.jsHistoryBack("새로운 비밀번호와 비밀번호 확인이 다릅니다");
		}
		
		memberService.doPasswordModify(rq.getLoginedMemberId(), modifyPw);
		
		return Util.jsReplace("비밀번호가 변경되었습니다","/");
	}
	
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout() {
		
		rq.logout();
		
		return Util.jsReplace("정상적으로 로그아웃 되었습니다","/");
	}
	
	// 계정 찾기
	@RequestMapping("/usr/member/findLoginId")
	public String findLoginId() {
		return "/usr/member/findLoginId";
	}
	
	@RequestMapping("/usr/member/findLoginPw")
	public String findLoginPw() {
		return "/usr/member/findLoginPw";
	}
	
	@RequestMapping("/usr/member/doFindLoginId")
	@ResponseBody
	public String doFindLoginId(String name, String email, String cellphoneNum) {
		
		if(Util.empty(name)) {
			return Util.jsHistoryBack("이름을 입력해주세요");
		}
		
		if(Util.empty(email)) {
			return Util.jsHistoryBack("이메일을 입력해주세요");
		}
		
		if(Util.empty(cellphoneNum)) {
			return Util.jsHistoryBack("전화번호를 입력해주세요");
		}
		
		Member member = memberService.getMemberByNameAndEmailAndCell(name, email, cellphoneNum);
		
		if(member == null) {
			return Util.jsHistoryBack("입력하신 정보와 일치하는 회원이 없습니다");
		}
		
		return Util.jsReplace(Util.f("회원님의 아이디는 [ %s ] 입니다", member.getLoginId()), "login");
	}
	
	@RequestMapping("/usr/member/doFindLoginPw")
	@ResponseBody
	public String doFindLoginPw(String loginId, String name, String email, String cellphoneNum) {
		
		if(Util.empty(loginId)) {
			return Util.jsHistoryBack("아이디를 입력해주세요");
		}
		
		if(Util.empty(name)) {
			return Util.jsHistoryBack("이름을 입력해주세요");
		}
		
		if(Util.empty(email)) {
			return Util.jsHistoryBack("이메일을 입력해주세요");
		}
		
		if(Util.empty(cellphoneNum)) {
			return Util.jsHistoryBack("전화번호를 입력해주세요");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);

		if(member == null) {
			return Util.jsHistoryBack("입력하신 정보와 일치하는 회원이 없습니다");
		}
		
		if(member.getName().equals(name) == false) {
			return Util.jsHistoryBack("이름이 일치하지 않습니다");
		}
		
		if(member.getEmail().equals(email) == false) {
			return Util.jsHistoryBack("이메일이 일치하지 않습니다");
		}
		
		if(member.getCellphoneNum().equals(cellphoneNum) == false) {
			return Util.jsHistoryBack("전화번호가 일치하지 않습니다");
		}
		
		ResultData notifyTempLoginPwByEmailRd = memberService.notifyTempLoginPwByEmail(member);

		return Util.jsReplace(notifyTempLoginPwByEmailRd.getMsg(), "login");
	}

	@RequestMapping("/usr/member/loginIdDupChk")
	@ResponseBody
	public ResultData<String> loginIdDupChk(String loginId) {
		
		if(Util.empty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member != null) {
			return ResultData.from("F-2",Util.f("%s 은(는) 이미 사용중인 아이디입니다", loginId)); 
		}
		
		return ResultData.from("S-1", "사용 가능한 아이디입니다",loginId);
	}
	
}