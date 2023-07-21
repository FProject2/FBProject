package com.sist.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

import com.sist.common.CreateDataBase;
import com.sist.vo.MemberVO;
import com.sist.vo.QnaVO;
import com.sist.vo.ReserveVO;
import com.sist.vo.ReviewVO;
import com.sist.vo.ShopCartVO;

public class MypageDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db=new CreateDataBase();
	private static MypageDAO dao;
	
	//싱글턴
	public static MypageDAO newInstance() {
		if(dao==null)
			dao=new MypageDAO();
		return dao;
	}
	
	//비밀번호 체크
	public boolean pwdCheck(String id, String pwd) {
		boolean bCheck=false;
		
		try {
			conn=db.getConnection();
			String sql="SELECT pwd FROM member WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			rs.next();
			String db_pwd=rs.getString(1);
			rs.close();
			if(db_pwd.equals(pwd)) {
				bCheck=true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return bCheck;
	}
	//정보 업데이트
	public void infoUpdate(MemberVO vo) {
		try {
			conn=db.getConnection();
			String sql="UPDATE member SET "
					 + "name=?,nickname=?,email=?,sex=?,birth=?,phone=?,post=?,addr1=?,addr2=? "
					 + "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getNickname());
			ps.setString(3, vo.getEmail());
			ps.setString(4, vo.getSex());
			ps.setString(5, vo.getBirthday());
			ps.setString(6, vo.getPhone());
			ps.setString(7, vo.getPost());
			ps.setString(8, vo.getAddr1());
			ps.setString(9, vo.getAddr2());
			ps.setString(10, vo.getId());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
	}
	
	//회원 탈퇴
	public void memberDelete(String id) {
		try {
			conn=db.getConnection();
			conn.setAutoCommit(false);
			String sql="UPDATE reply "
					 + "SET id='탈퇴한 회원',msg='삭제된 댓글입니다.' "
					 + "WHERE id=? AND rno IN (SELECT rno "
					 + "			  		   FROM reply "
					 + "			  		   WHERE qno NOT IN (SELECT no "
					 + "										 FROM qna "
					 + "										 WHERE id=?))";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, id);
			ps.executeUpdate();
			
			sql="DELETE FROM reply WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
			
			sql="DELETE FROM qna WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
			
			sql="DELETE FROM notice WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
				
			sql="DELETE FROM shop_order WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
			
			sql="DELETE FROM review WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
			
			sql="DELETE FROM reserve WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
			
			sql="DELETE FROM member WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
			
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e2) {}
			db.disConnection(conn, ps);
		}
	}
	//-- 내 정보 --
	
	//내 게시글 리스트
	public List<QnaVO> myQnaList(String id){
		List<QnaVO> list=new ArrayList<QnaVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT no,id,name,subject,content,secret,hit,TO_CHAR(regdate,'yyyy-mm-dd'),udate "
					 + "FROM qna "
					 + "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				QnaVO vo = new QnaVO();
				vo.setNo(rs.getInt(1));
				vo.setId(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setSubject(rs.getString(4));
				vo.setContent(rs.getString(5));
				vo.setSecret(rs.getString(6));
				vo.setHit(rs.getInt(7));
				vo.setDbday(rs.getString(8));
				vo.setUpdbday(rs.getString(9));
				sql="SELECT COUNT(*) FROM reply WHERE qno=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, vo.getNo());
				ResultSet rs2=ps.executeQuery();
				rs2.next();
				vo.setrCount(rs2.getInt(1));
				rs2.close();
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	//-- 내 게시글 --
	
	//예약 페이지 리스트
	public List<ReserveVO> myReserveList(String id){
		List<ReserveVO> list=new ArrayList<ReserveVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT rno,price,rdate,rstate,id,gno,time,groundGetImage(gno),groundGetName(gno),review_ok "
					 + "FROM reserve "
					 + "WHERE id=? "
					 + "ORDER BY rdate desc";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ReserveVO vo=new ReserveVO();
				vo.setRno(rs.getInt(1));
				vo.setPrice(rs.getString(2));
				vo.setRdate(rs.getString(3));
				vo.setRstate(rs.getString(4));
				vo.setId(rs.getString(5));
				vo.setGno(rs.getInt(6));
				vo.setTime(rs.getString(7));
				String gimage=rs.getString(8);
				if(gimage.contains("^")) {
					gimage=gimage.substring(0,gimage.indexOf("^"));
				}
				vo.setGimage(gimage);
				vo.setGname(rs.getString(9));
				vo.setReview_ok(rs.getString(10));
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	
	//예약 상세 
	public ReserveVO myReserveDetail(int rno){
		ReserveVO vo=new ReserveVO();
		
		try {
			conn=db.getConnection();
			String sql="SELECT rno,price,rdate,rstate,id,gno,time,groundGetImage(gno),groundGetName(gno),"
					+ "(SELECT gaddr FROM ground_detail gd WHERE gd.gno=rs.gno) "
					 + "FROM reserve rs "
					 + "WHERE rno=? ";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, rno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setRno(rs.getInt(1));
			vo.setPrice(rs.getString(2));
			vo.setRdate(rs.getString(3));
			vo.setRstate(rs.getString(4));
			vo.setId(rs.getString(5));
			vo.setGno(rs.getInt(6));
			vo.setTime(rs.getString(7));
			String gimage=rs.getString(8);
			if(gimage.contains("^")) {
				gimage=gimage.substring(0,gimage.indexOf("^"));
			}
			vo.setGimage(gimage);
			vo.setGname(rs.getString(9));
			vo.setGaddr(rs.getString(10));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return vo;
	}
	
	//리뷰 업로드
	public void reviewInsert(ReviewVO vo) {
		try {
			conn=db.getConnection();
			conn.setAutoCommit(false);
			String sql="INSERT INTO review VALUES("
					 + "rv_rvno_seq.nextval,?,SYSDATE,?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getContent());
			ps.setString(2, vo.getRdate());
			ps.setDouble(3, vo.getScore());
			ps.setString(4, vo.getId());
			ps.setInt(5, vo.getGno());
			ps.setInt(6, vo.getRno());
			ps.executeUpdate();
			
			sql = "UPDATE reserve SET review_ok='y' WHERE rno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getRno());
			ps.executeUpdate();
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {}
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e2) {}
			db.disConnection(conn, ps);
		}
	}
	//-- 예약 페이지 --
	
	//리뷰 페이지 리스트
	public List<ReviewVO> reviewListData(String id){
		List<ReviewVO> list=new ArrayList<ReviewVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT groundGetImage(gno), groundGetName(gno), content, score, regdate, rvno "
					 + "FROM review "
					 + "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ReviewVO vo=new ReviewVO();
				String image=rs.getString(1);
				if(image.contains("^")) {
					image=image.substring(0,image.indexOf("^"));
				}
				vo.setGimage(image);
				vo.setGname(rs.getString(2));
				String content=rs.getString(3);
				if(content.length()>25) {
					content=content.substring(0,23)+"...";
				}
				vo.setContent(content);
				vo.setScore(rs.getDouble(4));
				SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
				String date = format.format(rs.getDate(5));
				vo.setDbday(date);
				vo.setRvno(rs.getInt(6));
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	
	//리뷰 상세
	public ReviewVO reviewDetailData(int rvno) {
		ReviewVO vo=new ReviewVO();
		
		try {
			conn=db.getConnection();
			String sql="SELECT rvno,groundGetImage(gno),groundGetName(gno),score,rdate,regdate,content,"
					 + "(SELECT gprice FROM ground_detail gd WHERE gd.gno=review.gno) "
					 + "FROM review "
					 + "WHERE rvno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, rvno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setRvno(rs.getInt(1));
			String image=rs.getString(2);
			if(image.contains("^")) {
				image=image.substring(0,image.indexOf("^"));
			}
			vo.setGimage(image);
			vo.setGname(rs.getString(3));
			vo.setScore(rs.getDouble(4));
			vo.setRdate(rs.getString(5));
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			String date = format.format(rs.getDate(6));
			vo.setDbday(date);
			vo.setContent(rs.getString(7));
			vo.setGprice(rs.getString(8));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return vo;
	}
	
	//-- 리뷰 페이지 --
	
	//주문 내역 리스트
	public List<ShopCartVO> orderListData(String id){
		List<ShopCartVO> list=new ArrayList<ShopCartVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT ono,gno,id,amount,tprice,buy_ok,check_ok,regdate,goodsGetImage(gno),goodsGetName(gno) "
					 + "FROM shop_order "
					 + "WHERE id=? AND buy_ok=1 "
					 + "ORDER BY regdate DESC";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ShopCartVO vo=new ShopCartVO();
				vo.setOno(rs.getInt(1));
				vo.setGno(rs.getInt(2));
				vo.setId(rs.getString(3));
				vo.setAmount(rs.getInt(4));
				vo.setTprice(rs.getInt(5));
				vo.setBuy_ok(rs.getInt(6));
				vo.setCheck_ok(rs.getInt(7));
				vo.setRegdate(rs.getDate(8));
				vo.setGoods_poster(rs.getString(9));
				vo.setGoods_name(rs.getString(10));
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
}
