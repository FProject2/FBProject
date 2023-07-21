package com.sist.dao;


import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sist.common.*;
import com.sist.vo.ReviewVO;

public class ReviewDAO {

	private Connection conn;
	private PreparedStatement ps;
	private static ReviewDAO dao;
	CreateDataBase db=new CreateDataBase();
	
	   public static ReviewDAO newInstance()
	   {
		   if(dao==null)
			   dao=new ReviewDAO();
		   return dao;
	   }
	
	   
	   /*
	    	private double score;
			private Date regdate; > 리뷰 등록 날짜
			private String content,id,rdate,dbday;
			private int rvno,gno,rno;
			private String gimage, gname, gprice; 
	    */
	   
	   // 리뷰 리스트 출력
	  public List<ReviewVO> reviewListData(int gno) {
		  
		  List<ReviewVO> list=new ArrayList<ReviewVO>();
		  
		  try {
		
			  conn=db.getConnection();
			  String sql="SELECT rvno,regdate,content,rdate,score,RPAD(SUBSTR(id, 1, 2),LENGTH(id),'*') "
			  		+ "FROM review "
			  		+ "WHERE gno=? "
			  		+ "ORDER BY regdate DESC";
			  
			  ps=conn.prepareStatement(sql);
			  ps.setInt(1, gno);
			  ResultSet rs=ps.executeQuery();
			  
			  while(rs.next()) {
			  ReviewVO vo=new ReviewVO();
			  vo.setRvno(rs.getInt(1));
			  vo.setRegdate(rs.getDate(2));
			  vo.setContent(rs.getString(3));
			  vo.setRdate(rs.getString(4));
			  vo.setScore(rs.getDouble(5));
			  vo.setId(rs.getString(6));
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
	   
	 
	
	public int reviewTotalReview (int gno) {
		
		int totalReview=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) FROM review "
					+ "WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			totalReview = rs.getInt(1);
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		return totalReview;
		
	}
	
	
	public double reviewAvg(int gno) {
		
		double totalReviewAvg = 0.0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT AVG(score) FROM review "
					+ "WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			totalReviewAvg = rs.getDouble(1);
			totalReviewAvg = Double.parseDouble(String.format("%.2f", totalReviewAvg));
			rs.close();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return totalReviewAvg;
	}
	
	
}
