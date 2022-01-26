package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BeachMapper;
import dao.mapper.ReviewMapper;
import dto.Review;

@Repository
public class ReviewDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();

//	public List<Review> myreviewlist(String id) {
//	return template.getMapper(ReviewMapper.class).select(id);
//}

public int reviewmaxnum() {
	return template.getMapper(ReviewMapper.class).maxnum();
}

public void write(Review review) {
	template.getMapper(ReviewMapper.class).insert(review);
	
}


public int count(int beachno) {
	param.clear();
	param.put("beachno",  beachno);
	return template.getMapper(ReviewMapper.class).count(param);
}

public List<Review> list(Integer pageNum, int limit) {
	param.clear();
	param.put("startrow", (pageNum - 1) * limit);
	param.put("limit",  limit);		
	return template.getMapper(ReviewMapper.class).select(param);
}

public List<Review> list(int beachno, Integer pageNum, int limit) {
	param.clear();
	param.put("startrow", (pageNum - 1) * limit);
	param.put("limit",  limit);		
	param.put("beachno",  beachno);		
	return template.getMapper(ReviewMapper.class).select(param);
}

public void plusreccnt(int r_seq) {
	param.clear();
	param.put("r_seq", r_seq);
	template.getMapper(ReviewMapper.class).update(param);
}



public void delete(int i) {
	template.getMapper(ReviewMapper.class).delfo(i);
	template.getMapper(ReviewMapper.class).delete(i);
	template.getMapper(ReviewMapper.class).setfo(i);
}

public void insert(@Valid Review review) {
	param.clear();
	int seq = template.getMapper(ReviewMapper.class).maxnum();
	review.setR_seq(++seq);
	template.getMapper(ReviewMapper.class).insert(review);
}

	public int reviewCount(String id) {
		return template.getMapper(ReviewMapper.class).selectcount(id);
	}

	public List<Review> myReviewList(Integer pageNum, int limit, String id) {
		param.clear();
		param.put("startrow", (pageNum - 1) * limit);
		param.put("limit", limit);
		param.put("id", id);
		return template.getMapper(ReviewMapper.class).selectlist(param);
	}

	public List<Review> beachimgList() {
		return template.getMapper(ReviewMapper.class).selectbeachimglist();
	}

}
