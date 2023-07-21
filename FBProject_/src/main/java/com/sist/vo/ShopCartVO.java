package com.sist.vo;

import java.util.*;
/*
	ono NUMBER,
    gno NUMBER,
    id VARCHAR2(50),
    amount NUMBER,
    tprice NUMBER,
    buy_ok NUMBER DEFAULT 0,
    check_ok NUMBER DEFAULT 0,
    regdate DATE DEFAULT SYSDATE,
 */

public class ShopCartVO {
	private int ono, gno, amount, tprice, buy_ok, check_ok, price;
	private String id, goods_name, goods_poster, member_name;
	private Date regdate;
	
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public int getOno() {
		return ono;
	}
	public void setOno(int ono) {
		this.ono = ono;
	}
	public int getGno() {
		return gno;
	}
	public void setGno(int gno) {
		this.gno = gno;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getTprice() {
		return tprice;
	}
	public void setTprice(int tprice) {
		this.tprice = tprice;
	}
	public int getBuy_ok() {
		return buy_ok;
	}
	public void setBuy_ok(int buy_ok) {
		this.buy_ok = buy_ok;
	}
	public int getCheck_ok() {
		return check_ok;
	}
	public void setCheck_ok(int check_ok) {
		this.check_ok = check_ok;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public String getGoods_poster() {
		return goods_poster;
	}
	public void setGoods_poster(String goods_poster) {
		this.goods_poster = goods_poster;
	}
	
}