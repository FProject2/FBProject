package com.sist.vo;
/*
 * CREATE TABLE notice(
 nno NUMBER,
 id VARCHAR2(50),
 ncno NUMBER,
 subject VARCHAR2(2000) CONSTRAINT nt_subject_nn NOT NULL,
 content CLOB CONSTRAINT nt_content_nn NOT NULL,
 imgname VARCHAR2(260),
 imgsize VARCHAR2(260),
 hit NUMBER CONSTRAINT nt_hit_nn NOT NULL,
 regdate DATE DEFAULT SYSDATE CONSTRAINT nt_regdate_nn NOT NULL,
 fix CHAR(1) DEFAULT 'n',

);
 */

import java.util.Date;

public class NoticeVO {
   private int nno,ncno,hit,fix;
   private String id,subject,content,imgname,imgsize,dbday;
   private Date regdate;
   
   public String getSubject() {
      return subject;
   }
   public void setSubject(String subject) {
      this.subject = subject;
   }
   public int getNno() {
      return nno;
   }
   public void setNno(int nno) {
      this.nno = nno;
   }
   public int getNcno() {
      return ncno;
   }
   public void setNcno(int ncno) {
      this.ncno = ncno;
   }
   public int getHit() {
      return hit;
   }
   public void setHit(int hit) {
      this.hit = hit;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getContent() {
      return content;
   }
   public void setContent(String content) {
      this.content = content;
   }
   public String getImgname() {
      return imgname;
   }
   public void setImgname(String imgname) {
      this.imgname = imgname;
   }
   public String getImgsize() {
      return imgsize;
   }
   public void setImgsize(String imgsize) {
      this.imgsize = imgsize;
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
   public int getFix() {
      return fix;
   }
   public void setFix(int fix) {
      this.fix = fix;
   }
   
   
}