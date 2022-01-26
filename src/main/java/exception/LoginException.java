package exception;

public class LoginException extends RuntimeException {
	private String url;
	
	//생성자
	public LoginException(String msg,String url) {
		super(msg); //RuntimeException의 getMessage(msg)
		this.url =url;
	}
	public String getUrl() {
		return url;
	}
}