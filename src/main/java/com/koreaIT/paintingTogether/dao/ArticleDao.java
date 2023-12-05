package com.koreaIT.paintingTogether.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.koreaIT.paintingTogether.vo.Article;

@Mapper
public interface ArticleDao {

	@Insert("""
			INSERT INTO article
				SET regDate = NOW()
					,updateDate = NOW()
					,memberId = #{memberId}
					,boardId = #{boardId}
					,title = #{title}
					,`body` = #{body}
			""")
	public void writeArticle(int memberId, int boardId, String title, String body);
	
	@Select("""
			<script>
			SELECT a.*
					, m.nickname AS writerName
					, IFNULL(SUM(r.point), 0) AS `point`
					,(SELECT COUNT(*) FROM reply WHERE relId = a.id) AS replyCnt
				FROM article AS a
			 	INNER JOIN member AS m
			 	ON a.memberId = m.id
			 	LEFT JOIN recommendPoint AS r
				ON r.relTypeCode = 'article'
				AND a.id = r.relId
				LEFT JOIN reply AS rp
				ON rp.relId = a.id
			 	WHERE a.boardId = #{boardId}
				 	<if test='searchType == "title"'>
				 		AND a.title LIKE CONCAT('%',#{searchMsg},'%')
				 	</if>
				 	<if test='searchType == "body"'>
				 		AND a.body LIKE CONCAT('%',#{searchMsg},'%')
				 	</if>
				 	<if test='searchType == "titleOrBody"'>
				 		AND (
					 		a.title LIKE CONCAT('%',#{searchMsg},'%')
					 		OR a.body LIKE CONCAT('%',#{searchMsg},'%')
				 		)
			 		</if>
			 		<if test='searchType == "writerName"'>
				 		AND m.nickname LIKE CONCAT('%',#{searchMsg},'%')
			 		</if>
				GROUP BY a.id
				ORDER BY a.id DESC
			 	LIMIT #{startLimit},#{itemsInAPage}
			</script>
			""")
	public List<Article> getArticles(int boardId, int startLimit, int itemsInAPage, String searchType, String searchMsg);
	
	@Select("""
			<script>
			SELECT COUNT(*)
				FROM article AS a
			 	INNER JOIN member AS m
			 	ON a.memberId = m.id
			 	WHERE a.boardId = #{boardId}
			 	<if test='searchType == "title"'>
			 		AND a.title LIKE CONCAT('%',#{searchMsg},'%')
			 	</if>
			 	<if test='searchType == "body"'>
			 		AND a.body LIKE CONCAT('%',#{searchMsg},'%')
			 	</if>
			 	<if test='searchType == "titleOrBody"'>
			 		AND (
				 		a.title LIKE CONCAT('%',#{searchMsg},'%')
				 		OR a.body LIKE CONCAT('%',#{searchMsg},'%')
			 		)
		 		</if>
			 	<if test='searchType == "writerName"'>
			 		AND m.nickname LIKE CONCAT('%',#{searchMsg},'%')
		 		</if>
			</script>
		""")
	public int getArticleCntById(int boardId, String searchType, String searchMsg);
	
	@Select("""
			SELECT *
				FROM article 
				WHERE id = #{id}
			""")
	public Article getArticleById(int id);
	
	@Select("""
			SELECT a.*
			        , m.nickname AS writerName
			        , IFNULL(SUM(r.point), 0) AS `point`
				FROM article AS a
				INNER JOIN MEMBER AS m
				ON a.memberId = m.id
				LEFT JOIN recommendPoint AS r
				ON r.relTypeCode = 'article'
				AND a.id = r.relId
				WHERE a.id = #{id} 
				GROUP BY a.id
			""")
	public Article forPrintArticle(int id);
	
	@Select("""
			DELETE FROM article 
				WHERE id = #{id}
			""")
	public void deleteArticle(int id);
	
	@Update("""
			<script>
				UPDATE article 
					SET updateDate = NOW() 
					<if test="title != null and title != ''">
						,title = #{title}
					</if>
					<if test="body != null and body != ''">
						,`body` = #{body}
					</if>
					WHERE id = #{id}
			</script>
			""")
	public void modifyArticle(int id, String title, String body);
	
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Select("""
				SELECT MAX(id)
				FROM article
			""")
	public int getLastArticleId();

	@Update("""
				UPDATE article 
					SET hitCount = hitCount + 1 
					WHERE id = #{id}
			""")
	public void increaseHitCount(int id);

	
	@Select("""
			SELECT hitCount
				FROM article
				WHERE id = #{id}
			""")
	public int getArticleHitCount(int id);

}
