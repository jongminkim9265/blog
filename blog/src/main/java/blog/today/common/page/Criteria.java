package blog.today.common.page;

public class Criteria {
	private int page;
	private int perPageNum;
	
	public int getPageStart() {
		return (this.page-1)*perPageNum;
	}
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
		
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1; //page는 0이하로 떨어질 수 없으므로
		}
		else {
			this.page= page;
		}
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int pageCount) {
		int cnt = this.perPageNum;
		if(pageCount != cnt) {
			this.perPageNum = cnt;
		}
		else {
			this.perPageNum = pageCount;
		}
		
		
	}
}

