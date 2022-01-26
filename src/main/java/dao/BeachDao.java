package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BeachMapper;
import dto.Beach;

@Repository
public class BeachDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	
//	public List<Beach> list() {
//		return template.getMapper(BeachMapper.class).select(null);
//	}

	public Beach selectOne(Integer beachno) {
		param.clear();
		param.put("beachno",beachno);
		return template.getMapper(BeachMapper.class).select(param).get(0);
	}

	public int count(String searchtype) {
		if(searchtype != null) {
			param.put("searchtype", searchtype);
		}
			return template.getMapper(BeachMapper.class).count(param);
	}

	public List<Beach> list(Integer pageNum, int limit, String searchtype) {
		param.clear();
		if(searchtype != null) {
			param.put("searchtype", searchtype);
		}
		param.put("startrow", (pageNum - 1) * limit);
		param.put("limit",  limit);		
		return template.getMapper(BeachMapper.class).select(param);
		
	}

	public List<Beach> recomendlist() {
		return template.getMapper(BeachMapper.class).reselect();
	}
}
