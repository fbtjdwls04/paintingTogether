package com.koreaIT.paintingTogether.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int id;
	private int memberId;
	private String regDate;
	private String updateDate;
	private String body;
	private String relTypeCode;
	private int relId;
	
//	member inner join
	private String writerName;
}
