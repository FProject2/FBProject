	package com.sist.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sist.common.CreateDataBase;
import com.sist.vo.QnaVO;

public class QnaDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db=new CreateDataBase();
	private static QnaDAO dao;
	
	public static QnaDAO newInstance() {
		if(dao==null)
			dao=new QnaDAO();
		return dao;
	}
	
	//기능
	//1.목록 출력 => 인라인뷰 => 페이징
	public List<QnaVO> qnaListData(int page){
		List<QnaVO> list=new ArrayList<QnaVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT no,subject,name,TO_CHAR(regdate,'yyyy-mm-dd'),hit,TO_CHAR(udate,'yyyy-mm-dd'),secret,id,num "
					 + "FROM (SELECT no,subject,name,regdate,hit,udate,secret,id,rownum as num "
					 + "FROM (SELECT /*+INDEX_DESC(qna qna_no_pk)*/no,subject,name,regdate,hit,udate,secret,id "
					 + "FROM qna)) "
					 + "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			int rowSize=10;
			int start=(rowSize*page)-(rowSize-1);
			int end=rowSize*page;
			ps.setInt(1, start);
			ps.setInt(2, end);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				QnaVO vo = new QnaVO();
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setDbday(rs.getString(4));
				vo.setHit(rs.getInt(5));
				vo.setUpdbday(rs.getString(6));
				vo.setSecret(rs.getString(7));
				vo.setId(rs.getString(8));
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
	//1-1 총페이지
	public int qnaTotalPage() {
		int total=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM qna ";
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
	
	public int qnaCount() {
		int count=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) FROM qna";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return count;
	}

	//3.글쓰기
	public void qnaInsert(QnaVO vo) {
		try {
			conn=db.getConnection();
			String sql="INSERT INTO qna (no,name,subject,content,id,secret,regdate,hit) "
					+ "VALUES("
					+ "qna_no_seq.nextval,?,?,?,?,?,SYSDATE,0)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getId());
			ps.setString(5, vo.getSecret());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	//4.상세보기
	public QnaVO qnaDetailData(int no) {
		QnaVO vo = new QnaVO();
		try {
			conn=db.getConnection();
			String sql="UPDATE qna SET "
					 + "hit=hit+1 "
					 + "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ps.executeUpdate();
			
			//실제 데이터 읽기
			sql="SELECT no,subject,name,content,TO_CHAR(regdate,'yyyy-mm-dd'),TO_CHAR(udate,'yyyy-mm-dd'),hit,id "
			  + "FROM qna "
			  + "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setSubject(rs.getString(2));
			vo.setName(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setDbday(rs.getString(5));
			vo.setUpdbday(rs.getString(6));
			vo.setHit(rs.getInt(7));
			vo.setId(rs.getString(8));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		return vo;
	}
	//5.수정=>ajax
	public QnaVO qnaUpdateData(int no) {
		QnaVO vo = new QnaVO();
		try {
			conn=db.getConnection();
			String sql="SELECT no,subject,name,content,TO_CHAR(regdate,'yyyy-mm-dd'),TO_CHAR(udate,'yyyy-mm-dd') "
			  + "FROM qna "
			  + "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNo(rs.getInt(1));
			vo.setSubject(rs.getString(2));
			vo.setName(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setDbday(rs.getString(5));
			vo.setUpdbday(rs.getString(6));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		return vo;
	}
	
	//5-1
	public void qnaboardUpdate(QnaVO vo) {
		
		try {
			conn=db.getConnection();
			
			
			String sql="UPDATE qna SET name=?,subject=?,content=?,udate=SYSDATE WHERE no=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, vo.getName());
				ps.setString(2, vo.getSubject());
				ps.setString(3, vo.getContent());
				ps.setInt(4, vo.getNo());
				ps.executeUpdate();
		
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
	}
	//6.삭제=>ajax
	public void qnaDelete(int no)
	{
		
		try {
			conn=db.getConnection();
			String sql= "SELECT COUNT(*) FROM reply WHERE qno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			rs.close();
			if(count>0)
			{
				sql="DELETE FROM reply WHERE qno=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, no);
				ps.executeUpdate();
				
			}
					
			sql="DELETE FROM qna WHERE no=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, no);
				ps.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
	}
	

	
}
