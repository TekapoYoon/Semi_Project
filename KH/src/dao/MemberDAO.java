package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDAO implements MemberDAOImpl {

	// 싱글톤 설정
	private static MemberDAO memberDAO = new MemberDAO();

	private MemberDAO() {

		DBConnection.initConnect();
	}

	public static MemberDAO getInstance() {
		return memberDAO;
	}

	// 로그인
	@Override
	public MemberDto login(MemberDto dto) {

		String sql = " SELECT ID, NAME, EMAIL, ADDRESS, PHONE, IMG, AUTH " + " FROM MEMBER " + " WHERE ID=? AND PWD=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		MemberDto mem = null;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			System.out.println("1/6 login success");

			psmt.setString(1, dto.getId().trim());
			psmt.setString(2, dto.getPwd());

			System.out.println("2/6 login success");

			rs = psmt.executeQuery();

			System.out.println("3/6 login success");

			if (rs.next()) {

				String id = rs.getString(1);
				String name = rs.getString(2);
				String email = rs.getString(3);
				String address = rs.getString(4);
				String phone = rs.getString(5);
				String img = rs.getString(6);
				int auth = rs.getInt(7);

				mem = new MemberDto(id, null, name, email, address, phone, img, auth);
			}
			System.out.println("4/6 login success");

		} catch (SQLException e) {
			System.out.println("login fail");
		} finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("END login success");
		}

		return mem;
	}

	// 멤버 추가
	@Override
	public boolean addMember(MemberDto dto) {

		String sql = " INSERT INTO MEMBER " + " (ID, PWD, NAME, EMAIL, ADDRESS, PHONE, IMG, AUTH) "
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?) ";

		Connection conn = null;
		PreparedStatement psmt = null;
		System.out.println("1");
		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			System.out.println("2");
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getAddress());
			psmt.setString(6, dto.getPhone());
			psmt.setString(7, dto.getImg());
			psmt.setInt(8, dto.getAuth());

			System.out.println("3");
			count = psmt.executeUpdate();
			System.out.println("4");
		} catch (SQLException e) {
			System.out.println("addMember fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		System.out.println("End addMember success");

		return count > 0 ? true : false;
	}

	// 멤버 수정
	@Override
	public boolean updateMember(MemberDto dto) {
		String sql = " UPDATE MEMBER " + " SET ID=?, PWD=?, NAME=?, EMAIL=?, ADDRESS=?, PHONE=?, IMG=?, AUTH=?"
				+ " WHERE ID=? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		System.out.println("1updateMember");
		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			System.out.println("2updateMember");
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getAddress());
			psmt.setString(6, dto.getPhone());
			psmt.setString(7, dto.getImg());
			psmt.setInt(8, dto.getAuth());
			psmt.setString(9, dto.getId());

			System.out.println("3updateMember");
			count = psmt.executeUpdate();
			System.out.println("4updateMember");
		} catch (SQLException e) {
			System.out.println("updateMember fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		System.out.println("End addMember success");

		return count > 0 ? true : false;
	}

	@Override
	public boolean deleteMember(MemberDto dto) {
		// TODO Auto-generated method stub
		return false;
	}

	// 아이디 체크
	@Override
	public boolean checkId(String id) {
		String sql = " SELECT ID FROM MEMBER" + " WHERE ID=?";

		Connection conn = null; // DB info
		PreparedStatement psmt = null; // sql query
		ResultSet rs = null; // result value

		boolean findId = false;

		try {
			conn = DBConnection.makeConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);

			rs = psmt.executeQuery();

			if (rs.next()) {
				findId = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
			System.out.println("ID check = "+findId);
		}
		return findId;
	}

	// 멤버 리스트 가져오기
	@Override
	public List<MemberDto> getUserList() {
		String sql = " SELECT ID, PWD, NAME, EMAIL, ADDRESS, PHONE, IMG, AUTH " + " FROM MEMBER " + " ORDER BY ID ASC ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<MemberDto> list = new ArrayList<>();

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/6 getBbsList success");

			rs = psmt.executeQuery();
			System.out.println("2/6 getBbsList success");

			while (rs.next()) {
				int i = 1;

				MemberDto dto = new MemberDto(rs.getString(i++), rs.getString(i++), rs.getString(i++),
						rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getString(i++), rs.getInt(i++));

				list.add(dto);
			}
			System.out.println("3/6 getBbsList success");

		} catch (SQLException e) {
			System.out.println("getBbsList fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return list;
	}

	// 이메일 체크
	@Override
	public boolean checkEmail(String email) {
		String sql = " SELECT EMAIL FROM MEMBER" + " WHERE EMAIL=?";

		Connection conn = null; // DB info
		PreparedStatement psmt = null; // sql query
		ResultSet rs = null; // result value

		Boolean findEmail = false;

		try {
			conn = DBConnection.makeConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, email);

			rs = psmt.executeQuery();

			if (rs.next()) {
				findEmail = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return findEmail;
	}

	// 아이디로 회원정보 가져오기
	@Override
	public MemberDto getUserDto(String id) {
		String sql = " SELECT * FROM MEMBER WHERE ID = '" + id + "' ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		MemberDto mem = null;

		conn = DBConnection.makeConnection();
		System.out.println("1/6 login success");

		try {
			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 login success");

			rs = psmt.executeQuery();
			System.out.println("3/6 login success");

			if (rs.next()) {
				String userId = rs.getString(1);
				String name = rs.getString(3);
				String email = rs.getString(4);
				String address = rs.getString(5);
				String phone = rs.getString(6);
				String img = rs.getString(7);
				int auth = rs.getInt(8);

				mem = new MemberDto(userId, null, name, email, address, phone, img, auth);
			}
			System.out.println("4/6 login success");
			
		} catch (SQLException e) {
			System.out.println("login fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("END login success");
		return mem;
	}
	
	// 회원 프로필 사진 수정
	@Override
	public boolean setUserImg(String id, String filename) {
		String sql1 = " UPDATE MEMBER SET IMG = '"+filename+"' WHERE ID = '"+id+"' ";
		String sql2 = " UPDATE BBS SET PROFILENAME = '"+filename+"' WHERE ID = '"+id+"' ";

		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 setUserImg success");
			
			psmt = conn.prepareStatement(sql1);
			System.out.println("2/6 setUserImg success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 setUserImg success");
			
			psmt.clearParameters();
			
			psmt = conn.prepareStatement(sql2);
			System.out.println("4/6 setUserImg success");
			
			count = psmt.executeUpdate();
			conn.commit();
			System.out.println("5/6 setUserImg success");
			
		} catch (SQLException e) {
			System.out.println("setUserImg fail");
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(psmt, conn, null);
		}
		System.out.println("End setUserImg success");
		return count > 0 ? true : false;
	}
}
