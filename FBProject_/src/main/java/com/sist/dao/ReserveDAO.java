package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.GZIPOutputStream;

import com.sist.common.CreateDataBase;
import com.sist.vo.*;


public class ReserveDAO {
	
	   private Connection conn;
	   private PreparedStatement ps;
	   private CreateDataBase db=new CreateDataBase();
	   private static ReserveDAO dao;
	   
	   // 싱글턴 
	   public static ReserveDAO newInstance()
	   {
		   if(dao==null)
			   dao=new ReserveDAO();
		   return dao;
	   }

	   
	   // 구장 읽기
	   public List<GroundDetailVO> groundCategoryListData(String area, String search) {
		   
		   List<GroundDetailVO> list=new ArrayList<GroundDetailVO>();
		   
		   try {
	
			   conn=db.getConnection();
			   String sql="SELECT gname,gaddr,gno FROM ground_detail "
			   		+ "WHERE gaddr LIKE '%'||?||'%' AND gname LIKE '%'||?||'%'";
			   ps=conn.prepareStatement(sql);
			   ps.setString(1, area);
			   ps.setString(2, search);
			   ResultSet rs=ps.executeQuery();
			   
			   while(rs.next()) {
				
				   GroundDetailVO vo=new GroundDetailVO();
				   vo.setGname(rs.getString(1));
				   vo.setGaddr(rs.getString(2));
				   vo.setGno(rs.getInt(3));				   
				   list.add(vo);

			   }
			   rs.close();
			   
		   } catch(Exception ex) {
			   ex.printStackTrace();
		   } finally {
			   db.disConnection(conn, ps);
		   }
		   
		   return list;
	   }
	   
	   // 구장 예약 상세 페이지
	   public GroundDetailVO groundDetailData(int gno) {
		   
		   GroundDetailVO vo=new GroundDetailVO();
		   try {
	
			   conn=db.getConnection();
			   String sql="SELECT * FROM ground_detail "
			   		+ "WHERE gno=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, gno);
			   
			   ResultSet rs=ps.executeQuery();
			   rs.next();

			   vo.setGno(rs.getInt(1));
			   vo.setGname(rs.getString(2));
			   vo.setGaddr(rs.getString(3));
			  
			   String poster=rs.getString(4);
			   if(poster.contains("^")) {
				   poster=poster.substring(0,poster.indexOf("^"));
			   }
			   vo.setGimage(poster);
			   
			   vo.setGnotice(rs.getString(5));
			   vo.setGprice(rs.getString(6));
			   vo.setFootball_reserve_day(rs.getString(7));
				
			   rs.close();
			   
		   } catch(Exception ex) {
			   ex.printStackTrace();
		   } finally {
			   db.disConnection(conn, ps);
		   }
		   
		   return vo;
	   }
	   
	   // 예약 등록
	   public void reserveInsert(ReserveVO vo) {
		   try {
			   conn=db.getConnection();
			   String sql="INSERT INTO reserve(rno,price,rdate,id,gno,time) "
			   		+ "VALUES(rs_rno_seq.nextval,?,?,?,?,?)";
			   
			   ps=conn.prepareStatement(sql);
			   ps.setString(1, vo.getPrice());
			   ps.setString(2, vo.getRdate());
			   ps.setString(3, vo.getId());
			   ps.setInt(4, vo.getGno());
			   ps.setString(5, vo.getTime());
			   ps.executeUpdate();
			   
		   } catch(Exception ex) {
			   ex.printStackTrace();
		   } finally {
			   db.disConnection(conn, ps);
		   }
	   }
	      
	   // 구장 예약 스케줄
	   public String groundReserveDay(int gno)
	   {
		   String result="";
		   try
		   {
			   conn=db.getConnection();
			   String sql="SELECT football_reserve_day FROM ground_detail "
					     +"WHERE gno=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, gno);
			   ResultSet rs=ps.executeQuery();
			   rs.next();
			   result=rs.getString(1);
			   rs.close();
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
		   }
		   finally
		   {
			   db.disConnection(conn, ps);
		   }
		   return result;
	   }
	   
	   public String reserve_day_time(int tno)
	   {
		   String result="";
		   try
		   {
			   conn=db.getConnection();
			   String sql="SELECT time FROM football_reserve_day "
					     +"WHERE rno=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, tno);
			   ResultSet rs=ps.executeQuery();
			   rs.next();
			   result=rs.getString(1);
			   rs.close();
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
		   }
		   finally
		   {
			   db.disConnection(conn, ps);
		   }
		   return result;
	   }
	   public String reserve_get_time(int tno)
	   {
		   String result="";
		   try
		   {
			   conn=db.getConnection();
			   String sql="SELECT time FROM football_reserve_time "
					     +"WHERE tno=?";
			   ps=conn.prepareStatement(sql);
			   ps.setInt(1, tno);
			   ResultSet rs=ps.executeQuery();
			   rs.next();
			   result=rs.getString(1);
			   rs.close();
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
		   }
		   finally
		   {
			   db.disConnection(conn, ps);
		   }
		   return result;
	   }
	   
}


