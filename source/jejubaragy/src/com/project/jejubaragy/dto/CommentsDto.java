package com.project.jejubaragy.dto;

import java.sql.Date;

public class CommentsDto {
	private int cid;
	private String mid;
	private String aid;
	private String cwriter;
	private String cphoto;
	private int bnum;
	private String ccontent;
	private int cgroup;
	private int cstep;
	private int cindent;
	private Date crdate;
	private String cip;
	
	public CommentsDto(int cid, String mid, String aid, String cwriter, String cphoto, int bnum, String ccontent,
			int cgroup, int cstep, int cindent, Date crdate, String cip) {
		this.cid = cid;
		this.mid = mid;
		this.aid = aid;
		this.cwriter = cwriter;
		this.cphoto = cphoto;
		this.bnum = bnum;
		this.ccontent = ccontent;
		this.cgroup = cgroup;
		this.cstep = cstep;
		this.cindent = cindent;
		this.crdate = crdate;
		this.cip = cip;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
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

	public String getCwriter() {
		return cwriter;
	}

	public void setCwriter(String cwriter) {
		this.cwriter = cwriter;
	}

	public String getCphoto() {
		return cphoto;
	}

	public void setCphoto(String cphoto) {
		this.cphoto = cphoto;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

	public String getCcontent() {
		return ccontent;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

	public int getCgroup() {
		return cgroup;
	}

	public void setCgroup(int cgroup) {
		this.cgroup = cgroup;
	}

	public int getCstep() {
		return cstep;
	}

	public void setCstep(int cstep) {
		this.cstep = cstep;
	}

	public int getCindent() {
		return cindent;
	}

	public void setCindent(int cindent) {
		this.cindent = cindent;
	}

	public Date getCrdate() {
		return crdate;
	}

	public void setCrdate(Date crdate) {
		this.crdate = crdate;
	}

	public String getCip() {
		return cip;
	}

	public void setCip(String cip) {
		this.cip = cip;
	}

	@Override
	public String toString() {
		return "CommentsDto [cid=" + cid + ", mid=" + mid + ", aid=" + aid + ", cwriter=" + cwriter + ", cphoto="
				+ cphoto + ", bnum=" + bnum + ", ccontent=" + ccontent + ", cgroup=" + cgroup + ", cstep=" + cstep
				+ ", cindent=" + cindent + ", crdate=" + crdate + ", cip=" + cip + "]";
	}
	
}
