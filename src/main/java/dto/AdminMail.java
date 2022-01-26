package dto;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;


@Component
@Configuration
@PropertySource("classpath:account.properties")
public class AdminMail {
	/*관리자 이메일 계정*/
	@Value("${mail.admin.id}")
	String id;
	@Value("${mail.admin.pw}")
	String pw;
	
	/*properties 경로 설정*/
	@Value("${mail.path}")
	String path;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	
}
