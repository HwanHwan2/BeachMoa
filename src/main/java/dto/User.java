package dto;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class User {
	@Size(min=4,max=12,message="아이디는 4자 이상 12자 이하로 입력하세요")
	private String id; // SNS로그인 일 경우 이메일이 들어감, 일반회원은 ID
	private String logintype; // kakao, naver, normal
	@NotEmpty(message="이름을 입력해주세요.")
	private String name;
	@Size(min=2,max=8,message="별명은 2자 이상 8자 이하로 입력하세요")
	private String nickname;
	@Size(min=8,max=12,message="비밀번호를 입력해주세요.(8자~12자)")
	private String password;
	@Size(min=8,max=12,message="재확인 비밀번호를 입력해주세요.(8자~12자)")
	private String password2;
	@NotEmpty(message="성별을 선택해주세요.")
	private String gender; //성별
	private int age_range; //연령대
	@NotEmpty(message="email을 입력해주세요")
	@Email(message="잘못된 이메일 형식입니다.")
	private String email;
	@NotEmpty(message="출생년도를 선택해주세요.")
	private String birthyear; //태어난연도
	private Date join_date;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2;
	}
	public String getBirthyear() {
		return birthyear;
	}
	public void setBirthyear(String birthyear) {
		this.birthyear = birthyear;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLogintype() {
		return logintype;
	}
	public void setLogintype(String logintype) {
		this.logintype = logintype;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getAge_range() {
		return age_range;
	}
	public void setAge_range(int age_range) {
		this.age_range = age_range;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", logintype=" + logintype + ", nickname=" + nickname + ", password=" + password
				+ ", gender=" + gender + ", agerange=" + age_range + ", email=" + email + ", birthyear=" + birthyear + "]";
	}
	
}
