package config;

import javax.websocket.server.ServerEndpointConfig.Configurator;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import websocket.EchoHandler;

//WebSocket 순서
//WebSocketHandler를 추가한다.
// 1. 클라이언트가 접속을 했을 때 특정 메소드가 호출
// 2. 클라이언트가 접속을 close했을 때 특정 메소드가 호출
// 3. 클라이언트가 메시지를 보냈을 때 특정 메소드 호출
@Configuration
@EnableWebSocket // 웹소켓 사용 설정
public class WebSocketConfig extends Configurator implements WebSocketConfigurer{
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(new EchoHandler(), "EchoHandler.do")
			.addInterceptors(new HttpSessionHandshakeInterceptor())  //HttpSession 정보를 가져오는 메소드.
			.setAllowedOrigins("*"); // 모든 브라우저 허용
	}
	
	@Bean
	public WebSocketHandler EchoHandler() {
		return new EchoHandler();
	}
	
}
