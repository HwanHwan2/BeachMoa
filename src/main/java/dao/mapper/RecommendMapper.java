package dao.mapper;


import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Recommend;
import dto.Review;

public interface RecommendMapper {
	@Insert("insert into recommend (r_seq, id)"
			+ "values (#{r_seq}, #{id})")
	void insert(Map<String, Object> param);
	@Select("select count(*) from recommend where r_seq = #{r_seq}")
	int count(Map<String, Object> param);
	
	@Select("select * from recommend where r_seq = #{r_seq}")
	Recommend select(int r_seq);

	

}
