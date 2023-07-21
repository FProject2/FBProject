package com.sist.dao;

import java.util.*;
import java.sql.*;
import java.text.DecimalFormat;

import com.sist.vo.*;
import com.sist.common.*;

public class ShopDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db = new CreateDataBase();
	private static ShopDAO dao;
	
	public static ShopDAO newInstance() {
		if(dao==null)
			dao = new ShopDAO();
		return dao;
	}
	
	// 메인 페이지 출력용 상품 리스트
	public List<ShopVO> mainGoodsList() {
		List<ShopVO> list = new ArrayList<ShopVO>();
		
		try {
			conn = db.getConnection();
			
			String sql = "SELECT gno, goods_name, goods_image, brand "
					+ "FROM goods WHERE gno IN('633','1232','3800','649','1194','910','51','83','729','1077','2543','1373')";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ShopVO vo = new ShopVO();
				vo.setGno(rs.getInt(1));
				vo.setGoods_name(rs.getString(2));
				vo.setGoods_image(rs.getString(3));
				vo.setBrand(rs.getString(4));
				list.add(vo);
			}
			rs.close();
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	
	public List<ShopCategoryVO> shopCategoryList(){
		List<ShopCategoryVO> list = new ArrayList<ShopCategoryVO>();
		
		try {
			conn = db.getConnection();
			
			String sql = "SELECT cno, category_name FROM category";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				ShopCategoryVO vo = new ShopCategoryVO();
				
				vo.setCno(rs.getInt(1));
				vo.setCategory_name(rs.getString(2));
				
				list.add(vo);
			}
			rs.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	
	//전체 물품 리스트
	public List<ShopVO> shopListData(int cno, int page){
		List<ShopVO> list = new ArrayList<ShopVO>();
		
		try {
			conn = db.getConnection();
			// cprice : 소비자가(원가), price : 판매가
			String sql = "SELECT gno, goods_name, goods_image, brand, TO_CHAR(cprice, '999,999'), TO_CHAR(price, '999,999'), cno, num "
					+ "FROM (SELECT gno, goods_name, goods_image, brand, cprice, price, cno, rownum AS num "
					+ "FROM (SELECT /*+ INDEX_ASX(gs_gno_pk)*/gno, goods_name, goods_image, brand, cprice, price, cno "
					+ "FROM goods WHERE cno=?)) WHERE num BETWEEN ? AND ?";
			ps = conn.prepareStatement(sql);
			
			int rowSize = 12;
			int start = (rowSize*page)-(rowSize-1);
			int end = rowSize*page;
			
			ps.setInt(1, cno);
			ps.setInt(2, start);
			ps.setInt(3, end);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				ShopVO vo = new ShopVO();
				
				vo.setGno(rs.getInt(1));
				vo.setGoods_name(rs.getString(2));
				vo.setGoods_image(rs.getString(3));
				vo.setBrand(rs.getString(4));
				vo.setDbcprice(rs.getString(5));
				vo.setDbprice(rs.getString(6));
				vo.setCno(rs.getInt(7));
				list.add(vo);
			}
			rs.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		
		return list;
	}
	
	// 총페이지
	public int shopTotalPage() {
		int total = 0;
		
		try {
			conn = db.getConnection();
			
			String sql = "SELECT CEIL(COUNT(*)/12.0) FROM goods";
			ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			total = rs.getInt(1);
			rs.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		
		return total;
	}
	
	// 상세 정보
	public ShopVO shopDetailData(int gno) {
		ShopVO vo = new ShopVO();
		
		try {
			conn = db.getConnection();
			
			String sql = "SELECT gno, goods_name, goods_image, goods_detail_image, brand, origin, TO_CHAR(cprice,'999,999'), TO_CHAR(price,'999,999'), price "
					+ "FROM goods WHERE gno=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			vo.setGno(rs.getInt(1));
			vo.setGoods_name(rs.getString(2));
			vo.setGoods_image(rs.getString(3));
			vo.setGoods_detail(rs.getString(4));
			vo.setBrand(rs.getString(5));
			vo.setOrigin(rs.getString(6));
			vo.setDbcprice(rs.getString(7));
			vo.setDbprice(rs.getString(8));
			vo.setPrice(rs.getInt(9));
			rs.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		return vo;
	}
	
	// 사이즈
	public List<ShopSizeVO> shopSizeData(int gno){
		List<ShopSizeVO> list = new ArrayList<ShopSizeVO>();
		
		try {
			conn = db.getConnection();
			
			String sql = "SELECT sno, gsize, gno, stock FROM sizetable WHERE gno=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				ShopSizeVO vo = new ShopSizeVO();
				vo.setSno(rs.getInt(1));
				vo.setGsize(rs.getString(2));
				vo.setGno(rs.getInt(3));
				vo.setStock(rs.getInt(4));
				list.add(vo);
			}
			
			rs.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
			
		}
		
		return list;
	}
	
	
	
}
