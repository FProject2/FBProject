package com.sist.model;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.controller.RequestMapping;
import com.sist.vo.*;
import com.sist.dao.*;

public class MainModel {
	
	@RequestMapping("main/main.do")
	public String main_page(HttpServletRequest request, HttpServletResponse response)
	{
		FoodDAO dao=FoodDAO.newInstance();
		List<FoodVO> flist=dao.foodListData();
		request.setAttribute("flist", flist);
		
		// 메인 상품 리스트~
		ShopDAO sdao = ShopDAO.newInstance();
		List<ShopVO> sList = sdao.mainGoodsList();
		request.setAttribute("sList", sList);
		
		request.setAttribute("main_jsp", "../main/main.jsp");
		return "../main/home.jsp";
	}

}
