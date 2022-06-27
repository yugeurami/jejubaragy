package com.project.jejubaragy.dto;

import java.sql.Date;

public class MemberDto {
	private String mid;
	private String mpw;
	private String mname;
	private String mphoto;
	private Date mrdate;
	private int mstatus;
	
	public MemberDto(String mid, String mpw, String mname, String mphoto, Date mrdate, int mstatus) {
		this.mid = mid;
		this.mpw = mpw;
		this.mname = mname;
		this.mphoto = mphoto;
		this.mrdate = mrdate;
		this.mstatus = mstatus;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpw() {
		return mpw;
	}
	public void setMpw(String mpw) {
		this.mpw = mpw;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMphoto() {
		return mphoto;
	}
	public void setMphoto(String mphoto) {
		this.mphoto = mphoto;
	}
	public Date getMrdate() {
		return mrdate;
	}
	public void setMrdate(Date mrdate) {
		this.mrdate = mrdate;
	}
	public int getMstatus() {
		return mstatus;
	}
	public void setMstatus(int mstatus) {
		this.mstatus = mstatus;
	}
	@Override
	public String toString() {
		return "MemberDto [mid=" + mid + ", mpw=" + mpw + ", mname=" + mname + ", mphoto=" + mphoto + ", mrdate="
				+ mrdate + ", mstatus=" + mstatus + "]";
	}
	
}
