package com.koreaIT.paintingTogether.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Brush {
	private int x;
	private int y;
	private int lineWidth;
	private String fillStyle;
}
