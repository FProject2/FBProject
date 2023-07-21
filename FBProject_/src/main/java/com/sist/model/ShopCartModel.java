package com.sist.model;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sist.controller.RequestMapping;
import com.sist.dao.*;
import com.sist.vo.*;

public class ShopCartModel {
	@RequestMapping("cart/cart.do")
	public String shopCart(HttpServletRequest request, HttpServletResponse response) {
		
		// 장바구니 리스트
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ShopCartDAO dao = ShopCartDAO.newInstance();
		List<ShopCartVO> list = dao.cartListData(id);
		
		request.setAttribute("list", list);
		request.setAttribute("bCheck", true);
		request.setAttribute("main_jsp", "../shop/shopCart.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("cart/cartInsert.do")
	public String shopCartInsert(HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("Insert");
		String gno = request.getParameter("gno");
		String tprice = request.getParameter("price");
		String amount = request.getParameter("amount");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ShopCartVO vo = new ShopCartVO();
		vo.setGno(Integer.parseInt(gno));
		vo.setTprice(Integer.parseInt(tprice));
		vo.setAmount(Integer.parseInt(amount));
		vo.setId(id);
		
		ShopCartDAO dao = ShopCartDAO.newInstance();
		dao.CartInsert(vo);
		
		return "redirect:../shop/shop_detail.do?gno="+gno;
	}
	
	@RequestMapping("cart/cartOrder.do")
	public String shopCartOrder(HttpServletRequest request, HttpServletResponse response) {
		
		// 구매 상품 정보
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String gno = request.getParameter("gno");
		String tprice = request.getParameter("price");
		String amount = request.getParameter("amount");
		
		ShopCartVO vo = new ShopCartVO();
		vo.setGno(Integer.parseInt(gno));
		vo.setTprice(Integer.parseInt(tprice));
		vo.setAmount(Integer.parseInt(amount));
		vo.setId(id);
		
		ShopCartDAO dao = ShopCartDAO.newInstance();
		dao.CartInsert(vo);
		
		List<ShopCartVO> list = dao.cartListData(id);
		request.setAttribute("list", list);
		
		// 주문자 정보
		String name = (String)session.getAttribute("name");
		String post = (String)session.getAttribute("post");
		String addr1 = (String)session.getAttribute("addr1");
		String phone = (String)session.getAttribute("phone");
		
		request.setAttribute("name", name);
		request.setAttribute("post", post);
		request.setAttribute("addr1", addr1);
		request.setAttribute("phone", phone);
		
		request.setAttribute("bCheck", true);
		request.setAttribute("main_jsp", "../shop/shopOrder.jsp");
		return "../main/home.jsp";
	}
	
	@RequestMapping("cart/cartDelete.do")
	public String shopCartCancel(HttpServletRequest request, HttpServletResponse response) {
		
		String ono = request.getParameter("ono");
		ShopCartDAO dao = ShopCartDAO.newInstance();
		dao.cartDelete(Integer.parseInt(ono));
		
		return "redirect:../cart/cart.do";
	}
	
	@RequestMapping("cart/orderComplete.do")
	public String shopOrderComplete(HttpServletRequest request, HttpServletResponse response) {
		
		String ono = request.getParameter("ono");
		ShopCartDAO dao = ShopCartDAO.newInstance();
		dao.cartBuy(Integer.parseInt(ono));
		
		request.setAttribute("bCheck", true);
		request.setAttribute("main_jsp", "../shop/shopOrderComplete.jsp");
		return "../main/home.jsp";
	}
}
