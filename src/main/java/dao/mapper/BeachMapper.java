package dao.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Beach;
//GROUP BY b.beachno
public interface BeachMapper {
final String select = "SELECT b.* , r.* , ROUND(avg(r.rating),1)'avgrating' from beachinfo b LEFT OUTER JOIN review r ON b.beachno = r.beachno";
	@Select({"<script>",select,
		"<if test='searchtype != null'>"
				+ " where b.sidoNm = '${searchtype}'</if>", 
		"<if test = 'beachno != null'> where b.beachno = #{beachno}</if>",
		"<if test='limit != null'>"
		+ "GROUP BY b.beachno order by b.beachno asc limit #{startrow}, #{limit}</if>",
		"</script>"})
	List<Beach> select(Map<String,Object> param);
		
	@Select({"<script>",
		"select count(*) from beachinfo",
		"<if test='searchtype != null'>"
		+ " where sidoNm = '${searchtype}'</if>", 
		"</script>"})
	int count(Map<String, Object> param);
	
	@Select("SELECT b.* , r.* , ROUND(avg(r.rating),1)'avgrating', (ROUND(avg(r.rating),1) * COUNT(r.r_seq))'reavgrating' from "
			+ "beachinfo b LEFT OUTER JOIN review r ON b.beachno = r.beachno GROUP BY b.beachno order by reavgrating DESC LIMIT 10")
	List<Beach> reselect();
	
}
