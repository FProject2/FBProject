package com.sist.model;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.NoticeDAO;
import com.sist.vo.NoticeVO;

public class NoticeModel {
	@RequestMapping("notice/notice_list.do")
	public String notice_list(HttpServletRequest request,HttpServletResponse response)
	{
			
		request.setAttribute("main_jsp", "../notice/notice_list.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("notice/notice_catelist.do")
	public String notice_cate(HttpServletRequest request,HttpServletResponse response)
	{
		String ncno=request.getParameter("ncno");
		String page=request.getParameter("page");
		String fd=request.getParameter("fd");
		System.out.println(ncno+fd);
		if(page==null)
			page="1";
		int curpage=Integer.parseInt(page);
		NoticeDAO dao=NoticeDAO.newInstance();
		
		List<NoticeVO> list=new ArrayList<NoticeVO>();
		
		
		int total=0;
		int count=0;
		
		
		if(ncno==null && fd==null){
			list=dao.noticeListData(curpage);
			total=dao.noticeTotalPage();
			count=dao.noticeCount();
			
		}else if(ncno!=null && fd==null){
			 list=dao.noticeCateListData(curpage, Integer.parseInt(ncno));
			 total=dao.noticeCateTotalPage(Integer.parseInt(ncno));
			 count=dao.noticeCateCount(Integer.parseInt(ncno));
		}else if(ncno==null && fd !=null){
			 list=dao.noticeFindData(fd, curpage);
			 total=dao.noticeFindTotalPage(fd);
			 count=dao.noticeFindCount(fd);
		}else {
			 list=dao.noticeCateFindData(fd, curpage, Integer.parseInt(ncno));
			 total=dao.noticeCateFindTotalPage(Integer.parseInt(ncno), fd);
			 count=dao.noticeCateFindCount(fd,Integer.parseInt(ncno));
		}
		
		
		
		final int BLOCK=5;
		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>total)
			endPage=total;
		
		count=count-(10*(curpage-1));
		
		request.setAttribute("ncno", ncno);
		request.setAttribute("count", count);
		request.setAttribute("totalpage", total);
		request.setAttribute("curpage", curpage);
		request.setAttribute("list", list);
		request.setAttribute("startpage", startPage);
		request.setAttribute("endpage", endPage);
		
		return "../notice/notice_category_list.jsp";
	}
	


	
	
	@RequestMapping("notice/notice_insert.do")
	public String notice_insert(HttpServletRequest request,HttpServletResponse response)
	{
		request.setAttribute("main_jsp", "../notice/notice_insert.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("notice/insert_ok.do")
	public String notice_insert_ok(HttpServletRequest request,HttpServletResponse response)
	{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		String ncno=request.getParameter("ncno");
		String fix=request.getParameter("fix");
	
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		NoticeVO vo=new NoticeVO();
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setNcno(Integer.parseInt(ncno));
		vo.setFix(Integer.parseInt(fix));
		vo.setId(id);
		
		NoticeDAO dao=NoticeDAO.newInstance();
		dao.noticeInsert(vo);
		
		return "redirect:../notice/notice_list.do";
	}
	
	@RequestMapping("notice/notice_detail.do")
	public String notice_detail(HttpServletRequest request,HttpServletResponse response)
	{
		String nno=request.getParameter("nno");
		
		NoticeDAO dao=NoticeDAO.newInstance();
		NoticeVO vo=dao.noticeDetailData(Integer.parseInt(nno));
		
		request.setAttribute("vo", vo);
		
		request.setAttribute("main_jsp", "../notice/notice_detail.jsp");
		return "../main/home.jsp";
	}
	@RequestMapping("notice/notice_update.do")
	public String notice_update(HttpServletRequest request,HttpServletResponse response)
	{
		String nno=request.getParameter("nno");
		NoticeDAO dao=NoticeDAO.newInstance();
		NoticeVO vo=dao.noticeUpdateData(Integer.parseInt(nno));
		
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../notice/notice_update.jsp");
		return "../main/home.jsp";
	}
	@RequestMapping("notice/notice_delete.do")
	public String notice_delete(HttpServletRequest request,HttpServletResponse response)
	{
		String nno=request.getParameter("nno");
		
		NoticeDAO dao=NoticeDAO.newInstance();
		dao.noticeDelete(Integer.parseInt(nno));
		
		return "redirect:../notice/notice_list.do";
	}
	/*
	 * 	ps.setInt(1,vo.getNcno());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getImgsize());
			ps.setString(5, vo.getImgname());
			ps.setInt(6, vo.getFix());
	 */
	@RequestMapping("notice/notice_update_ok.do")
	public String notice_update_ok(HttpServletRequest request,HttpServletResponse response)
	{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String nno=request.getParameter("nno");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		String fix=request.getParameter("fix");
		String ncno=request.getParameter("ncno");
		
		NoticeVO vo=new NoticeVO();
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setNcno(Integer.parseInt(ncno));
		vo.setFix(Integer.parseInt(fix));
		vo.setNno(Integer.parseInt(nno));
		
		NoticeDAO dao=NoticeDAO.newInstance();
		dao.noticeUpdate(vo);
		
		return "redirect:../notice/notice_list.do";
		
	}
}
