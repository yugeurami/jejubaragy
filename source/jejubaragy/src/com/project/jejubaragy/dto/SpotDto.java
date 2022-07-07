package com.project.jejubaragy.dto;

public class SpotDto {
	private int sid;
	private String ccode;
	private String cname;
	private String sname;
	private String sphoto;
	private String saddress;
	private String description;
	
	public SpotDto(int sid, String ccode, String cname, String sname, String sphoto, String saddress,
			String description) {
		this.sid = sid;
		this.ccode = ccode;
		this.cname = cname;
		this.sname = sname;
		this.sphoto = sphoto;
		this.saddress = saddress;
		this.description = description;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getCcode() {
		return ccode;
	}
	public void setCcode(String ccode) {
		this.ccode = ccode;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getSphoto() {
		return sphoto;
	}
	public void setSphoto(String sphoto) {
		this.sphoto = sphoto;
	}
	public String getSaddress() {
		return saddress;
	}
	public void setSaddress(String saddress) {
		this.saddress = saddress;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "'"+saddress + "'";
	}
	
	
}
