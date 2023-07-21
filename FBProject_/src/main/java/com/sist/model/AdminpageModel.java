package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;

public class AdminpageModel {
	//멤버 관리
	@RequestMapping("adminpage/adminpage_main.do")
	public String adminpage(HttpServletRequest request, HttpServletResponse response) {
		
		AdminDAO dao = AdminDAO.newInstance();
		List<MemberVO> list=dao.memberListData();
		request.setAttribute("list", list);
			
		request.setAttribute("admin_jsp", "../adminpage/memberinfo.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("adminpage/memberDetail.do")
	public String memberDetail(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");
		AdminDAO dao=AdminDAO.newInstance();
		MemberVO vo=dao.memberDetailData(id);
		request.setAttribute("vo", vo);
		return "../adminpage/memberDetail.jsp";
	}
	
	@RequestMapping("adminpage/memberDetail_modify.do")
	public void memberModify(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {	}
		MemberVO vo=new MemberVO();
		vo.setId(request.getParameter("id"));
		vo.setEmail(request.getParameter("email"));
		vo.setName(request.getParameter("name"));
		vo.setNickname(request.getParameter("nickname"));
		vo.setSex(request.getParameter("sex"));
		vo.setBirthday(request.getParameter("birthday"));
		vo.setPhone(request.getParameter("phone"));
		vo.setPost(request.getParameter("post"));
		vo.setAddr1(request.getParameter("addr1"));
		vo.setAddr2(request.getParameter("addr2"));
		vo.setSigndate(request.getParameter("signdate"));
		vo.setAdmin(request.getParameter("admin"));
		AdminDAO dao=AdminDAO.newInstance();
		dao.memberUpdate(vo);
		System.out.println("memberModify_Model:수정완료");
	}
	
	//멤버 탈퇴
	@RequestMapping("adminpage/memberDelete.do")
	public void memberDelete(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");
		MypageDAO dao=MypageDAO.newInstance();
		dao.memberDelete(id);
	}
	//--멤버 관리-- 
	
	//구장 리스트
	@RequestMapping("adminpage/ground_list.do")
	public String ground_list(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		
		String page=request.getParameter("page");
		String search=request.getParameter("search");
		if(search==null)
			search="";
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		AdminDAO dao=AdminDAO.newInstance();
		List<GroundDetailVO> list=dao.groundListData(curpage, search);
		int totalpage=dao.groundTotalPage(search);
		
		final int BLOCK=10;
		int startpage=((curpage-1)/BLOCK)*BLOCK+1;
		int endpage=((curpage-1)/BLOCK)*BLOCK+BLOCK;
		if(totalpage<endpage) {
			endpage=totalpage;
		}
		
		request.setAttribute("search", search);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		
		
		request.setAttribute("list", list);
		request.setAttribute("admin_jsp", "../adminpage/ground_list.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("adminpage/groundDetail.do")
	public String groundDetail(HttpServletRequest request, HttpServletResponse response) {
		String gno=request.getParameter("gno");
		
		AdminDAO dao=AdminDAO.newInstance();
		GroundDetailVO vo=dao.groundDetailData(Integer.parseInt(gno));
		
		request.setAttribute("vo", vo);
		return "../adminpage/groundDetail.jsp";
	}
	
	@RequestMapping("adminpage/groundModify.do")
	public void groundModify(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {	}
		GroundDetailVO vo=new GroundDetailVO();
		vo.setGno(Integer.parseInt(request.getParameter("gno")));
		vo.setGname(request.getParameter("gname"));
		vo.setGaddr(request.getParameter("gaddr"));
		vo.setGprice(request.getParameter("gprice"));
		vo.setGnotice(request.getParameter("gnotice"));
		
		AdminDAO dao=AdminDAO.newInstance();
		dao.groundUpdate(vo);
		
		System.out.println("goodsModify_Model:수정완료");
	}
	
	@RequestMapping("adminpage/groundDelete.do")
	public void groundDelete(HttpServletRequest request, HttpServletResponse response) {
		String gno=request.getParameter("gno");
		
		AdminDAO dao=AdminDAO.newInstance();
		dao.groundDelete(Integer.parseInt(gno));
		
		System.out.println("groundDelete:삭제완료");
	}
	//--구장 리스트--
	
	
	//예약 현황 리스트
	@RequestMapping("adminpage/reserve_info.do")
	public String reserve_info(HttpServletRequest request, HttpServletResponse response) {
		AdminDAO dao=AdminDAO.newInstance();
		List<ReserveVO> list=dao.reserveListData();
		
		request.setAttribute("list", list);
		request.setAttribute("admin_jsp", "../adminpage/reserve_info.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("adminpage/stateChange.do")
	public String stateChange(HttpServletRequest request, HttpServletResponse response) {
		String rno=request.getParameter("rno");
		String rstate=request.getParameter("rstate");
		
		AdminDAO dao=AdminDAO.newInstance();
		dao.reserveStateUpdate(rstate, Integer.parseInt(rno));
		
		return "redirect:../adminpage/reserve_info.do";
	}
	//-- 구장 예약 --
	
	//물품 관리
	@RequestMapping("adminpage/goods_list.do")
	public String goods_list(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		
		String page=request.getParameter("page");
		String search=request.getParameter("search");
		if(search==null)
			search="";
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		AdminDAO dao=AdminDAO.newInstance();
		List<ShopVO> list=dao.goodsListData(curpage, search);
		int totalpage=dao.goodsTotalPage(search);
		
		final int BLOCK=10;
		int startpage=((curpage-1)/BLOCK)*BLOCK+1;
		int endpage=((curpage-1)/BLOCK)*BLOCK+BLOCK;
		if(totalpage<endpage) {
			endpage=totalpage;
		}
		
		request.setAttribute("search", search);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		
		request.setAttribute("list", list);
		request.setAttribute("admin_jsp", "../adminpage/goods_list.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("adminpage/goodsDetail.do")
	public String goodsDetail(HttpServletRequest request, HttpServletResponse response) {
		String gno=request.getParameter("gno");
		
		
		AdminDAO dao=AdminDAO.newInstance();
		ShopVO vo=dao.goodsDetailData(Integer.parseInt(gno));
		List<sizeVO> slist=dao.goodsSizeData(Integer.parseInt(gno));
		
		request.setAttribute("slist", slist);
		request.setAttribute("vo", vo);
		return "../adminpage/goodsDetail.jsp";
	}
	
	@RequestMapping("adminpage/goodsDetail_modify.do")
	public void goodsDetail_modify(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {	}
		int count=Integer.parseInt(request.getParameter("count"));
		ShopVO vo=new ShopVO();
		vo.setGno(Integer.parseInt(request.getParameter("gno")));
		vo.setGoods_name(request.getParameter("name"));
		vo.setBrand(request.getParameter("brand"));
		vo.setOrigin(request.getParameter("origin"));
		vo.setCprice(Integer.parseInt(request.getParameter("cprice")));
		vo.setPrice(Integer.parseInt(request.getParameter("price")));
		
		List<sizeVO> slist=new ArrayList<>();
		for(int i=1;i<=count;i++) {
			sizeVO svo=new sizeVO();
			svo.setGsize(request.getParameter("size"+i));
			svo.setStock(Integer.parseInt(request.getParameter("stock"+i)));
			slist.add(svo);
		}

		AdminDAO dao=AdminDAO.newInstance();
		dao.goodsUpdate(vo, slist);
		
		System.out.println("goodsModify_Model:수정완료");
	}
	
	@RequestMapping("adminpage/goodsDelete.do")
	public void goodsDelete(HttpServletRequest request, HttpServletResponse response) {
		String gno=request.getParameter("gno");
		
		AdminDAO dao=AdminDAO.newInstance();
		dao.goodsDelete(Integer.parseInt(gno));
		
		System.out.println("adminpage/goodsDelete.do:삭제완료");
	}
	
	@RequestMapping("adminpage/goodsInsert.do")
	public String goodsInsert(HttpServletRequest request, HttpServletResponse response) {
		
		
		return "../adminpage/goods_insert.jsp";
	}
	
	//--물품 관리--
	
	//주문 관리
	@RequestMapping("adminpage/order_list.do")
	public String order_list(HttpServletRequest request, HttpServletResponse response) {
		AdminDAO dao=AdminDAO.newInstance();
		List<ShopCartVO> list=dao.orderListData();
		
		request.setAttribute("list", list);
		request.setAttribute("admin_jsp", "../adminpage/order_list.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		return "../main/home.jsp";
	}
	@RequestMapping("adminpage/check_ok.do")
	public String buyOkChange(HttpServletRequest request, HttpServletResponse response) {
		String ono=request.getParameter("ono");
		String check_ok=request.getParameter("check_ok");
		AdminDAO dao=AdminDAO.newInstance();
		dao.buyOkChange(Integer.parseInt(ono), Integer.parseInt(check_ok));
		
		return "redirect:../adminpage/order_list.do";
	}
	
	//-- 주문 관리 --
	
	//문의글 관리
	@RequestMapping("adminpage/qnaboard_list.do")
	public String qnaboardList(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		
		String page=request.getParameter("page");
		String search=request.getParameter("search");
		if(search==null)
			search="";
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		AdminDAO dao=AdminDAO.newInstance();
		List<QnaVO> list=dao.qnaListData(curpage, search);
		int totalpage=dao.qnaTotalPage(search);
		
		final int BLOCK=10;
		int startpage=((curpage-1)/BLOCK)*BLOCK+1;
		int endpage=((curpage-1)/BLOCK)*BLOCK+BLOCK;
		if(totalpage<endpage) {
			endpage=totalpage;
		}
		
		request.setAttribute("search", search);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		
		request.setAttribute("list", list);
		
		request.setAttribute("admin_jsp", "../adminpage/qnaboard_list.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		return "../main/home.jsp";
	}
	
	//문의글 답장
	@RequestMapping("adminpage/qnaboard_reply.do")
	public String qnaReply(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String reply=request.getParameter("reply");
		String page=request.getParameter("page");
		String search=request.getParameter("search");
		String qno=request.getParameter("qno");
		
		if(search==null) {
			search="";
		}
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		ReplyVO vo=new ReplyVO();
		vo.setMsg(reply);
		vo.setId(id);
		vo.setQno(Integer.parseInt(qno));
		
		AdminDAO dao=AdminDAO.newInstance();
		dao.replyInsert(vo);
		
		return "redirect:../adminpage/qnaboard_list.do?page="+page+"&search="+search;
	}
	
	//공지사항 리스트
	@RequestMapping("adminpage/notice_list.do")
	public String noticeList(HttpServletRequest request, HttpServletResponse response) {
		AdminDAO dao=AdminDAO.newInstance();
		List<NoticeVO> list=dao.noticeListData();
		
		request.setAttribute("list", list);
		request.setAttribute("admin_jsp", "../adminpage/notice_list.jsp");
		request.setAttribute("main_jsp", "../adminpage/adminpage_main.jsp");
		return "../main/home.jsp";
	}
	//공지사항 고정 수정
	@RequestMapping("adminpage/fixChange.do")
	public String fixChange(HttpServletRequest request, HttpServletResponse response) {
		String fix=request.getParameter("fix");
		String nno=request.getParameter("nno");
		AdminDAO dao=AdminDAO.newInstance();
		dao.fixUpdate(Integer.parseInt(fix), Integer.parseInt(nno));
		
		return "redirect:../adminpage/notice_list.do";
	}
	//공지사항 삭제
	@RequestMapping("adminpage/noticeDelete.do")
	public String noticeDelete(HttpServletRequest request, HttpServletResponse response) {
		String nno=request.getParameter("nno");
		AdminDAO dao=AdminDAO.newInstance();
		dao.noticeDelete(Integer.parseInt(nno));
		
		return "redirect:../adminpage/notice_list.do";
	}
	//-- 게시물 --
	
	
	
}
