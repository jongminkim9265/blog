package blog.today.vo;

import java.util.Date;

public class ReplyVO {
	
	private int replyIDX;
	private int b_idx;
	private String replyText;
	private String replywriter;
	private Date regdate;
	private Date updatedate;
	//private int likecnt;
	public int getReplyIDX() {
		return replyIDX;
	}
	public void setReplyIDX(int replyIDX) {
		this.replyIDX = replyIDX;
	}
	public String getReplyText() {
		return replyText;
	}
	public void setReplyText(String replyText) {
		this.replyText = replyText;
	}
	public int getb_idx() {
		return b_idx;
	}
	public void setb_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public String getReplywriter() {
		return replywriter;
	}
	public void setReplywriter(String replywriter) {
		this.replywriter = replywriter;
	}
	
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
//	public int getLikecnt() {
//		return likecnt;
//	}
//	public void setLikecnt(int likecnt) {
//		this.likecnt = likecnt;
//	}
	
}

