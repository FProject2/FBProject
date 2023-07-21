/*
		try {
		conn = db.getConnection();
		
		String sql = "";
		ps = conn.prepareStatement(sql);
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
 */

package com.sist.dao;

import java.util.*;
import java.sql.*;
import com.sist.common.*;
import com.sist.vo.*;

public class ShopCartDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db = new CreateDataBase();
	private static ShopCartDAO dao;
	
	public static ShopCartDAO newInstance() {
		if(dao==null)
			dao = new ShopCartDAO();
		return dao;
	}
	
	public void CartInsert(ShopCartVO vo)
	{
		try {
			conn = db.getConnection();
			
			String sql = "SELECT COUNT(*) FROM shop_order WHERE gno=? AND buy_ok<>1";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, vo.getGno());
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			rs.close();
			
			if(count!=0)
			{
				sql = "UPDATE shop_order SET amount=amount+"+vo.getAmount()+" WHERE gno=? AND id=?";
				ps.setInt(1, vo.getGno());
				ps.setString(2, vo.getId());
				ps.executeUpdate();
			}
			else {
				sql = "INSERT INTO shop_order(ono, gno, id, amount, tprice) "
						+ "VALUES(od_ono_seq.nextval, ?, ?, ?, ?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, vo.getGno());
				ps.setString(2, vo.getId());
				ps.setInt(3, vo.getAmount());
				ps.setInt(4, vo.getTprice());
				ps.executeUpdate();
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	
	public List<ShopCartVO> cartListData(String id) {
		List<ShopCartVO> list = new ArrayList<ShopCartVO>();
		
		try {
			
			conn = db.getConnection();

			String sql = "SELECT ono, so.gno, goods_name, goods_image, price, amount, tprice, regdate, buy_ok, check_ok FROM shop_order so "
					+ "INNER JOIN goods "
					+ "ON so.gno = goods.gno "
					+ "WHERE so.id=? AND buy_ok<>1 "
					+ "ORDER BY ono DESC";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				ShopCartVO vo = new ShopCartVO();
				vo.setOno(rs.getInt(1));
				vo.setGno(rs.getInt(2));
				vo.setGoods_name(rs.getString(3));
				vo.setGoods_poster(rs.getString(4));
				vo.setPrice(rs.getInt(5));
				vo.setAmount(rs.getInt(6));
				vo.setTprice(rs.getInt(7));
				vo.setRegdate(rs.getDate(8));
				vo.setBuy_ok(rs.getInt(9));
				vo.setCheck_ok(rs.getInt(10));
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
	
	public void cartDelete(int ono)
	{
		try {
			conn = db.getConnection();
			
			String sql = "DELETE FROM shop_order WHERE ono=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ono);
			ps.executeUpdate();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	
	public void cartBuy(int ono)
	{
		try {
			conn = db.getConnection();
			
			String sql = "UPDATE shop_order SET buy_ok=1 WHERE ono=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ono);
			ps.executeUpdate();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
}
