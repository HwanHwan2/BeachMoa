package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import dto.Mapping;

public interface MapMapper {
	//======================해수욕장 좌표값 가져오기============================
	@Select({"<script>",
			 "select beachNm, corX, corY, intro from beachinfo",
			 "</script>"
	})
	List<Mapping> select(Map<String, Object> param);

	//======================해수욕장 상세정보 가져오기==========================
	@Select({"<script>",
			 "select * from beachinfo ",
			 "where beachno = #{beachno}",
			 "</script>"
	})
	Mapping info(Map<String, Object> param);
	
	
}
