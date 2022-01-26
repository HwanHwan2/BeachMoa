package dto;

import java.util.Date;

public class Alarm {
	private int a_no;
	private String a_sent_id;
	private String a_recv_id;
	private String a_title;
	private String a_content;
	private int a_read;
	private Date a_date;
	private String a_href;
	public String getA_href() {
		return a_href;
	}
	public void setA_href(String a_href) {
		this.a_href = a_href;
	}
	public int getA_no() {
		return a_no;
	}
	public void setA_no(int a_no) {
		this.a_no = a_no;
	}
	public String getA_sent_id() {
		return a_sent_id;
	}
	public void setA_sent_id(String a_sent_id) {
		this.a_sent_id = a_sent_id;
	}
	public String getA_title() {
		return a_title;
	}
	public void setA_title(String a_title) {
		this.a_title = a_title;
	}
	public String getA_recv_id() {
		return a_recv_id;
	}
	public void setA_recv_id(String a_recv_id) {
		this.a_recv_id = a_recv_id;
	}
	public String getA_content() {
		return a_content;
	}
	public void setA_content(String a_content) {
		this.a_content = a_content;
	}
	public int getA_read() {
		return a_read;
	}
	public void setA_read(int a_read) {
		this.a_read = a_read;
	}
	public Date getA_date() {
		return a_date;
	}
	public void setA_date(Date a_date) {
		this.a_date = a_date;
	}
	@Override
	public String toString() {
		return "Alarm [a_no=" + a_no + ", a_sent_id=" + a_sent_id + ", a_recv_id=" + a_recv_id + ", a_title=" + a_title
				+ ", a_content=" + a_content + ", a_read=" + a_read + ", a_date=" + a_date + ", a_href=" + a_href + "]";
	}
	
}
