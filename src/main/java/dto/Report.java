package dto;

import javax.validation.constraints.NotEmpty;

public class Report {
	private int r_seq;
	private int b_seq;
	private int c_seq;
	private String id;
	@NotEmpty(message="신고 내용을 입력해주세요")
	private String reportcontent;
	@NotEmpty(message="신고 제목을 입력해주세요")
	private String reportsubject;
	
	public int getC_seq() {
		return c_seq;
	}
	public void setC_seq(int c_seq) {
		this.c_seq = c_seq;
	}
	public int getR_seq() {
		return r_seq;
	}
	public void setR_seq(int r_seq) {
		this.r_seq = r_seq;
	}
	public int getB_seq() {
		return b_seq;
	}
	public void setB_seq(int b_seq) {
		this.b_seq = b_seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReportcontent() {
		return reportcontent;
	}
	public void setReportcontent(String reportcontent) {
		this.reportcontent = reportcontent;
	}
	public String getReportsubject() {
		return reportsubject;
	}
	public void setReportsubject(String reportsubject) {
		this.reportsubject = reportsubject;
	}
	
}
