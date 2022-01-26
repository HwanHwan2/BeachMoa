package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CommentMapper;
import dto.Comment;

@Repository
public class CommentDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();

	public int maxnum() {
		return template.getMapper(CommentMapper.class).maxnum();
	}

	public void write(Comment comment) {
		template.getMapper(CommentMapper.class).write(comment);
	}

	public List<Comment> list(int b_seq) {
		param.clear();
		param.put("b_seq", b_seq);
		return template.getMapper(CommentMapper.class).list(b_seq);
	}

	public int count(int b_seq) {
		param.clear();
		param.put("b_seq", b_seq);
		return template.getMapper(CommentMapper.class).count(b_seq);
	}

	public void update(Comment comment) {
		template.getMapper(CommentMapper.class).update(comment);
	}

	public void delete(int c_seq) {
		template.getMapper(CommentMapper.class).delete(c_seq);
	}

	public int selectcount(String id) {
		return template.getMapper(CommentMapper.class).selectcount(id);
	}

	public List<Comment> selectlist(Integer pageNum, int limit, String id) {
		param.clear();
		param.put("id", id);
		param.put("startrow", (pageNum - 1) * limit);
		param.put("limit", limit);
		return template.getMapper(CommentMapper.class).selectlist(param);
	}

}
