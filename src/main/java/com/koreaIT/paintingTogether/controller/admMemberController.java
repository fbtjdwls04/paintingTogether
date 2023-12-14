package com.koreaIT.paintingTogether.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.paintingTogether.service.MemberService;
import com.koreaIT.paintingTogether.util.Util;
import com.koreaIT.paintingTogether.vo.Member;
import com.koreaIT.paintingTogether.vo.Rq;

@Controller
public class admMemberController {

	private MemberService memberService; 
	private Rq rq;

	public admMemberController(MemberService memberService, Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}

	@RequestMapping("/adm/member/list")
	public String showList(Model model, 
			@RequestParam(defaultValue = "1") int boardPage, 
			String searchType,
			String searchMsg) {
		
		if (rq.getLoginedMemberId() != 1) {
			return Util.jsHistoryBack("권한이 없습니다");
		}
		
		if (boardPage < 1) {
			return Util.jsHistoryBack("잘못된 접근입니다");
		}

		if (searchMsg != null) {
			searchMsg = Util.cleanText(searchMsg);
		}
		
		int itemsInAPage = 10;
		int pageSize = 10;
		int startLimit = (boardPage-1)*itemsInAPage;
		int memberCnt = memberService.getMemberCnt(searchType, searchMsg);
		int totalPage = (int) Math.ceil((double) memberCnt / itemsInAPage);
		int beginPage = Util.getBeginPage(boardPage, pageSize);
		int endPage = Util.getEndPage(boardPage, pageSize);


		List<Member> members = memberService.getMembers(startLimit,itemsInAPage, searchType, searchMsg);

		model.addAttribute("members", members);
		model.addAttribute("memberCnt", memberCnt);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("boardPage", boardPage);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("beginPage", beginPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchMsg", searchMsg);

		return "/adm/member/list";
	}
	@RequestMapping("/adm/member/doDeleteMembers")
	@ResponseBody
	public String doDeleteMembers(@RequestParam(name = "ids", required = false) List<String> ids) {

		if (ids == null) {
			return Util.jsHistoryBack("선택한 회원이 없습니다");
		}

		for (String idStr : ids) {
			if (idStr.equals("1")) {
				return Util.jsHistoryBack("관리자 계정은 삭제할 수 없습니다");
			}
		}

		memberService.deleteMembers(ids);

		return Util.jsReplace("선택한 회원이 삭제되었습니다", "list");
	}
}