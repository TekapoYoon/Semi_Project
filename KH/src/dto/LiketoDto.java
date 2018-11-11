package dto;

import java.io.Serializable;

/*
// 테이블 삭제
DROP TABLE LIKETO
CASCADE CONSTRAINTS; 

CREATE TABLE LIKETO(
    ID VARCHAR2(50),
    B_Seq NUMBER(10),
    Like_Check NUMBER(1) NOT NULL,
    
    CONSTRAINT FK_LIKE_ID FOREIGN KEY(ID) REFERENCES MEMBER(ID) ON DELETE CASCADE,
    CONSTRAINT FK_LIKE_BNO FOREIGN KEY(B_Seq) REFERENCES BBS(SEQ) ON DELETE CASCADE
);
    
*/
public class LiketoDto implements Serializable {
	private static final long serialVersionUID = 1L;
	private String id;
	private int b_seq;
	private int like_check;
	
	public LiketoDto() {
		// TODO Auto-generated constructor stub
	}

	public LiketoDto(String id, int b_seq, int like_check) {
		super();
		this.id = id;
		this.b_seq = b_seq;
		this.like_check = like_check;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getB_seq() {
		return b_seq;
	}

	public void setB_seq(int b_seq) {
		this.b_seq = b_seq;
	}

	public int getLike_check() {
		return like_check;
	}

	public void setLike_check(int like_check) {
		this.like_check = like_check;
	}

	@Override
	public String toString() {
		return "LiketoDto [id=" + id + ", b_seq=" + b_seq + ", like_check=" + like_check + "]";
	}
	
	
	
}
