package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ReportMapper;
import dto.Report;

@Repository
public class ReportDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param=  new HashMap<>();
	
	public int reportmaxnum() {
		return template.getMapper(ReportMapper.class).maxnum();
	}

	public void write(Report report) {
		template.getMapper(ReportMapper.class).write(report);
	}
	public void write2(Report report) {
		template.getMapper(ReportMapper.class).write2(report);
	}

	public int count(int b_seq) {
		return template.getMapper(ReportMapper.class).count(b_seq);
	}

	public void add(int reportcount) {
		template.getMapper(ReportMapper.class).add(reportcount);
	}

}
