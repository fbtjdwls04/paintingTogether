package com.koreaIT.paintingTogether.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecommendPoint {
	private int id;
	private int memberId;
	private int relId;
	private String relTypeCode;
	private int point;
}
