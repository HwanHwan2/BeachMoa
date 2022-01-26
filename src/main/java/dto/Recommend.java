package dto;

public class Recommend {
	private int r_seq;
	private String id;
	public int getR_seq() {
		return r_seq;
	}
	public void setR_seq(int r_seq) {
		this.r_seq = r_seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "Recommend [r_seq=" + r_seq + ", id=" + id + "]";
	}
	
}