package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;
import dto.MemberDto;
import dto.ReplyDto;

public class BbsDAO implements BbsDAOImpl {

	// 싱글톤 설정
	private static BbsDAO bbsDAO = new BbsDAO();

	private BbsDAO() {
		DBConnection.initConnect();
	}

	public static BbsDAO getInstance() {
		return bbsDAO;
	}

	public BbsDto getContent(int seq) {

		String sql1 = " UPDATE BBS SET READCOUNT = READCOUNT + 1 " + " WHERE SEQ = ? ";
		
		String sql2 = " SELECT SEQ, ID, TITLE, CONTENT, WDATE, DEL, READCOUNT, REPLYCNT, "
				+ " FILENAME, PROFILENAME, FAVORITE, HASHTAG FROM BBS" + " WHERE SEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;
		BbsDto dto = null;

		 System.out.println("1/6 getBbsDetail success");
		try {
			
			conn = DBConnection.makeConnection();
			conn.setAutoCommit(false);

			psmt = conn.prepareStatement(sql1);
			System.out.println("2/6 getBbsDetail success");

			psmt.setInt(1, seq);

			count = psmt.executeUpdate();
			psmt.clearParameters();
			System.out.println("3/6 getBbsDetail success");

			psmt = conn.prepareStatement(sql2);
			psmt.setInt(1, seq);

			rs = psmt.executeQuery();
			System.out.println("4/6 getBbsDetail success");

			if (rs.next()) {
				dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getString(3), 
						rs.getString(4), rs.getString(5),rs.getInt(6), 
						rs.getInt(7), rs.getInt(8), rs.getString(9),
						rs.getString(10), rs.getInt(11), rs.getString(12));
			}
			System.out.println("5/6 getBbsDetail success");
		} catch (SQLException e) {
			System.out.println("getBbsDetail failed");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(psmt, conn, null);
		}
		System.out.println("END getBbsDetail success");
		return dto;
	}

	

	@Override
	public boolean addBbs(BbsDto dto) {
		String sql = " INSERT INTO BBS "
				+ " (SEQ, ID, TITLE, CONTENT, WDATE, DEL, READCOUNT, REPLYCNT, FILENAME, PROFILENAME, FAVORITE, HASHTAG) "
				+ " VALUES(B_SEQ.NEXTVAL,?,?,?,SYSDATE,0,0,0,?,?,0,?) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 setContent success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 setContent success");

			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getFilename());
			psmt.setString(5, dto.getProfilename());
			psmt.setString(6, dto.getHashtag());

			count = psmt.executeUpdate();
			System.out.println("3/6 setContent success");

		} catch (SQLException e) {
			System.out.println("setContent fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		System.out.println("END setContent success");
		return count > 0 ? true : false;
	}

	@Override
	public List<BbsDto> getBbsList() {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, WDATE, DEL, READCOUNT, REPLYCNT, FILENAME, PROFILENAME, FAVORITE, HASHTAG"
				+ " FROM BBS " + " WHERE DEL = 0 ORDER BY WDATE DESC";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<BbsDto>();

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getBbsList Success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBbsList Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getBbsList Success");

			while (rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10),
						rs.getInt(11), rs.getString(12));
				list.add(dto);
			}
			System.out.println("4/6 getBbsList Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getBbsList fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("END getBbsList Success");
		return list;
	}

	@Override
	public List<BbsDto> getBestList() {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, WDATE, DEL, READCOUNT, REPLYCNT, FILENAME, PROFILENAME, FAVORITE, HASHTAG "
				+ " FROM BBS " + "WHERE DEL = 0 ORDER BY FAVORITE DESC, READCOUNT DESC, WDATE DESC";
				
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<BbsDto>();

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getBestList Success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getBestList Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getBestList Success");

			while (rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10),
						rs.getInt(11), rs.getString(12));
				list.add(dto);
			}
			System.out.println("4/6 getBestList Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getBestList fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("END getBestList Success");
		return list;
	}

	@Override
	public List<BbsDto> getSearchList(String str) {
		String sql = " select * from BBS where DEL = 0 AND (title like '%" + str + "%' OR content like '%" + str
				+ "%' OR hashtag like '%" + str + "%')";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<BbsDto>();

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getSearchList Success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getSearchList Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getSearchList Success");

			while (rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10),
						rs.getInt(11), rs.getString(12));
				list.add(dto);
			}
			System.out.println("4/6 getSearchList Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getSearchList fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("END getSearchList Success");
		return list;
	}

	@Override
	public List<BbsDto> getUserBbsList(String id) {
		String sql = " SELECT * FROM BBS WHERE DEL = 0 AND id = '" + id + "' ORDER BY WDATE DESC ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<BbsDto>();

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getUserBbsList Success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 getUserBbsList Success");

			rs = psmt.executeQuery();
			System.out.println("3/6 getUserBbsList Success");

			while (rs.next()) {
				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10),
						rs.getInt(11), rs.getString(12));
				list.add(dto);
			}
			System.out.println("4/6 getUserBbsList Success");

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getUserBbsList fail");
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("END getUserBbsList Success");
		return list;
	}

	// 좋아요 체크확인
	@Override
	public int checkF(String id, int seq) {
		String sql = " SELECT Like_Check FROM LIKETO" + " WHERE ID=? AND B_SEQ=?";

		Connection conn = null; // DB info
		PreparedStatement psmt = null; // sql query
		ResultSet rs = null; // result value

		int find = 0;

		try {
			conn = DBConnection.makeConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, seq);

			rs = psmt.executeQuery();

			if (rs.next()) {
				find = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return find;

	}

	// 좋아요 read
	@Override
	public void readLike(int seq) {
		String sql = " UPDATE BBS" + " SET FAVORITE=FAVORITE+1 " + " WHERE SEQ=?";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/4 readLike success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);

			System.out.println("2/4 readLike success");

			psmt.executeUpdate();
			System.out.println("3/4 readLike success");

		} catch (SQLException e) {
			System.out.println("updateDay fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/4 readLike success");
		}

	}

	// 좋아요 테이블 add
	@Override
	public boolean addLiketo(String id, int seq) {
		String sql = " INSERT INTO LIKETO " + " (ID, B_SEQ, LIKE_CHECK) " + " VALUES(?,?,0) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/3 addLiketo success");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 addLiketo success");

			psmt.setString(1, id);
			psmt.setInt(2, seq);

			count = psmt.executeUpdate();
			System.out.println("3/3 addLiketo success");

		} catch (SQLException e) {
			System.out.println("setContent fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		System.out.println("END setContent success");
		return count > 0 ? true : false;
	}

	// 좋아요 테이블 찾기
	@Override
	public boolean findLiketo(String id, int seq) {
		String sql = " SELECT ID, B_SEQ FROM LIKETO" + " WHERE ID=? AND B_SEQ=?";

		Connection conn = null; // DB info
		PreparedStatement psmt = null; // sql query
		ResultSet rs = null; // result value

		boolean find = false;

		try {
			conn = DBConnection.makeConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, seq);

			rs = psmt.executeQuery();

			if (rs.next()) {
				find = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return find;
	}

	// 좋아요 체크
	@Override
	public void fck(String id, int seq) {
		String sql = " UPDATE LIKETO" + " SET LIKE_CHECK=1 " + " WHERE ID=? AND B_SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/4 fck success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, seq);

			System.out.println("2/4 fck success");

			psmt.executeUpdate();
			System.out.println("3/4 fck success");

		} catch (SQLException e) {
			System.out.println("fck fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/4 fck success");
		}

	}

	// 좋아요 수 감소
	@Override
	public void readLikeDown(int seq) {
		String sql = " UPDATE BBS" + " SET FAVORITE=FAVORITE-1 " + " WHERE SEQ=?";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/4 readLikeDown success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);

			System.out.println("2/4 readLikeDown success");

			psmt.executeUpdate();
			System.out.println("3/4 readLikeDown success");

		} catch (SQLException e) {
			System.out.println("readLikeDown fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/4 readLikeDown success");
		}

	}

	// 좋아요 체크해제
	@Override
	public void fckDown(String id, int seq) {
		String sql = " UPDATE LIKETO" + " SET LIKE_CHECK=0 " + " WHERE ID=? AND B_SEQ=? ";

		Connection conn = null;
		PreparedStatement psmt = null;

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/4 readLike success");

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, seq);

			System.out.println("2/4 readLike success");

			psmt.executeUpdate();
			System.out.println("3/4 readLike success");

		} catch (SQLException e) {
			System.out.println("updateDay fail");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/4 readLike success");
		}

	}

	// bbs 좋아요 수 가져오기
	@Override
	public int getLikeCount(int seq) {
		String sql = " SELECT FAVORITE FROM BBS" + " WHERE SEQ=? ";

		Connection conn = null; // DB info
		PreparedStatement psmt = null; // sql query
		ResultSet rs = null; // result value

		int FAVORITE = 0;

		try {
			conn = DBConnection.makeConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);

			rs = psmt.executeQuery();

			if (rs.next()) {
				FAVORITE = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}

		return FAVORITE;
	}

	@Override
	public boolean BbsUpdate(String title, String content, int b_seq) {
		
		String sql = " UPDATE BBS SET TITLE = ? "
				+ " , CONTENT = ? WHERE SEQ = ? "; 
				
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
		conn = DBConnection.makeConnection();
		System.out.println("1/6 BbsUpdate Success");
			
		psmt = conn.prepareStatement(sql);
		psmt.setString(1, title);
		psmt.setString(2, content);
		psmt.setInt(3, b_seq);
		
		System.out.println("2/6 BbsUpdate Success");
		count = psmt.executeUpdate();
		System.out.println("3/6 BbsUpdate Success");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("4/6 END BbsUpdate Success");
		}
		return count>0?true:false;
	}

	@Override
	public boolean BbsDelete(int seq) {
		
		String sql = " UPDATE BBS SET DEL = 1 WHERE SEQ = ? ";
		
		int count = 0;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		try {
		conn = DBConnection.makeConnection();
		System.out.println("1/6 END BbsUpdate Success");

		psmt = conn.prepareStatement(sql);
		psmt.setInt(1, seq);
		System.out.println("2/6 END BbsUpdate Success");

		count = psmt.executeUpdate();
		System.out.println("3/6 END BbsUpdate Success");

		} catch (SQLException e) {
		System.out.println("Failed BbsDelete");
		
			e.printStackTrace();
		}
		System.out.println("END BbsDelete Success");

		return count>0?true:false;
	}
	
	// 댓글 쓰기
	@Override
	public int CommentWrite(int seq, String id, String dcomment) {

		String sql = " INSERT INTO REPLY(SEQ, DSEQ, ID, CONTENT, WDATE)" + " VALUES( R_SEQ.NEXTVAL, ?, ?,?, SYSDATE)";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/6 CommentWrite success");

			psmt.setInt(1, seq);
			psmt.setString(2, id);
			psmt.setString(3, dcomment);
			
			count = psmt.executeUpdate();
			System.out.println("2/6 CommentWrite success");

		} catch (SQLException e) {
			System.out.println("CommentWrite failed");
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, null);
			System.out.println("3/6 CommentWrite success");
		}
		return count;
	}
	//댓글삭제
	@Override
	public int CommentDelete(int seq) {
		String sql = " DELETE REPLY " + " WHERE SEQ = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);
			System.out.println("1/4 CommentDelete success");
			
			psmt.setInt(1, seq);

			count = psmt.executeUpdate();
			System.out.println("2/4 CommentDelete success");
			
		} catch (SQLException e) {
			System.out.println("CommentDelete failed");
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public List<ReplyDto> commentview(int seq) {
		String sql = " SELECT SEQ, ID, CONTENT, WDATE" + " FROM REPLY" + " WHERE DSEQ=?" + " ORDER BY WDATE DESC";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<ReplyDto> list = new ArrayList<>();

		try {
			conn = DBConnection.makeConnection();
			System.out.println("1/6 commentview suceess");

			psmt = conn.prepareStatement(sql);
			System.out.println("2/6 commentview suceess");

			psmt.setInt(1, seq);

			rs = psmt.executeQuery();
			System.out.println("3/6 commentview suceess");

			while (rs.next()) {

				list.add(new ReplyDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));

			}
		} catch (SQLException e) {
			System.out.println("commentview failed");

		} finally {
			DBClose.close(psmt, conn, rs);
		}
		return list;
	}

	// 게시판 디테일 사진 수정
	@Override
	public boolean setBbsImg(int seq, String imgname) {
		String sql = " UPDATE BBS SET FILENAME = '"+imgname+"' WHERE SEQ = '"+seq+"' ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		System.out.println("setBbsImg1");
		int count = 0;

		try {
			conn = DBConnection.makeConnection();
			psmt = conn.prepareStatement(sql);

			System.out.println("setBbsImg2");
		
			count = psmt.executeUpdate();
			System.out.println("setBbsImg3");
		} catch (SQLException e) {
			System.out.println("setBbsImg fail");
		} finally {
			DBClose.close(psmt, conn, null);
		}
		System.out.println("End setBbsImg success");

		return count > 0 ? true : false;
	}

	@Override
	public List<BbsDto> getBiggerSeq(int seq) {
		
		String sql = " SELECT SEQ, TITLE, FILENAME FROM BBS WHERE SEQ > ? AND DEL = 0 ORDER BY SEQ ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> bigger = new ArrayList<>();
		
		try {
		
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getBiggerSeq");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getBiggerSeq");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getBiggerSeq");
			
			int i = 0;
			while(rs.next()) {
				int b_seq = rs.getInt(1);
				String title = rs.getString(2);
				String filename = rs.getString(3);
				
				bigger.add(new BbsDto(b_seq, title, filename));
				System.out.println("bigger" + bigger.get(i).toString());
				i++;
			}
			System.out.println("4/6 getBiggerSeq");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("ENd getBiggerSeq");

		return bigger;
	}

	@Override
	public List<BbsDto> getSmallerSeq(int seq) {
		
		String sql = " SELECT SEQ, TITLE, FILENAME FROM BBS WHERE SEQ < ? AND DEL = 0 ORDER BY SEQ DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BbsDto> smaller = new ArrayList<>();
		
		try {
		
			conn = DBConnection.makeConnection();
			System.out.println("1/6 getSmallerSeq");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/6 getSmallerSeq");
			
			rs = psmt.executeQuery();
			System.out.println("3/6 getSmallerSeq");
			
			int i = 0;
			while(rs.next()) {
				int b_seq = rs.getInt(1);
				String title = rs.getString(2);
				String filename = rs.getString(3);
				
				smaller.add(new BbsDto(b_seq, title, filename));
				System.out.println("smaller" + smaller.get(i).toString());
				i++;
			}
			System.out.println("4/6 getSmallerSeq");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(psmt, conn, rs);
		}
		System.out.println("End getSmallerSeq");

		return smaller;

	}


}
