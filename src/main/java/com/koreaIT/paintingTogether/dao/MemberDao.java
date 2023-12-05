package com.koreaIT.paintingTogether.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.koreaIT.paintingTogether.vo.Member;

@Mapper
public interface MemberDao {
	
	@Insert("""
			INSERT INTO `member`
				SET regDate = NOW(),
				updateDate = NOW(),
				loginId = #{loginId},
				loginPw = SHA2(#{loginPw},256)
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
				AND loginPw = SHA2(#{loginPw}, 256)
			""")
	public Member doLogin(String loginId, String loginPw);

	@Select("""
			SELECT * 
				FROM `member`
				WHERE id = #{loginedMemberId}
			""")
	public Member getMemberById(int loginedMemberId);
	
	@Select("""
			SELECT * 
				FROM `member`
				WHERE name = #{name}
				AND email = #{email}
				AND cellphoneNum = #{cellphoneNum}
			""")
	public Member getMemberByNameAndEmailAndCell(String name, String email, String cellphoneNum);

	@Update("""
			UPDATE `member`
			SET loginPw = SHA2(#{tempPassword},256)
			WHERE id = #{id}
			""")
	public void doPasswordModify(int id, String tempPassword);
	
	@Update("""
			UPDATE `member`
			SET name = #{name},
			nickname = #{nickname},
			cellphoneNum = #{cellphoneNum},
			email = #{email}
			WHERE id = #{id}
			""")
	public void doModify(int id,String name, String nickname, String cellphoneNum, String email);
	
}