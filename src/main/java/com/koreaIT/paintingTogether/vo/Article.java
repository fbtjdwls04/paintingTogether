package com.koreaIT.paintingTogether.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private int memberId;
	private int boardId;
	private String regDate;
	private String updateDate;
	private String title;
	private String body;
	private String hitCount;
	
//	member join
	private String writerName;
	
//	recommendPoint join
	private int point;
	
	private int replyCnt; 
}
