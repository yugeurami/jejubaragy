package com.project.jejubaragy.dto;

import java.sql.Date;

public class BoardDto {
	private int bnum;
	private String mid;
	private String aid;
	private String bwriter;
	private int rnum;
	private String btitle;
	private String bcontent;
	private String bmainphoto;
	private int bhit;
	private String bip;
	private Date brdate;
	
	public BoardDto(int bnum, String mid, String aid, String bwriter, int rnum, String btitle, String bcontent,
			String bmainphoto, int bhit, String bip, Date brdate) {
		this.bnum = bnum;
		this.mid = mid;
		this.aid = aid;
		this.bwriter = bwriter;
		this.rnum = rnum;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bmainphoto = bmainphoto;
		this.bhit = bhit;
		this.bip = bip;
		this.brdate = brdate;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getBwriter() {
		return bwriter;
	}

	public void setBwriter(String bwriter) {
		this.bwriter = bwriter;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getBtitle() {
		return btitle;
	}

	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}

	public String getBcontent() {
		return bcontent;
	}

	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}

	public String getBmainphoto() {
		return bmainphoto;
	}

	public void setBmainphoto(String bmainphoto) {
		this.bmainphoto = bmainphoto;
	}

	public int getBhit() {
		return bhit;
	}

	public void setBhit(int bhit) {
		this.bhit = bhit;
	}

	public String getBip() {
		return bip;
	}

	public void setBip(String bip) {
		this.bip = bip;
	}

	public Date getBrdate() {
		return brdate;
	}

	public void setBrdate(Date brdate) {
		this.brdate = brdate;
	}

	@Override
	public String toString() {
		return "BoardDto [bnum=" + bnum + ", mid=" + mid + ", aid=" + aid + ", bwriter=" + bwriter + ", rnum=" + rnum
				+ ", btitle=" + btitle + ", bcontent=" + bcontent + ", bmainphoto=" + bmainphoto + ", bhit=" + bhit
				+ ", bip=" + bip + ", brdate=" + brdate + "]";
	}
	
	
}
