package com.sist.model;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.AdminDAO;
import com.sist.dao.MemberDAO;
import com.sist.dao.MypageDAO;
import com.sist.vo.MemberVO;
import com.sist.vo.QnaVO;
import com.sist.vo.ReserveVO;
import com.sist.vo.ReviewVO;
import com.sist.vo.ShopCartVO;

public class MypageModel {
	//내 정보
	@RequestMapping("mypage/mypage_info.do")
	public String mypage(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		AdminDAO dao=AdminDAO.newInstance();
		MemberVO vo=dao.memberDetailData(id);
		
		request.setAttribute("vo", vo);
		request.setAttribute("mypage_jsp", "../mypage/member_info.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("mypage/member_info_modify.do")
	public String member_info_modify(HttpServletRequest request, HttpServletResponse response) {

		return "../mypage/member_info_modify.jsp";
	}
	
	@RequestMapping("mypage/member_info_modify_check.do")
	public void pwdCheck(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
	
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		String pwd=request.getParameter("pwd");
		
		MypageDAO dao=MypageDAO.newInstance();
		boolean check=dao.pwdCheck(id, pwd);
		String msg="n";
		if(check) {
			MemberVO vo=new MemberVO();
			vo.setId(id);
			vo.setName(request.getParameter("name"));
			vo.setNickname(request.getParameter("nickname"));
			vo.setEmail(request.getParameter("email"));
			vo.setSex(request.getParameter("sex"));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setPhone(request.getParameter("phone"));
			vo.setPost(request.getParameter("post"));
			vo.setAddr1(request.getParameter("addr1"));
			vo.setAddr2(request.getParameter("addr2"));
			msg="y";
			dao=MypageDAO.newInstance();
			dao.infoUpdate(vo);
		} 
		
		try {
			PrintWriter out = response.getWriter();
			out.println(msg);
		} catch (Exception e) {}
	}
	
	//회원 탈퇴
	@RequestMapping("mypage/member_delete.do")
	public String memberDelete(HttpServletRequest request, HttpServletResponse response) {
		
		
		return "../mypage/member_delete.jsp";
	}
	//회원탈퇴 체크
	@RequestMapping("mypage/member_delete_pwd_check.do")
	public void mPwdCheck(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		String pwd=request.getParameter("pwd");
		
		MypageDAO dao=MypageDAO.newInstance();
		boolean check=dao.pwdCheck(id, pwd);
		String msg="n";
		if(check) {
			msg="y";
			dao.memberDelete(id);
			session.invalidate();
		} 
		
		try {
			PrintWriter out = response.getWriter();
			out.println(msg);
		} catch (Exception e) {}
	}
	
	///////////////////////////////////////////////////////
	
	//내 게시물
	@RequestMapping("mypage/mypage_boardlist.do")
	public String mypageBoardList(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		MypageDAO dao=MypageDAO.newInstance();
		List<QnaVO> list=dao.myQnaList(id);
		
		for(QnaVO vo:list) {
			if(vo.getContent().length()>=15) {
				vo.setContent(vo.getContent().substring(0,14)+"...");
			}
		}
		
		request.setAttribute("list", list);
		request.setAttribute("mypage_jsp", "../mypage/mypage_boardlist.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/home.jsp";
	}
	
	///////////////////////
	
	//예약 리스트
	@RequestMapping("mypage/reserve_list.do")
	public String myReserveList(HttpServletRequest request, HttpServletResponse response) {
		MypageDAO dao=MypageDAO.newInstance();
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		List<ReserveVO> list=dao.myReserveList(id);
		
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String now=format.format(date);
		
		request.setAttribute("now", now);
		request.setAttribute("list", list);
		request.setAttribute("mypage_jsp", "../mypage/my_reserve_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/home.jsp";
	}
	
	//리뷰 팝업창
	@RequestMapping("mypage/reviewWrite.do")
	public String reviewWrite(HttpServletRequest request, HttpServletResponse response) {
		String rno=request.getParameter("rno");
		MypageDAO dao=MypageDAO.newInstance();
		ReserveVO vo=dao.myReserveDetail(Integer.parseInt(rno));
		
		request.setAttribute("vo", vo);
		return "../mypage/review_write.jsp";
	}
	
	//리뷰 업로드
	@RequestMapping("mypage/reviewInsert.do")
	public void reviewInsert(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String rank=request.getParameter("rank");
		String content=request.getParameter("content");
		String rdate=request.getParameter("rdate");
		String gno=request.getParameter("gno");
		String rno=request.getParameter("rno");
		String id=request.getParameter("id");

		ReviewVO vo=new ReviewVO();
		vo.setScore(Double.parseDouble(rank));
		vo.setContent(content);
		vo.setRdate(rdate);
		vo.setGno(Integer.parseInt(gno));
		vo.setRno(Integer.parseInt(rno));
		vo.setId(id);
		
		MypageDAO dao=MypageDAO.newInstance();
		dao.reviewInsert(vo);
	}
	
	//////////////////////////
	
	//리뷰 페이지
	@RequestMapping("mypage/review_list.do")
	public String reviewList(HttpServletRequest request, HttpServletResponse response) {
		MypageDAO dao=MypageDAO.newInstance();
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		List<ReviewVO> list=dao.reviewListData(id);
		
		request.setAttribute("list", list);
		request.setAttribute("mypage_jsp", "../mypage/review_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("mypage/reviewDetail.do")
	public String reviewDetail(HttpServletRequest request, HttpServletResponse response) {
		String rvno=request.getParameter("rvno");
		MypageDAO dao=MypageDAO.newInstance();
		ReviewVO vo=dao.reviewDetailData(Integer.parseInt(rvno));
		
		request.setAttribute("vo", vo);
		return "../mypage/review_detail.jsp";
	}
	
	////////////////////////////////
	
	//주문 내역
	@RequestMapping("mypage/order_list.do")
	public String orderList(HttpServletRequest request, HttpServletResponse response) {
		MypageDAO dao=MypageDAO.newInstance();
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		List<ShopCartVO> list=dao.orderListData(id);
		
		request.setAttribute("list", list);
		request.setAttribute("mypage_jsp", "../mypage/order_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/home.jsp";
	}
}
