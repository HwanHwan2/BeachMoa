package dto;

import java.util.Date;

public class Comment {
	private int c_seq;
	private int b_seq;
	private String id;
	private String nickname;
	private String c_content;
	private Date c_regdate;
	private int c_grp;
	private int btype;

	public int getBtype() {
		return btype;
	}

	public void setBtype(int btype) {
		this.btype = btype;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getC_seq() {
		return c_seq;
	}

	public void setC_seq(int c_seq) {
		this.c_seq = c_seq;
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

	public String getC_content() {
		return c_content;
	}

	public void setC_content(String c_content) {
		this.c_content = c_content;
	}

	public Date getC_regdate() {
		return c_regdate;
	}

	public void setC_regdate(Date c_regdate) {
		this.c_regdate = c_regdate;
	}

	public int getC_grp() {
		return c_grp;
	}

	public void setC_grp(int c_grp) {
		this.c_grp = c_grp;
	}

	@Override
	public String toString() {
		return "Comment [c_seq=" + c_seq + ", b_seq=" + b_seq + ", id=" + id + ", c_content=" + c_content
				+ ", c_regdate=" + c_regdate + ", c_grp=" + c_grp + "]";
	}

}
