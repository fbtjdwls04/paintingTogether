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

	public void doUpdateCanvas(String canvasUrl) {
		canvasDao.doUpdateCanvas(canvasUrl);
	}

	public String getCanvasUrl() {
		return canvasDao.getCanvasUrl();
	}

	public void doSaveCanvas(String url) {
		canvasDao.doSaveCanvas(url);
	}
}
