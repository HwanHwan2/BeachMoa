package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import dto.Alarm;

public interface AlarmMapper {

	@Select({"<script>",
			 "select ifnull(max(a_no),0) from alarm",
			 "</script>"
	})
	int AlarmMaxnum();

	@Insert({"<script>",
			 "insert into alarm ",
			 "values (#{a_no}, #{a_sent_id}, #{a_recv_id}, #{a_title}, #{a_content}, #{a_href}, #{a_read}, #{a_date})",
			 "</script>"
	})
	void saveAlarm(Alarm alarm);

	@Select({"<script>",
			 "select COUNT(*) from alarm ",
			 "where a_recv_id = #{a_recv_id}",
			 "</script>"
	})
	int AlarmCnt(String a_recv_id);
	
	//==========================================알람 디테일(레이아웃)====================================================
	@Select({"<script>",
			 "select * from alarm ",
			 "where a_recv_id = #{a_recv_id} ",
			 "order by a_date desc",
			 "</script>"
	})
	List<Alarm> AlarmDetail(String a_recv_id);

	@Delete({"<script>",
			 "delete from alarm ",
			 "where a_no = #{a_no}",
			 "</script>"
	})
	void AlarmDelete(int a_no);
}
