package com.sist.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.QnaDAO;
import com.sist.dao.ReplyDAO;
import com.sist.vo.QnaVO;
import com.sist.vo.ReplyVO;

public class QnaModel {
	@RequestMapping("qna/list.do")
	public String qna_list(HttpServletRequest request, HttpServletResponse response)
	{
		String page=request.getParameter("page");
		if(page==null) {
			page="1";
		}
		int curpage=Integer.parseInt(page);
		QnaDAO dao=QnaDAO.newInstance();
		List<QnaVO> list=dao.qnaListData(curpage);
		int  total=dao.qnaTotalPage();
		final int BLOCK=5;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>total)
			endPage=total;
		int count=dao.qnaCount();
		count=count-(10*(curpage-1));
		
		request.setAttribute("count", count);
		request.setAttribute("totalpage", total);
		request.setAttribute("curpage", curpage);
		request.setAttribute("list", list);
		request.setAttribute("startpage", startPage);
		request.setAttribute("endpage", endPage);
		
		String today=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		request.setAttribute("today", today);
		
	
		request.setAttribute("main_jsp", "../qna/list.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("qna/detail.do")
	public String qna_detail(HttpServletRequest request, HttpServletResponse response)
	{	
		String no=request.getParameter("no");
		
		QnaDAO dao=QnaDAO.newInstance();
		QnaVO vo=dao.qnaDetailData(Integer.parseInt(no));
		
		//댓글 출력
		String page=request.getParameter("page");
		if(page==null) {
			page="1";
		}
		int curpage=Integer.parseInt(page);
		ReplyDAO rdao=ReplyDAO.newInstance();
		int  total=rdao.replyTotalPage();
		final int BLOCK=5;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>total)
			endPage=total;
		
		
		request.setAttribute("totalpage", total);
		request.setAttribute("curpage", curpage);
		request.setAttribute("startpage", startPage);
		request.setAttribute("endpage", endPage);
		
		List<ReplyVO> list=rdao.replyListData(Integer.parseInt(no),Integer.parseInt(page));
		
		
		int rcount=rdao.replyCount(Integer.parseInt(no));
		
		request.setAttribute("rcount", rcount);
		request.setAttribute("list", list);
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../qna/detail.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("qna/insert.do")
	public String qna_insert(HttpServletRequest request, HttpServletResponse response)
	{
			
		request.setAttribute("main_jsp", "../qna/insert.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("qna/insert_ok.do")
	public String qna_insert_ok(HttpServletRequest request, HttpServletResponse response)
	{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String secret=request.getParameter("secret");
		String name=request.getParameter("name");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		QnaVO vo=new QnaVO();
		vo.setSecret(secret);
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setId(id);
		
		QnaDAO dao=QnaDAO.newInstance();
		dao.qnaInsert(vo);
		
		
		return "redirect:../qna/list.do";
	}
	
	@RequestMapping("qna/delete.do")
	public String qna_delete(HttpServletRequest request, HttpServletResponse response)
	{
		String no=request.getParameter("no");
		
		QnaDAO dao=QnaDAO.newInstance();
		dao.qnaDelete(Integer.parseInt(no));
		return "redirect:../qna/list.do";
	}
	
	
	@RequestMapping("qna/update.do")
	public String board_update(HttpServletRequest request,HttpServletResponse response)
	{
		String no=request.getParameter("no");
		QnaDAO dao=QnaDAO.newInstance();
		QnaVO vo=dao.qnaUpdateData(Integer.parseInt(no));
		
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../qna/update.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("qna/update_ok.do")
	public String board_update_ok(HttpServletRequest request,HttpServletResponse response)
	{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String no=request.getParameter("no");
		String name=request.getParameter("name");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		
		QnaDAO dao=QnaDAO.newInstance();
		QnaVO vo=new QnaVO();
		vo.setNo(Integer.parseInt(no));
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		
		dao.qnaboardUpdate(vo);
		
		return "redirect:../qna/detail.do?no="+no;
	}
	
}
