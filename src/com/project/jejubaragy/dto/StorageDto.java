package com.project.jejubaragy.dto;

public class StorageDto {
	private int snum;
	private String mid;
	private int rnum;
	public StorageDto(int snum, String mid, int rnum) {
		this.snum = snum;
		this.mid = mid;
		this.rnum = rnum;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	
	
}
