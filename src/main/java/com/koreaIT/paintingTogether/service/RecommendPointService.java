package com.koreaIT.paintingTogether.service;

import org.springframework.stereotype.Service;

import com.koreaIT.paintingTogether.dao.RecommendPointDao;
import com.koreaIT.paintingTogether.vo.RecommendPoint;
import com.koreaIT.paintingTogether.vo.ResultData;

@Service
public class RecommendPointService {

	private RecommendPointDao recommendPointDao;
	
	public RecommendPointService(RecommendPointDao recommendPointDao) {
		this.recommendPointDao = recommendPointDao;
	}

	public ResultData<RecommendPoint> getRecommendPoint(int loginedMemberId, String relTypeCode, int relId) {

		RecommendPoint recommendPoint = recommendPointDao.getRecommendPoint(loginedMemberId, relTypeCode, relId);

		if (recommendPoint == null) {
			return ResultData.from("F-1", "좋아요 기록 없음");
		}

		return ResultData.from("S-1", "좋아요 기록 있음", recommendPoint);
	}

	public void insertRecommendPoint(int loginedMemberId, String relTypeCode, int relId) {
		recommendPointDao.insertRecommendPoint(loginedMemberId, relTypeCode, relId);
	}

	public void deleteRecommendPoint(int loginedMemberId, String relTypeCode, int relId) {
		recommendPointDao.deleteRecommendPoint(loginedMemberId, relTypeCode, relId);
	}
}
