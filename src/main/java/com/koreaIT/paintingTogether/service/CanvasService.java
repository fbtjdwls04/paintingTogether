package com.koreaIT.paintingTogether.service;

import org.springframework.stereotype.Service;

import com.koreaIT.paintingTogether.dao.CanvasDao;
import com.koreaIT.paintingTogether.vo.Canvas;

@Service
public class CanvasService {
	
	CanvasDao canvasDao;
	
	public CanvasService(CanvasDao canvasDao) {
		this.canvasDao = canvasDao;
	}

	public void doSaveCanvas(String canvasUrl) {
		canvasDao.doSaveCanvas(canvasUrl);
	}

	public String getCanvasUrl() {
		return canvasDao.getCanvasUrl();
	}
}
