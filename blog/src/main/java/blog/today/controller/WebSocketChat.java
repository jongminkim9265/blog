package blog.today.controller;

import javax.websocket.server.ServerEndpoint;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.WebSocketSession;

import blog.today.service.BoardService;

import javax.websocket.RemoteEndpoint.Basic;


@Controller
@ServerEndpoint(value="/echo.do")
public class WebSocketChat {
	
	//알림을 설정하고자 서비스
	@Resource(name="boardService")
	private BoardService boardService;
	
	//웹소켓 서버 연결 인원 리스트
	private static final List<Session> sessionList = new ArrayList<Session>();
	Logger log = Logger.getLogger(this.getClass());
	public WebSocketChat() {
		System.out.println("웹소켓 객체 생성");
	}
//	@RequestMapping(value="/chat.do")
//	public ModelAndView getChatViewPage(ModelAndView mav) {
//		//mav.setViewName("chat");
//		return mav;
//		
//	}
//	@RequestMapping(value="/alarm.do")
//	public ModelAndView getAlarm(ModelAndView mav) {
//		return mav;
//	}
	@OnOpen
    public void onOpen(Session session) {
		log.debug("Open session id:"+session.getId());
		System.out.println("Open session id:"+session.getId());
        try {
            final Basic basic=session.getBasicRemote();
        }catch (Exception e) {
            System.out.println(e.getMessage());
        }
        sessionList.add(session);
    }
	private void sendAllSessionToMessage(Session self,String message) {
        try {
            for(Session session : WebSocketChat.sessionList) {
                if(!self.getId().equals(session.getId())) {
                    session.getBasicRemote().sendText(message.split(",")[1]+" : "+message);
                }
                if(self.getId().equals(session.getId())) {
                	
                }
            }
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
    }
    @OnMessage
    public void onMessage(String message,Session session) {
    	//[1] : username [0] : message
    	log.debug("Message From "+message.split(",")[1] + ": "+message.split(",")[0] );
        try {
        	
            final Basic basic=session.getBasicRemote();
            basic.sendText(message.split(",")[1]+ " : "+message.split(",")[0]);
            //basic.sendText("");
        }catch (Exception e) {

            System.out.println(e.getMessage());
        }
        sendAllSessionToMessage(session, message);
    }
    @OnError
    public void onError(Throwable e,Session session) {
        
    }
    @OnClose
    public void onClose(Session session) {
    	log.info("Session "+session.getId()+" has ended");
        sessionList.remove(session);
    }
    private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String m_id = (String) httpSession.get("name");
		return m_id==null? null: m_id;
	}
}

