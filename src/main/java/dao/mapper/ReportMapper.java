package dao.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Report;

public interface ReportMapper {

	@Select("select ifnull(max(r_seq),0) from report")
	int maxnum();

	@Insert("insert into report (r_seq, b_seq, id, reportsubject, reportcontent,r_regdate)"
			+ " values (#{r_seq},#{b_seq}, #{id},#{reportsubject},#{reportcontent},now())")
	void write(Report report);
	
	@Insert("insert into report (r_seq, b_seq, c_seq, id, reportsubject, reportcontent,r_regdate)"
			+ " values (#{r_seq},#{b_seq}, #{c_seq},#{id},#{reportsubject},#{reportcontent},now())")
	void write2(Report report);

	@Select("select count(b_seq) from report where b_seq = #{b_seq}")
	int count(int b_seq);

	@Update("update board set reportcnt=reportcnt+1 where seq = #{b_seq}")
	void add(int reportcount);

}
