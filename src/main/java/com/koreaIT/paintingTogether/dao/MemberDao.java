package com.koreaIT.paintingTogether.dao;

import java.util.List;

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

	@Select("""
			<script>
			SELECT COUNT(*) 
				FROM `member`
				WHERE authLevel = 2
					<if test='searchType == "loginId"'>
				 		AND loginId LIKE CONCAT('%',#{searchMsg},'%')
				 	</if>
				 	<if test='searchType == "name"'>
				 		AND name LIKE CONCAT('%',#{searchMsg},'%')
				 	</if>
				 	<if test='searchType == "nickname"'>
				 		AND nickname LIKE CONCAT('%',#{searchMsg},'%')
			 		</if>
			</script>
			""")
	public int getMemberCnt(String searchType, String searchMsg);
	
	@Select("""
			<script>
			SELECT *
				FROM `member`
			 	WHERE authLevel = 2
					<if test='searchType == "loginId"'>
				 		AND loginId LIKE CONCAT('%',#{searchMsg},'%')
				 	</if>
				 	<if test='searchType == "name"'>
				 		AND name LIKE CONCAT('%',#{searchMsg},'%')
				 	</if>
				 	<if test='searchType == "nickname"'>
				 		AND nickname LIKE CONCAT('%',#{searchMsg},'%')
			 		</if>
				ORDER BY id DESC
			 	LIMIT #{startLimit},#{itemsInAPage}
			</script>
			""")
	public List<Member> getMembers(int startLimit, int itemsInAPage, String searchType, String searchMsg);
	
	@Update("""
			<script>
			UPDATE `member`
				<set>
					updateDate = NOW(),
					delStatus = 1,
					delDate = NOW()
				</set>
				WHERE id = #{id}
			</script>
			""")
	public void deleteMember(int id);
}