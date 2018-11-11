package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.MemberDAO;
import dao.MemberDAOImpl;
import dto.BbsDto;
import dto.MemberDto;

public class MemberController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");

		String command = req.getParameter("command");

		MemberDAOImpl memDao = MemberDAO.getInstance();
		PrintWriter out = resp.getWriter();

		if (command.equals("login")) {
			System.out.println("doProcess 실행");

			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");

			MemberDto mem = memDao.login(new MemberDto(id, pwd));

			if (mem != null && !mem.getId().equals("")) {
				HttpSession session = null;

				if (session == null) {

					session = req.getSession(true);
					session.setAttribute("login", mem);
					System.out.println(mem.toString());
					session.setMaxInactiveInterval(30 * 60);

					out.println("<script>alert('" + id + "님 로그인하였습니다'); location.href='index.jsp';</script>");
					out.flush();

					// dispatch("index.jsp?page=1", req, resp);

				}

			} else {

				out.println("<script>alert('로그인 실패'); location.href='login.jsp';</script>");
				out.flush();

				// dispatch("login.jsp", req, resp);
			}
		}

		else if (command.equals("join")) {
			System.out.println("doProcess 실행");

			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			/*
			 * address_num , address , Detail_Address 658-서울특별시-
			 */
			String addressnum = req.getParameter("address_num");
			String address1 = req.getParameter("address");
			String addressDtaile = req.getParameter("Detail_Address");
			String address = addressnum + "-" + address1 + "-" + addressDtaile;
			String phone = req.getParameter("phone");

			System.out.println("id = " + id);
			System.out.println("pwd = " + pwd);
			System.out.println("name = " + name);
			System.out.println("email = " + email);
			System.out.println("address = " + address);
			System.out.println("phone = " + phone);

			boolean b = memDao.addMember(new MemberDto(id, pwd, name, email, address, phone, null, 0));

			if (b) {

				out.println("<script>alert('회원가입 성공'); location.href='index.jsp';</script>");
				out.flush();

				// dispatch("index.jsp", req, resp);
			} else {

				System.out.println("회원가입 실패");
				out.println("<script>alert('회원가입 실패'); location.href='join.jsp';</script>");
				out.flush();

				// dispatch("index.jsp", req, resp);
			}

		}

		else if (command.equals("idCheck")) {
			System.out.println("doProcess 실행");

			String id = req.getParameter("id");
			System.out.println("id = " + id);

			boolean b = memDao.checkId(id);

			StringBuffer json = new StringBuffer();
			json.append("{");
			json.append(" \"status\" : \"success\", "); // 요청한 것 잘 처리했고,
			json.append(" \"duplicated\" : " + b); // 그 결과는 isDuplicated이다.
			json.append(" } ");

			PrintWriter writer = resp.getWriter();
			writer.write(json.toString());
			writer.flush();
			writer.close();

		}

		else if (command.equals("emailCheck")) {
			System.out.println("doProcess 실행");
			String email = req.getParameter("email");

			boolean b = memDao.checkEmail(email);

			StringBuffer json = new StringBuffer();
			json.append("{");
			json.append(" \"status\" : \"success\", "); // 요청한 것 잘 처리했고,
			json.append(" \"duplicated\" : " + b); // 그 결과는 isDuplicated이다.
			json.append(" } ");

			PrintWriter writer = resp.getWriter();
			writer.write(json.toString());
			writer.flush();
			writer.close();
		}

		else if (command.equals("logout")) {
			System.out.println("doProcess 실행");

			HttpSession session = req.getSession();

			session.invalidate();

			if (req.getSession(false) == null) {
				System.out.println("세션이 만료되었습니다");

				System.out.println("로그아웃 성공");

				out.println("<script>alert('로그아웃 되었습니다'); location.href='index.jsp';</script>");
				out.flush();
				// dispatch("index.jsp", req, resp);
			}
		} else if (command.equals("changeimg")) {
			String savePath = req.getServletContext().getRealPath("/upload");

			int sizeLimit = 1024 * 1024 * 15;

			try {
				MultipartRequest multi = new MultipartRequest(req, savePath, sizeLimit, "utf-8",
						new DefaultFileRenamePolicy());

				MemberDto dto = (MemberDto) req.getAttribute("login");
				String id = multi.getParameter("userId");
				String fileName = multi.getFilesystemName("filename");

				if (!checkFileForm(fileName)) {
					out.println(
							"<script>alert('png, jpg, jpeg의 확장자의 이미지 파일을 사용할 수 있습니다.'); location.href='userMyPage.jsp';</script>");
					out.flush();
					return;
				}

				boolean isS = memDao.setUserImg(id, fileName);

				if (isS) {
					out.println("<script>alert('수정되었습니다'); location.href='userMyPage.jsp';</script>");
					out.flush();
				}
			} catch (Exception e) {

			}

		} else if (command.equals("userinfo")) {
			System.out.println("doProcess 실행");

			List<MemberDto> uesrList = memDao.getUserList();

			req.setAttribute("uesrList", uesrList);

			dispatch("userinfo.jsp", req, resp);

		}

		else if (command.equals("replace")) {
			String addressnum = req.getParameter("address_num");
			String address1 = req.getParameter("address");
			String addressDtaile = req.getParameter("Detail_Address");

			String address = addressnum + "-" + address1 + "-" + addressDtaile;
			String phone = req.getParameter("phone");
			String id = req.getParameter("id");
			String pwd = req.getParameter("pwd");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			String img = req.getParameter("img");
			int auth = Integer.parseInt(req.getParameter("auth"));

			MemberDto mem = new MemberDto(id, pwd, name, email, address, phone, img, auth);

			boolean isS = memDao.updateMember(mem);

			if (isS) {
				HttpSession session = null;
				session = req.getSession(true);
				session.setAttribute("login", mem);
				session.setMaxInactiveInterval(30 * 60);

				out.println("<script>alert('수정되었습니다'); location.href='userMyPage.jsp';</script>");
				out.flush();
			} else {
				out.println("<script>alert('수정 실패'); location.href='userMyPage.jsp';</script>");
				out.flush();
			}
		}

		else if (command.equals("gooleLogin")) {
			String id = req.getParameter("id");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			String img = req.getParameter("img");
			
			MemberDto dto = new MemberDto(email, id, name, email, "비공개", "비공개", img, 2);
			System.out.println(dto.toString());
			HttpSession session = null;

			if (memDao.checkId(email) == false) {
				// 아이디 조회 후 회원정보가 없을 경우
				if (memDao.addMember(dto)) {
					// 첫 구글로그인시 회원 정보 등록 및 세션값 등록 후 서비스 이용
					session = req.getSession(true);
					session.setAttribute("login", dto);
					session.setMaxInactiveInterval(30 * 60);

					out.println("<script>alert('구글 로그인 성공'); location.href='index.jsp';</script>");
					out.flush();
				} else {
					out.println("<script>alert('구글아이디 등록 실패'); location.href='index.jsp';</script>");
					out.flush();
				}
			} else {
				// 첫 로그인이 아닌 유저는 로그인
				if (memDao.login(dto) != null && !memDao.login(dto).getId().equals("")) {
					// 회원정보가 있습니다.
					if (session == null) {
						session = req.getSession(true);
						session.setAttribute("login", dto);
						session.setMaxInactiveInterval(30 * 60);

						out.println("<script>alert('" + email + "님 로그인하였습니다'); location.href='index.jsp';</script>");
						out.flush();
					}
				}else {
					System.out.println("구글 로그인 실패");
				}
			}
		}

		out.close();
	}

	// 업로드파일 확장자 확인
	public boolean checkFileForm(String fileName) {
		boolean check = false;
		int i = fileName.lastIndexOf(".");

		String str = fileName.substring(i, fileName.length());
		str = str.toLowerCase();

		if (str.equals(".png") || str.equals(".jpg") || str.equals(".jpeg")) {
			check = true;
		}

		return check;
	}

	public void dispatch(String urls, HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		RequestDispatcher dispatch = req.getRequestDispatcher(urls);
		dispatch.forward(req, resp);
	}
}
