package com.project.jejubaragy.dto;

import java.sql.Date;

public class RouteDto {
	private int rnum;
	private String rname;
	private String mid;
	private String mname;
	private Date rstartdate;
	private Date renddate;
	private int rprivate;
	public RouteDto(int rnum, String rname, String mid, String mname, Date rstartdate, Date renddate, int rprivate) {
		this.rnum = rnum;
		this.rname = rname;
		this.mid = mid;
		this.mname = mname;
		this.rstartdate = rstartdate;
		this.renddate = renddate;
		this.rprivate = rprivate;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public Date getRstartdate() {
		return rstartdate;
	}
	public void setRstartdate(Date rstartdate) {
		this.rstartdate = rstartdate;
	}
	public Date getRenddate() {
		return renddate;
	}
	public void setRenddate(Date renddate) {
		this.renddate = renddate;
	}
	public int getRprivate() {
		return rprivate;
	}
	public void setRprivate(int rprivate) {
		this.rprivate = rprivate;
	}
	
	
}
