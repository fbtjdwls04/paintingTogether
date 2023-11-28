package com.koreaIT.paintingTogether.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.koreaIT.paintingTogether.vo.Member;

@Mapper
public interface MemberDao {
	
	@Insert("""
			INSERT INTO `member`
				SET regDate = NOW(),
				updateDate = NOW(),
				loginId = #{loginId},
				loginPw = #{loginPw},
				authLevel = 2,
				`name` = #{name},
				nickname = #{nickname},
				cellphoneNum = #{cellphoneNum},
				email = #{email}
			""")
	public void doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);
	
	@Select("""
			SELECT * 
				FROM `member`
				WHERE loginId = #{loginId}
			""")
	public Member getMemberByLoginId(String loginId);
	
	@Select("""
			SELECT * 
				FROM `member`
				WHERE loginId = #{loginId}
				AND loginPw = #{loginPw}
			""")
	public Member doLogin(String loginId, String loginPw);

	@Select("""
			SELECT * 
				FROM `member`
				WHERE id = #{loginedMemberId}
			""")
	public Member getMemberById(int loginedMemberId);
	
}