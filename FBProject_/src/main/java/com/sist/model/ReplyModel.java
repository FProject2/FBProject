package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.ReplyDAO;
import com.sist.vo.ReplyVO;

public class ReplyModel {
	@RequestMapping("qna/reply_insert.do")
	public String qna_insert(HttpServletRequest request,HttpServletResponse response)
	{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String qno=request.getParameter("qno");
		String msg=request.getParameter("msg");
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		ReplyDAO dao=ReplyDAO.newInstance();
		
		ReplyVO vo=new ReplyVO();
		vo.setQno(Integer.parseInt(qno));
		vo.setId(id);
		vo.setMsg(msg);
		dao.replyInsert(vo);
		
		
		return "redirect:../qna/detail.do?no="+qno;
	}
	@RequestMapping("qna/reply_delete.do")
	public String qna_delete(HttpServletRequest request,HttpServletResponse response)
	{
		
		String qno=request.getParameter("qno");
		String rno=request.getParameter("rno");
		
		ReplyDAO dao=ReplyDAO.newInstance();
		dao.replyDelete(Integer.parseInt(rno));
		
		return "redirect:../qna/detail.do?no="+qno;
		
	}
	
	@RequestMapping("qna/reply_update.do")
	public String qna_update(HttpServletRequest request,HttpServletResponse response)
	{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String msg=request.getParameter("msg");
		String rno=request.getParameter("rno");

		request.setAttribute("msg", msg);
		request.setAttribute("rno", rno);
		
	
		return "../qna/reply_update.jsp";
	
	}
	
	@RequestMapping("qna/reply_update_ok.do")
	public void qna_update_ok(HttpServletRequest request,HttpServletResponse response)
	{
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String msg=request.getParameter("msg");
		String rno=request.getParameter("rno");

		ReplyDAO dao=ReplyDAO.newInstance();
		dao.replyUpdate(Integer.parseInt(rno),msg);
		
	
	}
	
	@RequestMapping("qna/reply_reply_insert.do")
	public String reply_reply_insert(HttpServletRequest request,HttpServletResponse response)
	{
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		String qno=request.getParameter("qno");
		String rno=request.getParameter("rno");
		String msg=request.getParameter("msg");
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		ReplyVO vo=new ReplyVO();
		vo.setQno(Integer.parseInt(qno));
		vo.setId(id);
		vo.setMsg(msg);
		
		ReplyDAO dao=ReplyDAO.newInstance();
		dao.replyReplyInsert(Integer.parseInt(rno),vo);
		
		return "redirect:../qna/detail.do?no="+qno;
	}
}
