package com.project.jejubaragy.dto;

public class DetailRouteDto {
	private int dnum;
	private int rnum;
	private int sid;
	private String sname;
	private String saddress;
	private int ddate;
	private int dseq;
	public DetailRouteDto(int dnum, int rnum, int sid, String sname, String saddress, int ddate, int dseq) {
		this.dnum = dnum;
		this.rnum = rnum;
		this.sid = sid;
		this.sname = sname;
		this.saddress = saddress;
		this.ddate = ddate;
		this.dseq = dseq;
	}
	public int getDnum() {
		return dnum;
	}
	public void setDnum(int dnum) {
		this.dnum = dnum;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getSaddress() {
		return saddress;
	}
	public void setSaddress(String saddress) {
		this.saddress = saddress;
	}
	public int getDdate() {
		return ddate;
	}
	public void setDdate(int ddate) {
		this.ddate = ddate;
	}
	public int getDseq() {
		return dseq;
	}
	public void setDseq(int dseq) {
		this.dseq = dseq;
	}
	
	
}
