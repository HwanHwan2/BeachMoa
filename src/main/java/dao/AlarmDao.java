package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.AlarmMapper;
import dto.Alarm;

@Repository("Alarm")
public class AlarmDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param=  new HashMap<>();
	
	public int alarmMaxnum() {
		return template.getMapper(AlarmMapper.class).AlarmMaxnum();
	}

	public void saveAlarm(Alarm alarm) {
		template.getMapper(AlarmMapper.class).saveAlarm(alarm);
	}

	public int AlarmCnt(String a_recv_id) {
		return template.getMapper(AlarmMapper.class).AlarmCnt(a_recv_id);
	}

	public List<Alarm> AlarmDetail(String a_recv_id) {
		return template.getMapper(AlarmMapper.class).AlarmDetail(a_recv_id);
	}

	//=============알람 삭제 ==================
	public void AlarmDelete(int a_no) {
		template.getMapper(AlarmMapper.class).AlarmDelete(a_no);
	}
}
