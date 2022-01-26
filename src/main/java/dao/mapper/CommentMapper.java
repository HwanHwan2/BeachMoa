package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Comment;

public interface CommentMapper {

	@Select("select ifnull(max(c_seq),0) from comment")
	int maxnum();

	@Insert("insert into comment (c_seq, b_seq, id, nickname,c_content, c_regdate, c_grp)"
			+ " values (#{c_seq}, #{b_seq}, #{id}, (select nickname from member where id=#{id}), #{c_content}, now(), #{c_grp})")
	void write(Comment comment);

	@Select("select * from comment where b_seq=#{b_seq} order by c_seq")
	List<Comment> list(int b_seq);

	@Select("select count(*) from comment where b_seq=#{b_seq}")
	int count(int b_seq);

	@Update("update comment set c_content=#{c_content} where c_seq=#{c_seq}")
	void update(Comment comment);

	@Delete("delete from comment where c_seq=#{c_seq}")
	void delete(int c_seq);

	@Select("select count(*) from comment where id=#{id}")
	int selectcount(String id);

	@Select({ "<script>", "select c.*,(select btype from board where seq=b.seq) btype ", " from comment c,board b",
			" where b.seq=c.b_seq and c.id=#{id} ", "<if test='limit != null'>",
			"order by c_seq desc limit #{startrow}, #{limit} </if>", "</script>" })
	List<Comment> selectlist(Map<String, Object> param);
}
