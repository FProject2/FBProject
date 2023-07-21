package com.sist.vo;

import java.util.Date;

public class QnaVO {
   private int no,hit,qcno;
   private String id,name,subject,content,dbday,secret,updbday;
   private Date regdate,udate;
   private int rCount;
   public int getrCount() {
	return rCount;
	}
	public void setrCount(int rCount) {
		this.rCount = rCount;
	}
	public int getNo() {
      return no;
   }
   public void setNo(int no) {
      this.no = no;
   }
   public int getHit() {
      return hit;
   }
   public void setHit(int hit) {
      this.hit = hit;
   }
   public int getQcno() {
      return qcno;
   }
   public void setQcno(int qcno) {
      this.qcno = qcno;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getSubject() {
      return subject;
   }
   public void setSubject(String subject) {
      this.subject = subject;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getDbday() {
      return dbday;
   }
   public void setDbday(String dbday) {
      this.dbday = dbday;
   }
   public Date getRegdate() {
      return regdate;
   }
   public void setRegdate(Date regdate) {
      this.regdate = regdate;
   }

   public String getSecret() {
      return secret;
   }
   public void setSecret(String secret) {
      this.secret = secret;
   }
   public Date getUdate() {
      return udate;
   }
   public void setUdate(Date udate) {
      this.udate = udate;
   }
   public String getUpdbday() {
      return updbday;
   }
   public void setUpdbday(String updbday) {
      this.updbday = updbday;
   }
   
   
}