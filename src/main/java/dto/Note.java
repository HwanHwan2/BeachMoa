package dto;

import java.util.Date;

public class Note {
	private int n_no;
	private String n_sent_id;
	private String n_recv_id;
	private String title;
	private String note;
	private Date date_sent;
	public int getN_no() {
		return n_no;
	}
	public void setN_no(int n_no) {
		this.n_no = n_no;
	}
	public String getN_sent_id() {
		return n_sent_id;
	}
	public void setN_sent_id(String n_sent_id) {
		this.n_sent_id = n_sent_id;
	}
	public String getN_recv_id() {
		return n_recv_id;
	}
	public void setN_recv_id(String n_recv_id) {
		this.n_recv_id = n_recv_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Date getDate_sent() {
		return date_sent;
	}
	public void setDate_sent(Date date_sent) {
		this.date_sent = date_sent;
	}
	@Override
	public String toString() {
		return "NoteDao [n_no=" + n_no + ", n_sent_id=" + n_sent_id + ", n_recv_id=" + n_recv_id + ", title=" + title
				+ ", note=" + note + ", date_sent=" + date_sent + "]";
	}
}
