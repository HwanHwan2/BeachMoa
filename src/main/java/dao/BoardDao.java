package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import dto.Board;

@Repository
public class BoardDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();

	public int count(int btype, String searchtype, String searchcontent) {
		if (searchtype != null && searchcontent != null) { // 검색 요청
			param.clear();
			param.put("searchtype", searchtype);
			param.put("searchcontent", searchcontent);
		}
		param.put("btype", btype);
		return template.getMapper(BoardMapper.class).count(param);
	}

	public List<Board> list(int btype, Integer pageNum, int limit, String searchtype, String searchcontent) {
		if (searchtype != null && searchcontent != null) { // 검색 조건 존재
			param.clear();
			param.put("searchtype", searchtype);
			param.put("searchcontent", searchcontent);
		}
		param.put("btype", btype);
		param.put("startrow", (pageNum - 1) * limit);
		param.put("limit", limit);
		return template.getMapper(BoardMapper.class).list(param);
	}

	public int maxnum() {
		return template.getMapper(BoardMapper.class).maxnum();
	}

	public void write(Board board) {
		template.getMapper(BoardMapper.class).insert(board);
	}

	public Board boarddetail(Integer seq) {
		param.clear();
		param.put("seq", seq);
		return template.getMapper(BoardMapper.class).select(param);
	}

	public void readcntadd(int readcnt, Integer seq) {
		param.clear();
		param.put("seq", seq);
		template.getMapper(BoardMapper.class).readcntadd(param);

	}

	public List<Board> list2(Integer btype, Integer seq) {
		param.clear();
		param.put("btype", btype);
		param.put("seq", seq);
		return template.getMapper(BoardMapper.class).list2(param);
	}

	public void update(Board board) {
		template.getMapper(BoardMapper.class).update(board);
	}

	public void delete(Board board) {
		template.getMapper(BoardMapper.class).delete(board);
	}

	public List<Board> list(int limit) {
		param.clear();
		param.put("limit", limit);
		return template.getMapper(BoardMapper.class).list3(param);
	}

	public int count() {
		return template.getMapper(BoardMapper.class).count2(param);
	}

	public int count2() {
		return template.getMapper(BoardMapper.class).count3(param);
	}

	public List<Board> list2(int limit) {
		param.clear();
		param.put("limit", limit);
		return template.getMapper(BoardMapper.class).list4(param);
	}

	public List<Board> getUserBoardList(Integer pageNum, int limit, String id) {
		param.clear();
		param.put("id", id);
		param.put("startrow", (pageNum - 1) * limit);
		param.put("limit", limit);
		return template.getMapper(BoardMapper.class).selectlist(param);
	}

	public int getUserBoardCount(String id) {
		return template.getMapper(BoardMapper.class).selectcount(id);
	}

	public void deleteMyBoard(String seq) {
		template.getMapper(BoardMapper.class).deleteboard(seq);
	}

}
