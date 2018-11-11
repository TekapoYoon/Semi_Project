package dto;

/*   
//테이블 삭제
DROP TABLE REPLY
CASCADE CONSTRAINTS;

//시퀀스 삭제
DROP SEQUENCE R_SEQ;

-- 댓글 테이블
CREATE TABLE REPLY(
 SEQ NUMBER(10),
 ID VARCHAR2(50),
 DSEQ NUMBER(10),
 CONTENT VARCHAR2(500) NOT NULL,
 WDATE DATE NOT NULL,
 
 CONSTRAINT PK_REPLY_SEQ PRIMARY KEY(SEQ),
 CONSTRAINT FK_REPLY_ID FOREIGN KEY(ID) REFERENCES MEMBER(ID)
 );
 
ALTER TABLE REPLY
ADD CONSTRAINT FK_REPLY_DSEQ FOREIGN KEY (DSEQ) REFERENCES BBS(SEQ) ON DELETE CASCADE;

-- 댓글 시퀀스
CREATE SEQUENCE R_SEQ
INCREMENT BY 1
START WITH 1
MAXVALUE 9999;
*/

public class ReplyDto {
	private int seq;
	private String id;
	private String content;
	private String wdate;
	
	public ReplyDto() {
		
	}
	
	public ReplyDto(int seq, String id, String content, String wdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.content = content;
		this.wdate = wdate;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

}
