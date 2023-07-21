package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sist.common.CreateDataBase;
import com.sist.vo.FoodVO;

public class FoodDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db=new CreateDataBase();
	private static FoodDAO dao;
	
	//싱글턴
	public static FoodDAO newInstance() {
		if(dao==null)
			dao=new FoodDAO();
		return dao;
	}
	
	public List<FoodVO> foodListData(){
		List<FoodVO> list = new ArrayList<FoodVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT fno,name,poster,address,rownum num "
					 + "FROM food_house "
					 + "WHERE rownum <= 12";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				FoodVO vo = new FoodVO();
				vo.setFno(rs.getInt(1));
				vo.setName(rs.getString(2));
				String poster=rs.getString(3);
				poster=poster.substring(0,poster.indexOf("^"));
				poster=poster.replace("#", "&");
				vo.setPoster(poster.trim());
				String address=rs.getString(4);
				address=address.substring(0,address.indexOf("지번")-1);
				vo.setAddress(address.trim());
				list.add(vo);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		return list;
	}
}
