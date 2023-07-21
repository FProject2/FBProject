package com.sist.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

public class ShopModel {
	@RequestMapping("shop/shop.do")
	public String main_page(HttpServletRequest request, HttpServletResponse response)
	{
		String cno = request.getParameter("cno");
		String page = request.getParameter("page");
		
		if(cno==null)
			cno="1";
		if(page==null)
			page = "1";
		
		int curpage = Integer.parseInt(page);
		
		ShopDAO dao = ShopDAO.newInstance();
		List<ShopVO> list = dao.shopListData(Integer.parseInt(cno),curpage);
		int totalpage = dao.shopTotalPage();
		List<ShopCategoryVO> scList = dao.shopCategoryList();
		
		int BLOCK = 10;
		int startPage = ((curpage-1)/BLOCK*BLOCK)+1;
		int endPage = ((curpage-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage)
			endPage = totalpage;
		
		
		request.setAttribute("bCheck", true);
		request.setAttribute("cno", cno);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("list", list);
		request.setAttribute("scList", scList);
		request.setAttribute("main_jsp", "../shop/shop.jsp");
		return "../main/home.jsp";
	}
	
	// 상세 정보
	@RequestMapping("shop/shop_detail.do")
	public String detail_data(HttpServletRequest request, HttpServletResponse response) {
		
		String gno = request.getParameter("gno");
		String page = request.getParameter("page");
		if(page==null)
			page = "1";
		
		int curpage = Integer.parseInt(page);
		
		ShopDAO dao = ShopDAO.newInstance();
		ShopVO vo = dao.shopDetailData(Integer.parseInt(gno));
		
		List<ShopCategoryVO> scList = dao.shopCategoryList();
		List<ShopSizeVO> sList = dao.shopSizeData(Integer.parseInt(gno));
		
		request.setAttribute("bCheck", true);
		request.setAttribute("curpage", curpage);
		request.setAttribute("scList", scList);
		request.setAttribute("sList", sList);
		request.setAttribute("vo", vo);
		request.setAttribute("main_jsp", "../shop/shopDetail.jsp");
		return "../main/home.jsp";
	}
}
