package com.koreaIT.paintingTogether.service;

import org.springframework.stereotype.Service;

import com.koreaIT.paintingTogether.dao.BoardDao;
import com.koreaIT.paintingTogether.vo.Board;

@Service
public class BoardService {
	
	private BoardDao boardDao;
	
	public BoardService(BoardDao boardDao) {
		this.boardDao = boardDao;
	}
	
	public Board getBoardById(int boardId) {
		return boardDao.getBoardById(boardId);
	}
}
