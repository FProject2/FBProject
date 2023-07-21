package com.sist.dao;
import java.sql.*;
import java.util.*;
import java.util.concurrent.ThreadPoolExecutor.DiscardOldestPolicy;

import com.sist.common.*;
import com.sist.vo.MemberVO;
import com.sist.vo.ZipcodeVO;

public class MemberDAO {
	private Connection conn;
	private PreparedStatement ps;
	private CreateDataBase db=new CreateDataBase();
	private static MemberDAO dao;
	
	//싱글턴
	public static MemberDAO newInstance() {
		if(dao==null)
			dao=new MemberDAO();
		return dao;
	}
	//회원가입
	//1. 아이디 중복체크
	public int memberIdCheck(String id) {
		int count=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) "
					 + "FROM member "
					 + "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			db.disConnection(null, ps);
		}
		
		return count;
	}
	//2. 이메일 중복체크
	public int memberEmailCheck(String email) {
		int count=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) "
					 + "FROM member "
					 + "WHERE email=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			db.disConnection(null, ps);
		}
		
		return count;
	}
	//3. 우편번호 검색
	public int postFindCount(String dong) {
		int count=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) "
					+ "FROM zipcode "
					+ "WHERE dong LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dong);
			ResultSet rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return count;
	}
	
	//3-1. 우편번호 검색
	public List<ZipcodeVO> postFindData(String dong) {
		List<ZipcodeVO> list=new ArrayList<ZipcodeVO>();
		
		try {
			conn=db.getConnection();
			String sql="SELECT zipcode,sido,gugun,dong,NVL(bunji,' ') "
					+ "FROM zipcode "
					+ "WHERE dong LIKE '%'||?||'%'";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dong);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ZipcodeVO vo = new ZipcodeVO();
				vo.setZipcode(rs.getString(1));
				vo.setSido(rs.getString(2));
				vo.setGugun(rs.getString(3));
				vo.setDong(rs.getString(4));
				vo.setBunji(rs.getString(5));
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
	//4. 전화 중복체크
	public int memberPhoneCheck(String phone) {
		int count=0;
		
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) "
					 + "FROM member "
					 + "WHERE phone=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, phone);
			ResultSet rs=ps.executeQuery();
			rs.next();
			count=rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			db.disConnection(null, ps);
		}
		
		return count;
	}
	//5. 회원가입
	public void memberInsert(MemberVO vo) {
		try {
			conn=db.getConnection();
			String sql="INSERT INTO member VALUES("
					+ "?,?,?,?,?,?,?,?,?,?,?,SYSDATE,'n')";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getId());
			ps.setString(2, vo.getPwd());
			ps.setString(3, vo.getEmail());
			ps.setString(4, vo.getName());
			ps.setString(5, vo.getNickname());
			ps.setString(6, vo.getSex());
			ps.setString(7, vo.getBirthday());
			ps.setString(8, vo.getPhone());
			ps.setString(9, vo.getPost());
			ps.setString(10, vo.getAddr1());
			ps.setString(11, vo.getAddr2());
			ps.executeUpdate();
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
	}
	
	// 아이디 찾기
	public String idEmailFind(String email)
	{
		String result = "";
		
		try {
			conn = db.getConnection();
			
			String sql = "SELECT COUNT(*) FROM member WHERE email=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			int count = rs.getInt(1);
			rs.close();
			
			if(count==0)
			{
				result="NO";
			}
			else {
				
				sql = "SELECT RPAD(SUBSTR(id,1,LENGTH(id)-3),LENGTH(id),'*') FROM member WHERE email=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, email);
				rs = ps.executeQuery();
				rs.next();
				result = rs.getString(1);
				rs.close();
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		return result;
	}
	
	// 비밀번호 찾기
	public String pwdFind(String name, String email)
	{
		String result = "";
		
		try {
			conn = db.getConnection();
			
			String sql = "SELECT COUNT(*) FROM member WHERE name=? AND email=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, email);
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			int count = rs.getInt(1);
			rs.close();
			
			if(count==0)
			{
				result="NO";
			}
			else {
				
				sql = "SELECT RPAD(SUBSTR(pwd,1,LENGTH(pwd)-3),LENGTH(pwd),'*') FROM member WHERE name=? AND email=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, name);
				ps.setString(2, email);
				rs = ps.executeQuery();
				rs.next();
				result = rs.getString(1);
				rs.close();
			}
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			db.disConnection(conn, ps);
		}
		
		return result;
	}
	
	// 로그인
	public MemberVO memberLogin(String id, String pwd) {
		MemberVO vo = new MemberVO();
		
		try {
			conn=db.getConnection();
			String sql="SELECT COUNT(*) "
					 + "FROM member "
					 + "WHERE id=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			rs.close();
			//id존재여부
			if(count==0) {
				vo.setMsg("NOID");
			} else {
				sql="SELECT pwd, name, admin, sex, phone, post, addr1 "
				  + "FROM member "
				  + "WHERE id=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				rs=ps.executeQuery();
				rs.next();
				String db_pwd=rs.getString(1);
				String name=rs.getString(2);
				String admin=rs.getString(3);
				String sex=rs.getString(4);
				String phone = rs.getString(5);
				String post = rs.getString(6);
				String addr1 = rs.getString(7);
				rs.close();
				
				if(db_pwd.equals(pwd)) { 
					vo.setId(id);
					vo.setName(name);
					vo.setAdmin(admin);
					vo.setSex(sex);
					vo.setMsg("OK");
					vo.setPhone(phone);
					vo.setPost(post);
					vo.setAddr1(addr1);
				} else {
					vo.setMsg("NOPWD");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			db.disConnection(conn, ps);
		}
		
		return vo;
	}
}
