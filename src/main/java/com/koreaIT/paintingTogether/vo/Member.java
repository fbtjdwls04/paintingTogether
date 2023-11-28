package com.koreaIT.paintingTogether.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private String authLevel;
	private String name;
	private String nickname;
	private String cellphoneNum;
	private String email;
	private String delStatus;
	private String delDate;
}
