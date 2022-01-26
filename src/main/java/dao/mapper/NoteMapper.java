package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Note;

public interface NoteMapper {
	//==============================쪽지 리스트================================
	@Select({"<script>",
			 "select * from notice where n_recv_id = #{id}",
			 "</script>"
	})
	List<Note> list(Map<String, Object> param);

	//=============================쪽지 상세정보===============================
	@Select({"<script>",
			 "select * from notice where n_id = #{n_id}",
			 "</script>"
	})
	Note detail(Map<String, Object> param);

	//==============================쪽지 maxnum=============================
	@Select({"<script>",
			 "select ifnull(max(n_no),0) from notice",
			 "</script>"
	})
	int notemaxnum();

	//=============================쪽지 작성=================================
	@Insert({"<script>",
			 "insert into notice ",	
			 "values (#{n_no},#{n_sent_id},#{n_recv_id},#{title},#{note},DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%s'))",
			 "</script>"
	})
	void sendNote(Note note);
	//=============================쪽지 카운트=================================
	@Select({"<script>",
			 "select count(*) from notice ",
			 "where n_recv_id = #{id}",
			 "</script>"
	})
	int notecount(String id);

	//=============================쪽지 삭제======================================
	@Delete({"<script>",
			 "delete from notice ",
			 "where n_no = #{n_no}",
			 "</script>"
	})
	void deleteNote(Integer i);
}
