package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.sql.RowSetInternal;

import com.sist.common.CreateDataBase;
import com.sist.vo.*;

public class AdminDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db=new CreateDataBase();
	private static AdminDAO dao;
	
	//싱글턴
	public static AdminDAO newInstance() {
		if(dao==null)
			dao=new AdminDAO();
		return dao;
	}
	//////////////////////////////////////////////////
	//회원 리스트 검색
	public List<MemberVO> memberListData(){
		List<MemberVO> list = new ArrayList<MemberVO>();
		
		try {
			conn=db.getConnection();
			String sql = "SELECT id,pwd,email,name,nickname,sex,birth,phone,post,addr1,addr2,signdate,admin "
					   + "FROM member ";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				MemberVO vo=new MemberVO();
				vo.setId(rs.getString(1));
				vo.setPwd(rs.getString(2));
				vo.setEmail(rs.getString(3));
				vo.setName(rs.getString(4));
				vo.setNickname(rs.getString(5));
				vo.setSex(rs.getString(6));
				vo.setBirthday(rs.getString(7));
				vo.setPhone(rs.getString(8));
				vo.setPost(rs.getString(9));
				vo.setAddr1(rs.getString(10));
				vo.setAddr2(rs.getString(11));
				String date=rs.getString(12);
				date=date.substring(0,date.indexOf(" "));
				vo.setSigndate(date);
				vo.setAdmin(rs.getString(13));
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
	//회원 정보 검색
	public MemberVO memberDetailData(String id){
		MemberVO vo = new MemberVO();
		
		try {
			conn=db.getConnection();
			String sql = "SELECT id,pwd,email,name,nickname,sex,birth,phone,post,addr1,addr2,signdate,admin "
					   + "FROM member "
					   + "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setId(rs.getString(1));
			vo.setPwd(rs.getString(2));
			vo.setEmail(rs.getString(3));
			vo.setName(rs.getString(4));
			vo.setNickname(rs.getString(5));
			vo.setSex(rs.getString(6));
			vo.setBirthday(rs.getString(7));
			vo.setPhone(rs.getString(8));
			vo.setPost(rs.getString(9));
			vo.setAddr1(rs.getString(10));
			vo.setAddr2(rs.getString(11));
			String date=rs.getString(12);
			date=date.substring(0,date.indexOf(" "));
			vo.setSigndate(date);
			vo.setAdmin(rs.getString(13));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return vo;
	}
	
	// 회원 수정
	public void memberUpdate(MemberVO vo) {
		try {
			conn=db.getConnection();
			String sql="UPDATE member SET "
					+ "email=?,name=?,nickname=?,sex=?,birth=?,phone=?,post=?,addr1=?,addr2=?,admin=? "
					+ "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getEmail());
			ps.setString(2, vo.getName());
			ps.setString(3, vo.getNickname());
			ps.setString(4, vo.getSex());
			ps.setString(5, vo.getBirthday());
			ps.setString(6, vo.getPhone());
			ps.setString(7, vo.getPost());
			ps.setString(8, vo.getAddr1());
			ps.setString(9, vo.getAddr2());
			ps.setString(10, vo.getAdmin());
			ps.setString(11, vo.getId());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	
	////////////////////////////////////////////////
	//물품 리스트 
	public List<ShopVO> goodsListData(int page, String search){
		List<ShopVO> list = new ArrayList<ShopVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT gno,cno,goods_name,goods_image,goods_detail_image,brand,origin,cprice,price,num "
					 + "FROM (SELECT gno,cno,goods_name,goods_image,goods_detail_image,brand,origin,cprice,price,rownum as num "
					 + "	  FROM (SELECT /*+INDEX_ASC (goods gs_gno_pk)*/gno,cno,goods_name,goods_image,goods_detail_image,brand,origin,cprice,price "
					 + "			FROM goods WHERE goods_name LIKE '%'||?||'%')) "
					 + "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			
			int rowSize=8;
			int start=(rowSize*page)-(rowSize-1);
			int end=rowSize*page;
			
			ps.setString(1, search);
			ps.setInt(2, start);
			ps.setInt(3, end);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ShopVO vo=new ShopVO();
				vo.setGno(rs.getInt(1));
				vo.setCno(rs.getInt(2));
				vo.setGoods_name(rs.getString(3));
				vo.setGoods_image(rs.getString(4));
				vo.setGoods_detail(rs.getString(5));
				vo.setBrand(rs.getString(6));
				vo.setOrigin(rs.getString(7));
				vo.setCprice(rs.getInt(8));
				vo.setPrice(rs.getInt(9));
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
	
	//물품 총페이지
	public int goodsTotalPage(String search) {
		int totalpage=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/8.0) FROM goods WHERE goods_name LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, search);
			ResultSet rs=ps.executeQuery();
			rs.next();
			totalpage=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return totalpage;
	}
	
	//물품 상세 
	public ShopVO goodsDetailData(int gno) {
		ShopVO vo=new ShopVO();
		
		try {
			conn=db.getConnection();
			String sql="SELECT gno,cno,goods_name,goods_image,goods_detail_image,brand,origin,cprice,price "
					 + "FROM goods "
					 + "WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setGno(rs.getInt(1));
			vo.setCno(rs.getInt(2));
			vo.setGoods_name(rs.getString(3));
			vo.setGoods_image(rs.getString(4));
			vo.setGoods_detail(rs.getString(5));
			vo.setBrand(rs.getString(6));
			vo.setOrigin(rs.getString(7));
			vo.setCprice(rs.getInt(8));
			vo.setPrice(rs.getInt(9));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return vo;
	}
	//물품 상세-사이즈
	public List<sizeVO> goodsSizeData(int gno){
		List<sizeVO> list=new ArrayList<sizeVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT gsize,stock "
					 + "FROM sizetable "
					 + "WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				sizeVO vo=new sizeVO();
				vo.setGsize(rs.getString(1));
				vo.setStock(rs.getInt(2));
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
	
	//물품 수정
	public void goodsUpdate(ShopVO vo, List<sizeVO> slist) {
		try {
			conn=db.getConnection();
			conn.setAutoCommit(false);
			String sql="UPDATE goods SET "
					 + "goods_name=?,brand=?,origin=?,cprice=?,price=? "
					 + "WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getGoods_name());
			ps.setString(2, vo.getBrand());
			ps.setString(3, vo.getOrigin());
			ps.setInt(4, vo.getCprice());
			ps.setInt(5, vo.getPrice());
			ps.setInt(6, vo.getGno());
			ps.executeUpdate();

			sql="DELETE FROM sizetable WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getGno());
			ps.executeUpdate();
			
			for(sizeVO svo:slist) {
				sql="INSERT INTO sizetable VALUES("
			      + "size_sno_seq.nextval,?,?,?)";
				ps=conn.prepareStatement(sql);
				ps.setString(1, svo.getGsize());
				ps.setInt(2, svo.getStock());
				ps.setInt(3, vo.getGno());
				ps.executeUpdate();
			}
			
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {}
			e.printStackTrace();
		} finally {
			try {
			   conn.setAutoCommit(true);
			} catch(Exception ex) {}
			db.disConnection(conn, ps);
		}
	}
	//물품 삭제
	public void goodsDelete(int gno) {
		try {
			conn=db.getConnection();
			conn.setAutoCommit(false);
			String sql="DELETE FROM shop_order WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ps.executeUpdate();
			
			sql="DELETE FROM sizetable WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ps.executeUpdate();
			
			sql="DELETE FROM goods WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
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
	//////////////////////////////////
	
	//구장 리스트
	public List<GroundDetailVO> groundListData(int page, String search){
		List<GroundDetailVO> list = new ArrayList<GroundDetailVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT gno,gname,gaddr,gimage,gnotice,gprice,football_reserve_day,num "
					 + "FROM (SELECT gno,gname,gaddr,gimage,gnotice,gprice,football_reserve_day,rownum as num "
					 + "	  FROM (SELECT /*+INDEX_ASC(ground_detail gd_gno_pk)*/gno,gname,gaddr,gimage,gnotice,gprice,football_reserve_day "
					 + "	  		FROM ground_detail WHERE gname LIKE '%'||?||'%')) "
					 + "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			int rowsize=10;
			int start=rowsize*(page-1)+1;
			int end=rowsize*page;
			ps.setString(1, search);
			ps.setInt(2, start);
			ps.setInt(3, end);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				GroundDetailVO vo= new GroundDetailVO();
				vo.setGno(rs.getInt(1));
				vo.setGname(rs.getString(2));
				vo.setGaddr(rs.getString(3));
				String image=rs.getString(4);
				if(image.contains("^")) {
					image=image.substring(0,image.indexOf("^"));
				}
				vo.setGimage(image);
				vo.setGnotice(rs.getString(5));
				vo.setGprice(rs.getString(6));
				vo.setFootball_reserve_day(rs.getString(7));
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	//구장 총페이지
	public int groundTotalPage(String search) {
		int totalpage=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM ground_detail WHERE gname LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, search);
			ResultSet rs=ps.executeQuery();
			rs.next();
			totalpage=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return totalpage;
	}
	//구장 상세
	public GroundDetailVO groundDetailData(int gno) {
		GroundDetailVO vo=new GroundDetailVO();
		
		try {
			conn=db.getConnection();
			String sql="SELECT gno,gname,gaddr,gimage,gnotice,gprice,football_reserve_day "
					 + "FROM ground_detail "
					 + "WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setGno(rs.getInt(1));
			vo.setGname(rs.getString(2));
			vo.setGaddr(rs.getString(3));
			String image=rs.getString(4);
			if(image.contains("^")) {
				image=image.substring(0,image.indexOf("^"));
			}
			vo.setGimage(image);
			vo.setGnotice(rs.getString(5));
			vo.setGprice(rs.getString(6));
			vo.setFootball_reserve_day(rs.getString(7));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return vo;
	}
	//구장 수정
	public void groundUpdate(GroundDetailVO vo) {
		try {
			conn=db.getConnection();
			String sql="UPDATE ground_detail SET "
					 + "gname=?,gaddr=?,gprice=?,gnotice=? "
					 + "WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getGname());
			ps.setString(2, vo.getGaddr());
			ps.setString(3, vo.getGprice());
			ps.setString(4, vo.getGnotice());
			ps.setInt(5, vo.getGno());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
	}
	//구장 삭제
	public void groundDelete(int gno) {
		try {
			conn=db.getConnection();
			conn.setAutoCommit(false);
			String sql="DELETE FROM review WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ps.executeUpdate();
			
			sql="DELETE FROM reserve WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
			ps.executeUpdate();
			
			sql="DELETE FROM ground_detail WHERE gno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gno);
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
	///////////////////////////////////
	
	//문의하기 리스트 출력
	public List<QnaVO> qnaListData(int page, String search){
		List<QnaVO> list = new ArrayList<QnaVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT no,id,name,subject,content,secret,hit,TO_CHAR(regdate,'yyyy-mm-dd'),udate,num "
					 + "FROM (SELECT no,id,name,subject,content,secret,hit,regdate,udate,rownum as num "
					 + "	   FROM (SELECT no,id,name,subject,content,secret,hit,regdate,udate "
					 + "			 FROM qna "
					 + "			 WHERE subject LIKE '%'||?||'%' "
					 + "			 ORDER BY regdate DESC)) "
					 + "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, search);
			int rowSize=10;
			int start=(page-1)*rowSize+1;
			int end=page*rowSize;
			ps.setInt(2, start);
			ps.setInt(3, end);
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
	//문의하기 총페이지
	public int qnaTotalPage(String search) {
		int totalpage=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM qna WHERE subject LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, search);
			ResultSet rs=ps.executeQuery();
			rs.next();
			totalpage=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return totalpage;
	}
	//문의하기 답변
	public void replyInsert(ReplyVO vo) {
		try {
			conn=db.getConnection();
			String sql="INSERT INTO reply(rno,qno,id,msg,group_id) VALUES("
					 + "rp_rno_seq.nextval, ?,?,?,(SELECT NVL(MAX(group_id)+1,1) FROM reply))";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getQno());
			ps.setString(2, vo.getId());
			ps.setString(3, vo.getMsg());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
	}
	
	//공지사항 리스트
	public List<NoticeVO> noticeListData(){
		List<NoticeVO> list=new ArrayList<NoticeVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT nno,id,ncno,subject,content,hit,regdate,fix "
					 + "FROM notice "
					 + "ORDER BY regdate DESC";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				NoticeVO vo=new NoticeVO();
				vo.setNno(rs.getInt(1));
				vo.setId(rs.getString(2));
				vo.setNcno(rs.getInt(3));
				vo.setSubject(rs.getString(4));
				String content=rs.getString(5);
				if(content.length()>15) {
					content=content.substring(0,13)+"...";
				}
				vo.setContent(content);
				vo.setHit(rs.getInt(6));
				vo.setRegdate(rs.getDate(7));
				vo.setFix(rs.getInt(8));
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
	
	public void fixUpdate(int fix, int nno) {
		try {
			conn=db.getConnection();
			String sql="UPDATE notice SET fix=? WHERE nno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, fix);
			ps.setInt(2, nno);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
	}
	
	public void noticeDelete(int nno) {
		try {
			conn=db.getConnection();
			String sql="DELETE FROM notice WHERE nno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, nno);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
	}
	
	////////////////////////////////////////////////
	
	//예약 리스트
	public List<ReserveVO> reserveListData(){
		List<ReserveVO> list=new ArrayList<ReserveVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT rno,price,rdate,rstate,id,gno,time,"
					 + "groundGetImage(gno),"
					 + "groundGetName(gno),"
					 + "(SELECT name FROM member WHERE rs.id=member.id) "
					 + "FROM reserve rs "
					 + "ORDER BY rdate DESC";
			ps=conn.prepareStatement(sql);
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
				vo.setName(rs.getString(10));
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	
	//예약 상태 변경
	public void reserveStateUpdate(String rstate,int rno) {
		try {
			conn=db.getConnection();
			String sql="UPDATE reserve SET rstate=? WHERE rno=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, rstate);
			ps.setInt(2, rno);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
	}
	
	//////////////////////
	//주문 리스트
	public List<ShopCartVO> orderListData(){
		List<ShopCartVO> list=new ArrayList<ShopCartVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT ono,gno,id,amount,tprice,buy_ok,check_ok,regdate,goodsGetImage(gno),goodsGetName(gno),"
					+ "(SELECT name FROM member WHERE member.id=so.id) "
					 + "FROM shop_order so "
					 + "WHERE buy_ok=1 "
					 + "ORDER BY regdate DESC";
			ps=conn.prepareStatement(sql);
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
				vo.setMember_name(rs.getString(11));
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
	
	//주문 상태 변경
	public void buyOkChange(int ono, int check_ok) {
		try {
			conn=db.getConnection();
			String sql="UPDATE shop_order SET check_ok=? WHERE ono=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, check_ok);
			ps.setInt(2, ono);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
	}
}
