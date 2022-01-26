package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.RecommendMapper;
import dao.mapper.ReviewMapper;
import dto.Recommend;
import dto.Review;

@Repository
public class RecommendDao {
	@Autowired
	private SqlSessionTemplate template;
	// Item 클래스의 프로퍼티와 db의 컬럼명을 매핑.
	private Map<String, Object> param = new HashMap<String, Object>();


	public Recommend recommendcnt(int r_seq) {
		return template.getMapper(RecommendMapper.class).select(r_seq);
	}

	public int count(int r_seq) {
		param.clear();
		param.put("r_seq",  r_seq);
		return template.getMapper(RecommendMapper.class).count(param);
	}

	public void recre(int r_seq, String id) {
		param.clear();
		param.put("r_seq", r_seq);
		param.put("id",  id);
		template.getMapper(RecommendMapper.class).insert(param);
	}
}
