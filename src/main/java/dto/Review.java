package dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Review {
	private int r_seq;
	private int beachno;
	private String id;
	private String nickname;
	private String subject;
	private String content;
	private int rating;
	private int recomcnt;
	private Date regdate;
	private MultipartFile file1;
	private String fileurl;
	private String beachNm;
	
	public int getR_seq() {
		return r_seq;
	}
	public void setR_seq(int r_seq) {
		this.r_seq = r_seq;
	}
	public int getBeachno() {
		return beachno;
	}
	public void setBeachno(int beachno) {
		this.beachno = beachno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
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
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getRecomcnt() {
		return recomcnt;
	}
	public void setRecomcnt(int recomcnt) {
		this.recomcnt = recomcnt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public String getFileurl() {
		return fileurl;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}
	public String getBeachNm() {
		return beachNm;
	}
	public void setBeachNm(String beachNm) {
		this.beachNm = beachNm;
	}
	@Override
	public String toString() {
		return "Review [r_seq=" + r_seq + ", beachno=" + beachno + ", id=" + id + ", nickname=" + nickname
				+ ", subject=" + subject + ", content=" + content + ", rating=" + rating + ", recomcnt=" + recomcnt
				+ ", regdate=" + regdate + ", file1=" + file1 + ", fileurl=" + fileurl + ", beachNm=" + beachNm + "]";
	}


}