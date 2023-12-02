package com.koreaIT.paintingTogether.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.koreaIT.paintingTogether.dao.ReplyDao;
import com.koreaIT.paintingTogether.vo.Reply;

@Service
public class ReplyService {

	private ReplyDao replyDao;
	
	public ReplyService(ReplyDao replyDao) {
		this.replyDao = replyDao;
	}

	public void doWrite(int relId, String relTypeCode,int memberId, String body) {
		replyDao.doWrite(relId, relTypeCode,memberId, body);
	}

	public List<Reply> getReplies(int id, String relTypeCode) {
		return replyDao.getReplies(id, relTypeCode);
	}

	public Reply getReplyById(int id) {
		return replyDao.getReplyById(id);
	}

	public void deleteReply(int id) {
		replyDao.deleteReply(id);
	}

	public void modifyReply(int id, String body) {
		replyDao.modifyReply(id, body);
	}
}
