package com.sist.vo;

import java.util.Date;

public class ReplyVO {
   private int rno,qno,group_id,group_step,group_tab,root,depth;
   private String id,msg,dbday,admin;
   private Date regdate;
   
   public String getAdmin() {
	return admin;
}
public void setAdmin(String admin) {
	this.admin = admin;
}
public int getRno() {
      return rno;
   }
   public void setRno(int rno) {
      this.rno = rno;
   }
   public int getQno() {
      return qno;
   }
   public void setQno(int qno) {
      this.qno = qno;
   }
   public int getGroup_id() {
      return group_id;
   }
   public void setGroup_id(int group_id) {
      this.group_id = group_id;
   }
   public int getGroup_step() {
      return group_step;
   }
   public void setGroup_step(int group_step) {
      this.group_step = group_step;
   }
   public int getGroup_tab() {
      return group_tab;
   }
   public void setGroup_tab(int group_tab) {
      this.group_tab = group_tab;
   }
   public int getRoot() {
      return root;
   }
   public void setRoot(int root) {
      this.root = root;
   }
   public int getDepth() {
      return depth;
   }
   public void setDepth(int depth) {
      this.depth = depth;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getMsg() {
      return msg;
   }
   public void setMsg(String msg) {
      this.msg = msg;
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
   
   
}