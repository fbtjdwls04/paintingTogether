package com.koreaIT.paintingTogether.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreaIT.paintingTogether.service.ReplyService;
import com.koreaIT.paintingTogether.util.Util;
import com.koreaIT.paintingTogether.vo.Reply;
import com.koreaIT.paintingTogether.vo.Rq;

@Controller
public class UsrHomeReplyController {

	private ReplyService replyService;
	private Rq rq;

	public UsrHomeReplyController(ReplyService replyService, Rq rq) {
		this.replyService = replyService;
		this.rq = rq;
	}

	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(int relId, String relTypeCode, String body) {
		
		if(body == null) {
			Util.jsReplace("내용을 입력해주세요", Util.f("/usr/article/detail?id=%d", relId));
		}
		
		body = Util.cleanText(body);
		
		replyService.doWrite(relId, relTypeCode,rq.getLoginedMemberId() ,body);
		
		return Util.jsReplace("댓글이 작성되었습니다", Util.f("/usr/article/detail?id=%d", relId));
	}
	
	@RequestMapping("/usr/reply/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		Reply reply =  replyService.getReplyById(id);

		if (reply == null) {
			return Util.jsHistoryBack("해당 댓글은 존재하지 않습니다");
		}

		if (rq.getLoginedMemberId() != reply.getMemberId()) {
			return Util.jsHistoryBack("권한이 없습니다.");
		}
		
		replyService.deleteReply(id);
		
		return Util.jsReplace("댓글을 삭제하였습니다", Util.f("/usr/article/detail?id=%d", reply.getRelId()));
	}
	
	@RequestMapping("/usr/reply/doModify")
	@ResponseBody
	public String doModify(int id, String body) {
		
		if(body == null) {
			Util.jsReplace("내용을 입력해주세요", Util.f("/usr/article/detail?id=%d", id));
		}
		
		body = Util.cleanText(body);

		Reply reply =  replyService.getReplyById(id);

		if (reply == null) {
			return Util.jsHistoryBack("해당 댓글은 존재하지 않습니다");
		}

		if (rq.getLoginedMemberId() != reply.getMemberId()) {
			return Util.jsHistoryBack("권한이 없습니다.");
		}
		
		replyService.modifyReply(id, body);
		
		return Util.jsReplace("댓글을 수정하였습니다", Util.f("/usr/article/detail?id=%d", reply.getRelId()));
	}
}