package controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;


import dto.User;
import logic.BeachService;
import logic.CipherUtil;
import logic.KakaoService;
import logic.NaverService;

@Controller
@RequestMapping("user")
public class LoginController {
	private final static String id = "a5e07eaae67f31a7600a4ba004d7bf55";
	private final static String url = "http://localhost:8080/BeachMoa/user/kakaologin.do";
	//카카오 로그인 서비스
	@Autowired
	private KakaoService kakaoService;
	//네이버 로그인 서비스
	@Autowired
	private NaverService naverLoginBO;
	private String apiResult = null;
	
	
	//암호화
	@Autowired
	private CipherUtil cipher;
	//전반적인 서비스
	@Autowired
	private BeachService service;

	@Autowired
	private void setNaverLoginBO(NaverService naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	//카카오 로그인
	@RequestMapping("/kakaologin")
	public ModelAndView kakaologin(@RequestParam(value = "code", required = false) String code, HttpSession session)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		System.out.println(code);

		User user = new User();
		// 카카오에서 받아온 결과값을 node에 담음
		JsonNode node = kakaoService.getAccessToken(code);
		System.out.println(node);
		// accessToken에 사용자의 로그인한 모든 정보가 들어있음
		JsonNode accessToken = node.get("access_token");
		System.out.println(accessToken.asText());
		JsonNode userInfo = kakaoService.getKakaoUserInfo(accessToken);
		// properties 정보 => {"nickname":"이름"}
		JsonNode properties = userInfo.path("properties");
		//kakao_account 정보 동의 여부 및, 개인 정보 있음
		//{"profile_needs_agreement":false,"profile":{"nickname":"김창희"},"has_email":true,"email_needs_agreement":false,"is_email_valid":true,"is_email_verified":true,
		//"email":"pok_uni@naver.com","has_age_range":true,"age_range_needs_agreement":false,"age_range":"20~29","has_birthday":true,
		//"birthday_needs_agreement":false,"birthday":"0130","birthday_type":"SOLAR","has_gender":true,"gender_needs_agreement":false,"gender":"male"}
		
		JsonNode kakao_account = userInfo.path("kakao_account");
		System.out.println(properties);
		System.out.println(kakao_account);
		user.setLogintype("kakao");
		user.setId(kakao_account.path("email").asText());
		user.setNickname(properties.path("nickname").asText());
		user.setEmail(kakao_account.path("email").asText());		
		user.setAge_range(Integer.parseInt(kakao_account.path("age_range").asText().substring(0,2)));
		String gender = kakao_account.path("gender").asText();
		
		if(gender.equals("male")) gender="남자";
		else gender="여자";	
		user.setGender(gender);
		//db등록
//		if(service.countone(user.getId())==0) {
//			service.entry(user);
//		}else {
//			
//		}
		
		session.setAttribute("login", user);
		mav.setViewName("close");
		return mav;

	}
	//네이버 로그인
	@RequestMapping(value = "/naverlogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String naverlogin(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		System.out.println("여기는 callback");
		User user = new User();
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"201390458","nickname":"별명","age":"20-29","gender":"M","email":"0000@naver.com","name":"실명"}}
		 **/	
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		
		//로그인 타입
		user.setLogintype("naver");
		//이메일 정보
		user.setId(response_obj.get("email").toString());
		user.setEmail(response_obj.get("email").toString());
		//소셜로그인 가입 이름
		user.setNickname(response_obj.get("name").toString());
		//연령대 정보
		int agerange = Integer.parseInt(response_obj.get("age").toString().substring(0,2)); // 20-29 -> 20
		user.setAge_range(agerange);
		//성별정보 
		String gender = response_obj.get("gender").toString();
		if(gender.equals("M")) gender = "남자";
		else gender = "여자";
		user.setGender(gender);
		//출생년도
		user.setBirthyear(response_obj.get("birthyear").toString());
		
		//User.setBirthday(response_obj.get("birthday").toString()); 생일정보
		
		//회원 DB 등록
//		if(service.countone(user.getId())==0) {
//			service.entry(user);
//		//업데이트.
//		}else {
//			
//		}
		
		// 4.로그인 유저정보 세션 등록.
		session.setAttribute("login", user);
		return "close";
	}
	
	//구글 로그인
	@PostMapping("/googlelogin")
	public ModelAndView googlelogin() {
		return null;
	}
	
	//일반로그인
	@PostMapping("/login")
	public ModelAndView login(User user, BindingResult bindResult,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		//id와 password 모두 입력되지 않을 경우
		if(user.getId().equals("") && user.getPassword().equals("")) {
			mav.getModel().putAll(bindResult.getModel());
			bindResult.reject("error.user.empty");
			return mav;
		}else if(!user.getId().equals("") && user.getPassword().equals("")) {
			mav.getModel().putAll(bindResult.getModel());
			bindResult.reject("error.password.empty");
			return mav;
		}else if(user.getId().equals("") && !user.getPassword().equals("")) {
			mav.getModel().putAll(bindResult.getModel());
			bindResult.reject("error.id.empty");
			return mav;
		}
		
		try {
			User dbuser = service.selectOne(user.getId());
			System.out.println(dbuser.toString());
			//로그인
			if(dbuser.getPassword().equals(cipher.makehash(user.getPassword()).substring(0, 20))) {
				session.setAttribute("login", dbuser);
				mav.setViewName("redirect:main.do");
			}else {//로그인 실패
				//비밀번호 오류
				bindResult.reject("error.login.password"); //오류 메세지
				mav.getModel().putAll(bindResult.getModel());
			}
		}catch(Exception e){
			//아이디 정보가 맞지 않는 경우
			bindResult.reject("error.login.id"); // 오류 메세지
			mav.getModel().putAll(bindResult.getModel());
		}
		return mav;
	}
	
	//로그인뷰
	@GetMapping("/login")
	public String loginview(User user,Model model, HttpSession session) {
		
		String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?" + "client_id=" + id + "&redirect_uri=" + url
				+ "&response_type=code";
		model.addAttribute("kakaoUrl", kakaoUrl);
		System.out.println("카카오:" + kakaoUrl);
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=***************
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);
		// 네이버
		model.addAttribute("naverUrl", naverAuthUrl);
		return "user/login";
	}



//	@RequestMapping("/main")
//	public String main() {
//		return "user/main";
//	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login.do";
	}

}