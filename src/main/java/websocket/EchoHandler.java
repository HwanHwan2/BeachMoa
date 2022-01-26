package websocket;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import dto.User;
import logic.BeachService;

@Component
@Repository
public class EchoHandler extends TextWebSocketHandler{
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>(); //로그인 중인 전체 유저
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>(); //로그인중인 개별유저
	@Autowired
	private BeachService service;

	private String UserId; //접속한 유저를 저장하는 변수
	//==============================세션이 서버에 접속이 성공 했을 경우=============================
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		 sessions.add(session);
		 UserId = getUserId(session);
		 System.out.println(UserId + " = " + session.getId());
		 userSessionsMap.put(UserId, session);
		 System.out.println("접속중인 유저 : " + userSessionsMap);
		 System.out.println("------------------------------------------------------------------------------------");
	}
	
	//==============================클라이언트가 서버로 데이터를 전송할 때===============================
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		String msg = message.getPayload(); //클라이언트에서 보낸 메세지를 msg에 저장
		/*
		 *  0 : 알람 타입.( 0-쪽지 보낼 때,
		 *  			 1-댓글 작성 시,
		 *  			 2-자기 게시글,댓글에 신고 들어왔을 때
		 *  			 3-관리자 전용 5회 신고 누적 게시글
		 *  			 4-관리자 전용 5회 신고 누적 댓글)
		 *	1 : 보낸사람
		 *	2 : 받는사람
		 *	3 : 내용 (신고일 경유 게시글 제목으로)
		 *	4 : 날짜
		 */
		if(!StringUtils.isEmpty(msg)) { //msg 값이 !Empty인 경우
			String strs[] = msg.split(",");
			if(strs != null && strs.length == 5) { //쪽지 보낼 때 알람.
				String alarmType = strs[0];
				String sentid = strs[1]; 
				String recvid = strs[2]; 
				String content = strs[3];
				String today = strs[4];

		 		//받는 사람이 로그인 되어 있을 경우
		 		WebSocketSession userSession = userSessionsMap.get(recvid);
		 		if(userSession != null) { //받는 사람이 세션에 있는 경우. 로그인 되어 있는 경우.
		 			if(alarmType.equals("0")) { //쪽지 보낼 때
		 				TextMessage tMessage = new TextMessage(sentid + "님이 쪽지를 보냈습니다.," + "'" + content + "'");
		 				userSession.sendMessage(tMessage);
		 			} else if(alarmType.equals("1")) { //댓글 작성 시
		 				TextMessage tMessage = new TextMessage(sentid + "님이 게시글에 댓글을 남겼습니다.," + "'" + content + "'");
		 				userSession.sendMessage(tMessage);
		 			} else if(alarmType.equals("2")) { //자기 게시글,댓글에 신고 들어왔을 때
		 			TextMessage tMessage = new TextMessage("해당 게시물에 신고가 접수되었습니다.," + "'게시물 제목 : " + content + "'");
		 				userSession.sendMessage(tMessage);
		 			} else if(alarmType.equals("3")) { //관리자 전용 5회 신고 누적 게시글
		 				TextMessage tMessage = new TextMessage(sentid + "님이 게시글에 댓글을 남겼습니다.,");
		 				userSession.sendMessage(tMessage);
		 			} else if(alarmType.equals("4")) { //관리자 전용 5회 신고 누적 댓글
		 				TextMessage tMessage = new TextMessage(sentid + "님이 게시글에 댓글을 남겼습니다.,");
		 				userSession.sendMessage(tMessage);
		 			}
		 		} else {
		 			System.out.println("받는 사람이 로그인을 안했네요");
		 		}
			}
		}
	}
	//===============================오류 발생 시======================================
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception{
		log(session.getId() + "오류 발생 : " + exception.getMessage());
	}
	//================================연결이 종료됐을 때==================================
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결 끊김 : " + UserId);
		System.out.println("------------------------------------------------------------------------------------");
		userSessionsMap.remove(session.getId());
		sessions.remove(session);
	}
	//================================로그 메세지======================================
	private void log(String logmsg) {
		System.out.println(new Date() + ":" + logmsg);
	}
	//==============================웹소켓에서 쓰일 유저의 id를 가져오기=======================
	private String getUserId(WebSocketSession session) {
		Map<String, Object> httpSession = new HashMap<>();
		httpSession = session.getAttributes();	
		User loginUser = (User)httpSession.get("login");
				
		if(loginUser == null) {
			return session.getId();
		} else {
			return loginUser.getId();
		}
	}
}
