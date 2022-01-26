package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.MapMapper;
import dto.Mapping;

@Repository("Mapping")
public class MapDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param=  new HashMap<>();
	
	public List<Mapping> list() {
		return template.getMapper(MapMapper.class).select(null);
	}

	public Mapping info(int beachno) {
		param.clear();
		param.put("beachno", beachno);
		return template.getMapper(MapMapper.class).info(param);
	}
}
