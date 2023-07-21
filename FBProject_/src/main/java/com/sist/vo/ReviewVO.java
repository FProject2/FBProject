 package com.sist.vo;

import java.sql.Date;

public class ReviewVO {
	private double score;
	private Date regdate;
	private String content,id,rdate,dbday;
	private int rvno,gno,rno;
	private String gimage, gname, gprice;
	
	public String getGprice() {
		return gprice;
	}
	public void setGprice(String gprice) {
		this.gprice = gprice;
	}
	public String getGimage() {
		return gimage;
	}
	public void setGimage(String gimage) {
		this.gimage = gimage;
	}
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public int getRno() {
	return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}

   public String getDbday() {
	return dbday;
}
public void setDbday(String dbday) {
	this.dbday = dbday;
}
   public String getRdate() {
	return rdate;
}
public void setRdate(String rdate) {
	this.rdate = rdate;
}
public int getRvno() {
      return rvno;
   }
   public void setRvno(int rvno) {
      this.rvno = rvno;
   }
   public int getGno() {
      return gno;
   }
   public void setGno(int gno) {
      this.gno = gno;
   }
   public double getScore() {
      return score;
   }
   public void setScore(double score) {
      this.score = score;
   }
   public Date getRegdate() {
      return regdate;
   }
   public void setRegdate(Date regdate) {
      this.regdate = regdate;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   
   
   
}