package dto;

/*	
// 테이블 삭제
DROP TABLE BBS
CASCADE CONSTRAINTS;

// 시퀀스 삭제
DROP SEQUENCE B_SEQ;

// 테이블 생성
CREATE TABLE BBS(
    SEQ NUMBER(10),
    ID VARCHAR2(50),
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(4000) NOT NULL,
    WDATE DATE NOT NULL,
    DEL NUMBER(1) NOT NULL,
    READCOUNT NUMBER(10) NOT NULL,
    REPLYCNT NUMBER(10) NOT NULL,
    FILENAME VARCHAR2(200),
    PROFILENAME VARCHAR2(200),
    FAVORITE NUMBER(10) NOT NULL,
    HASHTAG VARCHAR2(50) NOT NULL,
    
    CONSTRAINT PK_BBS_SEQ PRIMARY KEY(SEQ),
    CONSTRAINT FK_BBS_ID FOREIGN KEY(ID) REFERENCES MEMBER(ID)
    );


-- 테이블 시퀀스
CREATE SEQUENCE B_SEQ
INCREMENT BY 1
START WITH 1
MAXVALUE 9999;
*/

public class BbsDto {
	private int seq;
	private String id;
	private String title;
	private String content;
	private String wdate;
	private int del;
	private int readcount;
	private int replycnt;
	private String filename;
	private String profilename;
	private int favorite;
	private String hashtag;

	public BbsDto() {
	}

	
	
	public BbsDto(int seq, String title, String filename) {
		super();
		this.seq = seq;
		this.title = title;
		this.filename = filename;
	}



	public BbsDto(int seq, String id, String title, String content, 
			String wdate, int del, int readcount, int replycnt,
			String filename, String profilename, int favorite, String hashtag) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
		this.readcount = readcount;
		this.replycnt = replycnt;
		this.filename = filename;
		this.profilename = profilename;
		this.favorite = favorite;
		this.hashtag = hashtag;
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

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getReplycnt() {
		return replycnt;
	}

	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getProfilename() {
		return profilename;
	}

	public void setProfilename(String profilename) {
		this.profilename = profilename;
	}

	public int getFavorite() {
		return favorite;
	}

	public void setFavorite(int favorite) {
		this.favorite = favorite;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}

	@Override
	public String toString() {
		return "BbsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", wdate=" + wdate
				+ ", del=" + del + ", readcount=" + readcount + ", replycnt=" + replycnt + ", filename=" + filename
				+ ", profilename=" + profilename + ", favorite=" + favorite + ", hashtag=" + hashtag + "]";
	}
}
