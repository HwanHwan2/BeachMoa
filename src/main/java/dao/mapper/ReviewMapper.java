package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Review;

public interface ReviewMapper {
	final String select = "SELECT * from review";

	@Select({ "<script>", select, "<if test = 'beachno != null'> where beachno = #{beachno}</if>",
			"<if test='limit != null'>" + "order by r_seq asc limit #{startrow}, #{limit}</if>", "</script>" })
	List<Review> select(Map<String, Object> param);

	@Select("select ifnull(max(r_seq),0) from review")
	int maxnum();

	@Insert("insert into review (r_seq, beachno ,id, nickname, subject, content, rating, recomcnt, regdate, fileurl)"
			+ " values (#{r_seq}, #{beachno} , #{id}, #{nickname}, #{subject}, #{content}, #{rating}, 0, now(), #{fileurl})")
	void insert(Review review);

	@Select("select count(*) from review where beachno = #{beachno}")
	int count(Map<String, Object> param);

	@Update("update review set recomcnt = recomcnt + 1 where r_seq = #{r_seq}")
	void update(Map<String, Object> param);

	@Delete("delete from review where r_seq = #{i};")
	void delete(int i);

	@Update("SET foreign_key_checks = 0;")
	void delfo(int i);

	@Update(" SET foreign_key_checks = 1;")
	void setfo(int i);

	@Select("select count(*) from review where id=#{value}")
	int selectcount(String id);

	@Select({ "<script>", "select r.*,(select beachNm from beachinfo where beachno=b.beachno) beachNm",
			" from review r, beachinfo b", " where r.beachno=b.beachno", "<if test = 'id != null'> and id = #{id}</if>",
			"<if test='limit != null'>" + "order by r_seq asc limit #{startrow}, #{limit}</if>", "</script>" })
	List<Review> selectlist(Map<String, Object> param);

	@Select("SELECT r.fileurl,r.beachno FROM review r ,beachinfo b WHERE b.beachno = r.beachno group BY b.beachno ORDER BY b.beachno")
	List<Review> selectbeachimglist();
}
