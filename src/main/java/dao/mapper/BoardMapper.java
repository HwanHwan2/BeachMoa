package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Board;

public interface BoardMapper {

	@Select({ "<script>", "select count(*) from board where btype=${btype}",
			"<if test='searchtype != null and searchcontent != null'> and ${searchtype} like '%${searchcontent}%' </if>",
			"</script>" })
	int count(Map<String, Object> param);

	@Select({ "<script>", "select seq, id, nickname, password, subject, content, regdate, readcnt from board",
			"where btype=${btype}",
			"<if test='searchtype != null and searchcontent != null'> and ${searchtype} like '%${searchcontent}%'</if>",
			"<if test='limit != null'>" + "order by seq desc limit #{startrow}, #{limit} </if>", "</script>" })
	List<Board> list(Map<String, Object> param);

	@Select("select ifnull(max(seq),0) from board")
	int maxnum();

	@Insert("insert into board (seq,nickname,id,password,subject,content,btype,readcnt,reportcnt,regdate)"
			+ " values (#{seq},(select nickname from member where id=#{id}),#{id},#{password},#{subject},#{content},#{btype},0,0,now())")
	void insert(Board board);

	@Select("select seq,id,nickname,password,subject,content,btype,readcnt,reportcnt,regdate from board where seq=#{seq}")
	Board select(Map<String, Object> param);

	@Update("update board set readcnt=readcnt+1 where seq=#{seq}")
	void readcntadd(Map<String, Object> param);

	@Select("select seq,subject,id,regdate from board where btype=#{btype} order by seq desc")
	List<Board> list2(Map<String, Object> param);

	@Update("update board set subject=#{subject}, content=#{content}, btype=#{btype} where seq=#{seq}")
	void update(Board board);

	@Delete("delete from board where seq=#{seq}")
	void delete(Board board);

	@Select("select seq,subject,id,regdate from board where btype=0 order by seq desc limit 0, #{limit}")
	List<Board> list3(Map<String, Object> param);

	@Select("select count(*) from board where btype=0")
	int count2(Map<String, Object> param);

	@Select("select count(*) from board where btype=1")
	int count3(Map<String, Object> param);

	@Select("select seq,subject,id,regdate from board where btype=1 order by seq desc limit 0, #{limit}")
	List<Board> list4(Map<String, Object> param);

	@Select({ "<script>", "select * from board", "where id=#{id}",
			"<if test='limit != null'>" + "order by seq desc limit #{startrow}, #{limit} </if>", "</script>" })
	List<Board> selectlist(Map<String, Object> param);

	@Select("select count(*) from board where id=#{value}")
	int selectcount(String id);

	@Delete("delete from board where seq=#{value}")
	void deleteboard(String seq);
}
