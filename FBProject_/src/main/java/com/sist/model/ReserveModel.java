package com.sist.model;

import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

public class ReserveModel {

	
	@RequestMapping("reserve/reserve.do")
	public String reserveDetail(HttpServletRequest request, HttpServletResponse response) {
	
		ReserveDAO dao=ReserveDAO.newInstance();
		
		String gno=request.getParameter("gno");

		GroundDetailVO gvo=dao.groundDetailData(Integer.parseInt(gno));
		request.setAttribute("gvo", gvo);
		request.setAttribute("gno", gno);
		
		HttpSession session=request.getSession();
		String id=(String)session.getAttribute("id");
		
		// 리뷰 출력
		ReviewDAO rdao=ReviewDAO.newInstance();
		double totalReviewAvg=rdao.reviewAvg(Integer.parseInt(gno));
		int totalReview=rdao.reviewTotalReview(Integer.parseInt(gno));
		List<ReviewVO> grList=rdao.reviewListData(Integer.parseInt(gno));
		
		request.setAttribute("totalReviewAvg", totalReviewAvg);
		request.setAttribute("totalReview", totalReview);
		request.setAttribute("grList", grList);
		
		request.setAttribute("main_jsp", "../reserve/reserve.jsp");
		return "../main/home.jsp";
	}

	
	  @RequestMapping("reserve/reserve_list.do")
	  public String reserve_list(HttpServletRequest request, HttpServletResponse response) {

		  try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}
		  
			ReserveDAO dao=ReserveDAO.newInstance();
		
		    String area = request.getParameter("area");
			if(area==null) {
				area="서울";
			}
			String search=request.getParameter("search");
			if(search==null) {
				search="";
			}
			List<GroundDetailVO> list = dao.groundCategoryListData(area, search);
			
			request.setAttribute("area", area);
			request.setAttribute("search", search);
			request.setAttribute("list", list);
		  
		  return "../reserve/reserve_list.jsp";
	  }
	
	  @RequestMapping("reserve/reserve_insert.do")
	  public String reserve_insert(HttpServletRequest request,HttpServletResponse response) {
		 try {
			 request.setCharacterEncoding("UTF-8");
		 } catch(Exception ex) {}
		 
		 String price=request.getParameter("price");
		 String gno=request.getParameter("gno");
		 String time=request.getParameter("time");
		 String rday=request.getParameter("rday");
		 
		 ReserveVO vo=new ReserveVO();
		 vo.setPrice(price);
		 vo.setGno(Integer.parseInt(gno));
		 vo.setTime(time);
		 vo.setRdate(rday);
		 
		 HttpSession session=request.getSession();
		 String id=(String)session.getAttribute("id");
		 vo.setId(id);
		 
		 ReserveDAO dao=ReserveDAO.newInstance();
		 dao.reserveInsert(vo);
		 
		 return "redirect:../main/main.do";

	  }
	  
	  
	  
	  
}