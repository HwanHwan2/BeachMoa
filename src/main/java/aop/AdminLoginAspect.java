package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import dto.User;
import exception.LoginException;

//@Component
//@Aspect // spring-mvc.xml - <aop:aspectj-autoproxy/>
//@Order(1)
public class AdminLoginAspect {
	
	@Around("execution(* controller.Admin*.*(..)) && args(..,session)")
	public Object adminLoginCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable{
		User login = (User)session.getAttribute("loginUser");
		
		if(login == null) {
			throw new LoginException("로그인 후 이용하세요", "../user/login.shop");
		}
		if(!login.getId().equals("admin")) {
			throw new LoginException("관리자만 가능합니다.", "../user/main.shop");
		}
		return joinPoint.proceed();
	}
}
