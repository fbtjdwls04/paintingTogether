package com.koreaIT.paintingTogether.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.koreaIT.paintingTogether.vo.Canvas;

@Mapper
public interface CanvasDao {

	
	@Update("""
				UPDATE canvas
				SET updateDate = NOW(),
				canvasUrl = #{canvasUrl}
				WHERE id = 1
			""")
	public void doSaveCanvas(String canvasUrl);
	
	@Select("""
			SELECT canvasUrl FROM canvas
			WHERE id = 1
		""")
	public String getCanvasUrl();
	
}
