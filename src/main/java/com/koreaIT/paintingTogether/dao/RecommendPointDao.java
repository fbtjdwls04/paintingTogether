package com.koreaIT.paintingTogether.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.koreaIT.paintingTogether.vo.RecommendPoint;

@Mapper
public interface RecommendPointDao {

	@Select("""
			SELECT *
				FROM recommendPoint
				WHERE memberId = #{loginedMemberId}
				AND relTypeCode = #{relTypeCode}
				AND relId = #{relId}
			""")
	RecommendPoint getRecommendPoint(int loginedMemberId, String relTypeCode, int relId);

	@Insert("""
			INSERT INTO recommendPoint
				SET memberId = #{loginedMemberId}
					, relTypeCode = #{relTypeCode}
					, relId = #{relId}
					, `point` = 1;
			""")
	void insertRecommendPoint(int loginedMemberId, String relTypeCode, int relId);

	@Delete("""
			DELETE FROM recommendPoint
				WHERE memberId = #{loginedMemberId}
				AND relTypeCode = #{relTypeCode}
				AND relId = #{relId}
			""")
	void deleteRecommendPoint(int loginedMemberId, String relTypeCode, int relId);
}
