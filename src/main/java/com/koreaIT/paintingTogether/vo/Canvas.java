package com.koreaIT.paintingTogether.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Canvas {
	private int id;
	private String regDate;
	private String updateDate;
	private String canvasUrl;
	
}
