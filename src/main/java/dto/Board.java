package dto;

import java.util.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class Board {
	private int seq;
	private String id;
	private String nickname;
	private String password;
	@NotEmpty(message="제목을 입력해주세요")
	private String subject;
	@NotEmpty(message="내용을 입력해주세요")
	private String content;
	@NotNull(message="게시판을 선택해주세요")
	private int btype;
	private int readcnt;
	private int reportcnt;
	private int commcnt;
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getCommcnt() {
		return commcnt;
	}
	public void setCommcnt(int commcnt) {
		this.commcnt = commcnt;
	}
	private Date regdate;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getBtype() {
		return btype;
	}
	public void setBtype(int btype) {
		this.btype = btype;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getReportcnt() {
		return reportcnt;
	}
	public void setReportcnt(int reportcnt) {
		this.reportcnt = reportcnt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "Board [seq=" + seq + ", id=" + id + ", password=" + password + ", subject=" + subject + ", content="
				+ content + ", btype=" + btype + ", readcnt=" + readcnt + ", reportcnt=" + reportcnt + ", regdate="
				+ regdate + "]";
	}
		
}
