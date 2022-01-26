package exception;

public class ReviewException extends RuntimeException {
	private String url;
	
	//생성자
	public ReviewException(String msg,String url) {
		super(msg); //RuntimeException의 getMessage(msg)
		this.url =url;
	}
	public String getUrl() {
		return url;
	}
}
