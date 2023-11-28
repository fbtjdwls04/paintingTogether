package com.koreaIT.paintingTogether.service;

import org.springframework.stereotype.Service;

import com.koreaIT.paintingTogether.dao.MemberDao;
import com.koreaIT.paintingTogether.vo.Member;

@Service
public class MemberService {

	private MemberDao memberDao;
	
	public MemberService(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public void doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		memberDao.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public Member doLogin(String loginId, String loginPw) {
		return memberDao.doLogin(loginId, loginPw);
	}

	public Member getMemberById(int loginedMemberId) {
		return memberDao.getMemberById(loginedMemberId);
	}
}
