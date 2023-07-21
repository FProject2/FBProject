package com.sist.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.sist.common.CreateDataBase;
import com.sist.vo.NoticeVO;

public class NoticeDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db=new CreateDataBase();
	private static NoticeDAO dao;
	
	public static NoticeDAO newInstance()
	{
		if(dao==null)
			dao=new NoticeDAO();
		return dao;
	}
	
	//리스트 ----------------------------------------------------------------------------------------------
	public List<NoticeVO> noticeListData(int page)
	{
		List<NoticeVO> list=new ArrayList<NoticeVO>();
		try {
			conn=db.getConnection();
			String sql="SELECT nno,subject,id,ncno,TO_CHAR(regdate,'YYYY-MM-DD'),hit,fix,num "
					+ "FROM (SELECT nno,subject,id,ncno,regdate,hit,fix,rownum as num "
					+ "FROM (SELECT nno,subject,id,ncno,regdate,hit,fix FROM notice ORDER BY fix DESC,nno DESC)) "
					+ "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			int rowsize=10;
			int start=(rowsize*page)-(rowsize-1);
			int end=rowsize*page;
			
			ps.setInt(1, start);
			ps.setInt(2, end);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				NoticeVO vo=new NoticeVO();
				vo.setNno(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setId(rs.getString(3));
				vo.setNcno(rs.getInt(4));
				vo.setDbday(rs.getString(5));
				vo.setHit(rs.getInt(6));
				vo.setFix(rs.getInt(7));
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
	
	public List<NoticeVO> noticeCateListData(int page,int ncno)
	{
		List<NoticeVO> list=new ArrayList<NoticeVO>();
		try {
			conn=db.getConnection();
			String sql="SELECT nno,subject,id,ncno,TO_CHAR(regdate,'YYYY-MM-DD'),hit,fix,num "
					+ "FROM (SELECT nno,subject,id,ncno,regdate,hit,fix,rownum as num "
					+ "FROM (SELECT nno,subject,id,ncno,regdate,hit,fix FROM notice WHERE ncno=? ORDER BY fix DESC,nno DESC)) "
					+ "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			int rowsize=10;
			int start=(rowsize*page)-(rowsize-1);
			int end=rowsize*page;
			
			ps.setInt(1, ncno);
			ps.setInt(2, start);
			ps.setInt(3, end);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				NoticeVO vo=new NoticeVO();
				vo.setNno(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setId(rs.getString(3));
				vo.setNcno(rs.getInt(4));
				vo.setDbday(rs.getString(5));
				vo.setHit(rs.getInt(6));
				vo.setFix(rs.getInt(7));
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
	//---------------------------------------------------------------------------------------------------------------------
	
	//총페이지 
	
	public int noticeTotalPage()
	{
		int total=0;
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM notice";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return total;
	}
	
	public int noticeCateTotalPage(int ncno)
	{
		int total=0;
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM notice WHERE ncno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ncno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return total;
	}
	
	public int noticeFindTotalPage(String fd)
	{
		int total=0;
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM notice WHERE subject LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, fd);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return total;
	}
	
	public int noticeCateFindTotalPage(int ncno,String fd)
	{
		int total=0;
		try {
			conn=db.getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM notice WHERE ncno=? and subject LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ncno);
			ps.setString(2, fd);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return total;
	}
	
	//게시글 갯수 -------------------------------------------------------------------------------------------------------
	
	public int noticeCount()
	{
		int total=0;
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) FROM notice";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return total;
	}
	
	public int noticeFindCount(String fd)
	{
		int total=0;
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) FROM notice WHERE subject LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, fd);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return total;
	}
	
	public int noticeCateFindCount(String fd, int ncno)
	{
		int total=0;
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) FROM notice WHERE subject LIKE '%'||?||'%' AND ncno=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, fd);
			ps.setInt(2, ncno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return total;
	}
	
	
	public int noticeCateCount(int ncno)
	{
		int total=0;
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) FROM notice WHERE ncno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ncno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			total=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return total;
	}
	
	//-------------------------------------------------------------------------------------------------------------------------
	
	//상세보기
	public NoticeVO noticeDetailData(int nno)
	{
		NoticeVO vo=new NoticeVO();
		try {
			conn=db.getConnection();
			String sql="UPDATE notice SET hit=hit+1 WHERE nno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, nno);
			ps.executeUpdate();
			
			sql="SELECT nno,subject,content,ncno,TO_CHAR(regdate,'YYYY-MM-DD'),hit,id "
					+ "FROM notice WHERE nno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, nno);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNno(rs.getInt(1));
			vo.setSubject(rs.getString(2));
			vo.setContent(rs.getString(3));
			vo.setNcno(rs.getInt(4));
			vo.setDbday(rs.getString(5));
			vo.setHit(rs.getInt(6));
			vo.setId(rs.getString(7));
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			db.disConnection(conn, ps);
		}
		return vo;
	}

	//추가
	public void noticeInsert(NoticeVO vo)
	{
		try
		{
			conn=db.getConnection();
			String sql="INSERT INTO notice VALUES(nt_nn_seq.nextval,?,?,?,?,?,?,0,SYSDATE,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setInt(2, vo.getNcno());
			ps.setString(3, vo.getSubject());
			ps.setString(4, vo.getContent());
			ps.setString(5, vo.getImgname());
			ps.setString(6, vo.getImgsize());
			ps.setInt(7, vo.getFix());
			// IN,OUT 입출력 오류
			ps.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	
	//삭제
	public void noticeDelete(int nno)
	{
		try
		{
			conn=db.getConnection();
			String sql="DELETE FROM notice WHERE nno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, nno);
			// IN,OUT 입출력 오류
			ps.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	
	//수정
	public NoticeVO noticeUpdateData(int nno)
	{
		NoticeVO vo=new NoticeVO();
		try
		{
			conn=db.getConnection();
			String sql="SELECT nno,subject,content,ncno,TO_CHAR(regdate,'YYYY-MM-DD'),imgname,imgsize,id,fix FROM notice WHERE nno=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, nno);
			// IN,OUT 입출력 오류
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setNno(rs.getInt(1));
			vo.setSubject(rs.getString(2));
			vo.setContent(rs.getString(3));
			vo.setNcno(rs.getInt(4));
			vo.setDbday(rs.getString(5));
			vo.setImgname(rs.getString(6));
			vo.setImgsize(rs.getString(7));
			vo.setId(rs.getString(8));
			vo.setFix(rs.getInt(9));
			
			rs.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		return vo;
	}
	
	//글 업데이트
	public void noticeUpdate(NoticeVO vo)
	{
		try
		{
			conn=db.getConnection();
			String sql="UPDATE notice SET ncno=?,subject=?,content=?,imgsize=?,imgname=?,fix=? WHERE nno=?";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1,vo.getNcno());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getImgsize());
			ps.setString(5, vo.getImgname());
			ps.setInt(6, vo.getFix());
			ps.setInt(7, vo.getNno());
			ps.executeUpdate();
			// IN,OUT 입출력 오류
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	
	
	//검색 데이터 --------------------------------------------------------------------------------------------------
	public List<NoticeVO> noticeCateFindData(String fd, int page, int ncno)
	{
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT nno,subject,id,ncno,TO_CHAR(regdate,'YYYY-MM-DD'),hit,num "
					 + "FROM (SELECT nno,subject,id,ncno,regdate,hit,rownum as num "
					 + "FROM (SELECT /*+ INDEX_DESC(notice nt_nno_pk)*/nno,subject,id,ncno,regdate,hit "
					 + "FROM notice WHERE subject LIKE '%'||?||'%' AND ncno=?)) "
					 + "WHERE num BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			int rowSize=10;
			int start=(rowSize*page)-(rowSize-1);
			int end=rowSize*page;
			
			ps.setString(1, fd);
			ps.setInt(2, ncno);
			ps.setInt(3, start);
			ps.setInt(4, end);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				NoticeVO vo=new NoticeVO();
				vo.setNno(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setId(rs.getString(3));
				vo.setNcno(rs.getInt(4));
				vo.setDbday(rs.getString(5));
				vo.setHit(rs.getInt(6));
				list.add(vo);
			}
			rs.close();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	
	public List<NoticeVO> noticeFindData(String fd, int page)
	{
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT nno,subject,id,ncno,TO_CHAR(regdate,'YYYY-MM-DD'),hit,num "
					 + "FROM (SELECT nno,subject,id,ncno,regdate,hit,rownum as num "
					 + "FROM (SELECT /*+ INDEX_DESC(notice nt_nno_pk)*/nno,subject,id,ncno,regdate,hit "
					 + "FROM notice WHERE subject LIKE '%'||?||'%')) "
					 + "WHERE num BETWEEN ? AND ? ";
			ps=conn.prepareStatement(sql);
			int rowSize=10;
			int start=(rowSize*page)-(rowSize-1);
			int end=rowSize*page;
			
			ps.setString(1, fd);
			ps.setInt(2, start);
			ps.setInt(3, end);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				NoticeVO vo=new NoticeVO();
				vo.setNno(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setId(rs.getString(3));
				vo.setNcno(rs.getInt(4));
				vo.setDbday(rs.getString(5));
				vo.setHit(rs.getInt(6));
				list.add(vo);
			}
			rs.close();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return list;
	}
	
	
}
