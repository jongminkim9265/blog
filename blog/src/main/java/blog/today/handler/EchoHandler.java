package blog.today.handler;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import blog.today.vo.UserVO;


public class EchoHandler extends TextWebSocketHandler{
	Logger log = Logger.getLogger(this.getClass());
	//로그인중인 개별유저 얻어오기
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();

	// 클라이언트가 서버 연결 성공시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getId(session); // 접속한 유저의 http세션 조회후 id 얻음
		if(senderId != null) {
			log.debug(senderId + " 연결 성공");
			userSessionsMap.put(senderId, session); //로그인 중인 개별 유저 저장
		}
	}
	//클라이언트가 Data 전송 시
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String senderId = getId(session);
		// 특정 유저에게 전송
		String msg = message.getPayload();
		System.out.println(message.getPayload());
		if(msg != null) {
			String[] strs = msg.split(",");
			log.debug(strs.toString());
			if(strs != null && strs.length == 3) {
				String cmd = strs[0];
				String receiverId = strs[1];
				String seq = strs[2];
				WebSocketSession targetSession = userSessionsMap.get(receiverId);
				
//				if(targetSession != null) {
//					TextMessage tmpMsg = new TextMessage("<a target='_blank' href= '"+ url + "'>[<b>"  + "</b>]" + content + "</a>");
//					targetSession.sendMessage(tmpMsg);
//				}
				
			}
		}
	}
	// 클라이언트가 서버연결 해제시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderId = getId(session);
		if(senderId != null) {
			log.debug(senderId + " 연결 해제");
			userSessionsMap.remove(senderId);
			userSessionsMap.remove(session);
		}
	}
	//에러 발생
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.debug(session.getId() + " 에러 발생 : " + exception.getMessage());
	}
	//로그 메시지
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}
	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		UserVO loginUser = (UserVO)httpSession.get("UserVO");
		
		if(loginUser == null) {
			return session.getId();
		} else {
			return loginUser.getID();
		}
	}
}
