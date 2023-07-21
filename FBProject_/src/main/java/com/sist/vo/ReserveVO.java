package com.sist.vo;

public class ReserveVO {

   private int rno,gno;
   private String price,rdate,rstate,id,time;
   private String phone, name, gname, gimage, gaddr, review_ok;
   
   public String getGaddr() {
	return gaddr;
}
public String getReview_ok() {
	return review_ok;
}
public void setReview_ok(String review_ok) {
	this.review_ok = review_ok;
}
public void setGaddr(String gaddr) {
	this.gaddr = gaddr;
}
public String getTime() {
      return time;
   }
   public String getGname() {
	return gname;
}
public void setGname(String gname) {
	this.gname = gname;
}
public String getGimage() {
	return gimage;
}
public void setGimage(String gimage) {
	this.gimage = gimage;
}
public void setTime(String time) {
      this.time = time;
   }
   public String getRdate() {
      return rdate;
   }
   public void setRdate(String rdate) {
      this.rdate = rdate;
   }
   public int getRno() {
      return rno;
   }
   public void setRno(int rno) {
      this.rno = rno;
   }
   public int getGno() {
      return gno;
   }
   public void setGno(int gno) {
      this.gno = gno;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getPhone() {
      return phone;
   }
   public void setPhone(String phone) {
      this.phone = phone;
   }
   public String getPrice() {
      return price;
   }
   public void setPrice(String price) {
      this.price = price;
   }

   public String getRstate() {
      return rstate;
   }
   public void setRstate(String rstate) {
      this.rstate = rstate;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   
   
   
}