package dto;

/*	
// 테이블 삭제
DROP TABLE CALENDAR
CASCADE CONSTRAINTS;

// 시퀀스 삭제
DROP SEQUENCE C_SEQ;

// 테이블 생성
CREATE TABLE CALENDAR(
	SEQ NUMBER(10),
	ID VARCHAR2(50),
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	RDATE VARCHAR2(12) NOT NULL,
	WDATE DATE NOT NULL,
    
    CONSTRAINT PK_CAL_SEQ PRIMARY KEY(SEQ),
    CONSTRAINT FK_CAL_ID FOREIGN KEY(ID) REFERENCES MEMBER(ID)
);

// 시퀀스 생성
CREATE SEQUENCE C_SEQ
INCREMENT BY 1
START WITH 1
MAXVALUE 9999;
*/

public class CalendarDto {
	private int seq;
	private String id;
	private String title;
	private String content;
	private String rdate;
	private String wdate;
	
	public CalendarDto() {}

	public CalendarDto(int seq, String id, String title, String content, String rdate, String wdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.rdate = rdate;
		this.wdate = wdate;
	}

	public CalendarDto(String id, String title, String content, String rdate) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.rdate = rdate;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	@Override
	public String toString() {
		return "CalendarDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", rdate="
				+ rdate + ", wdate=" + wdate + "]";
	}
	
}
