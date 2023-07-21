package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sist.common.CreateDataBase;
import com.sist.vo.ReplyVO;

public class ReplyDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db=new CreateDataBase();
	private static ReplyDAO dao;
	
	public static ReplyDAO newInstance()
	{
		if(dao==null)
			dao=new ReplyDAO();
		return dao;
	}
	
	public List<ReplyVO> replyListData(int qno,int page)
	{
		List<ReplyVO> list=new ArrayList<ReplyVO>();
		try {
			conn=db.getConnection();
			String sql="SELECT rno,qno,id,msg,TO_CHAR(regdate,'yyyy-MM-dd HH24:MI:SS'),group_tab,num "
					+ "FROM (SELECT rno,qno,id,msg,regdate,group_tab,rownum as num "
					+ "FROM (SELECT rno,qno,id,msg,regdate,group_tab FROM reply WHERE qno=? "
					+ "ORDER BY group_id DESC,group_step ASC)) "
					+ "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			
			int rowSize=5;
			int start=(rowSize*page)-(rowSize-1);
			int end=rowSize*page;
			ps.setInt(1, qno);
			ps.setInt(2, start);
			ps.setInt(3, end);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				ReplyVO vo=new ReplyVO();
				vo.setRno(rs.getInt(1));
				vo.setQno(rs.getInt(2));
				vo.setId(rs.getString(3));
				vo.setMsg(rs.getString(4));
				vo.setDbday(rs.getString(5));
				vo.setGroup_tab(rs.getInt(6));
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return list;
	}
	
	//총페이지
	public int replyTotalPage() {
		int total=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM reply";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return total;
	}
	
	//댓글 갯수
	public int replyCount(int qno) {
		int total=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) FROM reply WHERE qno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, qno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return total;
	}


	//수정
	public void replyUpdate(int rno, String msg)
	{
		try {
			conn=db.getConnection();
			String sql="UPDATE reply SET msg=? WHERE rno=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, msg);
			ps.setInt(2, rno);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	

	//댓글 입력
	public void replyInsert(ReplyVO vo)
	{
		try {
			conn=db.getConnection();
			String sql="INSERT INTO reply(rno,qno,id,msg,group_id) VALUES(rp_rno_seq.nextval,?,?,?,"
					+ "(SELECT NVL(MAX(group_id)+1,1) FROM reply))";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getQno());
			ps.setString(2, vo.getId());
			ps.setString(3, vo.getMsg());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	public void replyReplyInsert(int rno,ReplyVO vo)
	{
		try {
			conn=db.getConnection();
			conn.setAutoCommit(false);
			String sql="SELECT group_id,group_step,group_tab,root "
					+ "FROM reply "
					+ "WHERE rno=?";   //댓글의 글 데이터 
			ps=conn.prepareStatement(sql);
			ps.setInt(1, rno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			int gi=rs.getInt(1);
			int gs=rs.getInt(2);
			int gt=rs.getInt(3);
			int root=rs.getInt(4);
			rs.close();
			
			// group_step+1
			sql="UPDATE reply SET group_step=group_step+1 WHERE group_id=? AND group_step>?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, gi);
			ps.setInt(2, gs);
			ps.executeUpdate(); //(commit()=X)
			
			//insert
			sql="INSERT INTO reply VALUES(rp_rno_seq.nextval,?,?,?,SYSDATE,?,?,?,?,0)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getQno());
			ps.setString(2, vo.getId());
			ps.setString(3, vo.getMsg());
			ps.setInt(4, gi);
			ps.setInt(5, gs+1);
			ps.setInt(6, gt+1);
			ps.setInt(7, rno);
			ps.executeUpdate();
			
			//depth
			sql="UPDATE reply SET depth=depth+1 WHERE rno=?";  ///***수정해야됨
			ps=conn.prepareStatement(sql);
			ps.setInt(1, rno);
			ps.executeUpdate();
			
		
			
			
			
			
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {}
			e.printStackTrace();
		}finally {
			//conn의 원래 기능으로 설정
			try {
				conn.setAutoCommit(true);                   
			} catch (Exception e2) {}
			db.disConnection(conn, ps);
		}
	}
	//댓글 삭제
	public void replyDelete(int rno)
	{
		try {
			conn=db.getConnection();
			conn.setAutoCommit(false);
			
			String sql="SELECT root,depth FROM reply WHERE rno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, rno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			int root=rs.getInt(1);
			int depth=rs.getInt(2);
			rs.close();
			
			if(depth==0)
			{
				 
				sql="DELETE FROM reply WHERE rno=? or msg LIKE '%삭제된 댓글입니다.%'";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, rno);
				ps.executeUpdate();
				
			}
			else
			{
				String msg="삭제된 댓글입니다.";
				sql="UPDATE reply SET msg=? WHERE rno=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, msg);
				ps.setInt(2, rno);
				ps.executeUpdate();
				
			}
			
			//depth감소
			sql="UPDATE reply SET depth=depth-1 WHERE rno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, rno);
			ps.executeUpdate();
			
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {}
			e.printStackTrace();
		}
		finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e2) {}
			db.disConnection(conn, ps);
		}
	}
}
