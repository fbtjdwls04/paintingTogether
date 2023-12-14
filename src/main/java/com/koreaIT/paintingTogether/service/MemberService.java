package com.koreaIT.paintingTogether.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.koreaIT.paintingTogether.dao.MemberDao;
import com.koreaIT.paintingTogether.util.Util;
import com.koreaIT.paintingTogether.vo.Member;
import com.koreaIT.paintingTogether.vo.ResultData;

@Service
public class MemberService {

	private MemberDao memberDao;
	private EmailService emailService;
	@Value("${custom.siteName}")
	private String siteName;
	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	
	public MemberService(MemberDao memberDao, EmailService emailService) {
		this.memberDao = memberDao;
		this.emailService = emailService;
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

	public Member getMemberByNameAndEmailAndCell(String name, String email, String cellphoneNum) {
		return memberDao.getMemberByNameAndEmailAndCell(name, email, cellphoneNum);
	}

	public ResultData notifyTempLoginPwByEmail(Member member) {
		String subject = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Util.createTempPassword();
		String text = "<h1>임시 패스워드 : " + tempPassword + "</h1><br>";
		text += "<a style='display:inline-block;padding:10px;border-radius:10px;border:5px solid black;font-size:4rem;color:inherit;text-decoration:none;' href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		ResultData sendRd = emailService.send(member.getEmail(), subject, text);

		if (sendRd.isFail()) {
			return sendRd;
		}

		setTempPassword(member, tempPassword);

		return ResultData.from("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다");
	}
	private void setTempPassword(Member member, String tempPassword) {
		memberDao.doPasswordModify(member.getId(), tempPassword);
	}

	public void doModify(int id,String name, String nickname, String cellphoneNum, String email) {
		memberDao.doModify(id,name, nickname, cellphoneNum, email);
	}

	public void doPasswordModify(int id, String tempPassword) {
		memberDao.doPasswordModify(id, tempPassword);
	}

	public int getMemberCnt(String searchType, String searchMsg) {
		return memberDao.getMemberCnt(searchType, searchMsg);
	}

	public List<Member> getMembers(int startLimit, int itemsInAPage, String searchType, String searchMsg) {
		return memberDao.getMembers(startLimit,itemsInAPage,searchType,searchMsg);
	}

	public void deleteMembers(List<String> ids) {
		for (String idStr : ids) {
			Member member = getMemberById(Integer.parseInt(idStr));

			if (member != null) {
				deleteMember(member.getId());
			}
		}
	}

	private void deleteMember(int id) {
		memberDao.deleteMember(id);
	}
}
