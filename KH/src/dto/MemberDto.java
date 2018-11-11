package dto;

import java.io.Serializable;

/*	
// 테이블 삭제
DROP TABLE MEMBER
CASCADE CONSTRAINTS;

// 테이블 생성
CREATE TABLE MEMBER(

    ID VARCHAR2(50) PRIMARY KEY,
    PWD VARCHAR2(50) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(100) UNIQUE,
    ADDRESS VARCHAR2(200) NOT NULL,
    PHONE VARCHAR2(20) NOT NULL,
    IMG VARCHAR2(200),
    AUTH NUMBER(1) NOT NULL
    );
*/

public class MemberDto implements Serializable{
	private String id;		// 구글 int
	private String pwd; 	// 구글 누락
	private String name;
	private String email;
	private String address;	// 구글 누락
	private String phone;	// 구글 누락
	private String img;
	private int auth;
	
	public MemberDto() {}
	
	public MemberDto(String id, String pwd) {
		super();
		this.id = id;
		this.pwd = pwd;
	}

	public MemberDto(String id, String pwd, String name, String email, String address, String phone, String img,
			int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.address = address;
		this.phone = phone;
		this.img = img;
		this.auth = auth;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", address=" + address
				+ ", phone=" + phone + ", img=" + img + ", auth=" + auth + "]";
	}
}
