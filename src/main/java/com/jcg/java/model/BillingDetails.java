package com.jcg.java.model;

import javax.xml.bind.annotation.XmlRootElement;
@XmlRootElement
public class BillingDetails {
	private String add_line1;
	private String add_line2;
	private String city;
	private int pincode;
	private String state;
	
	public BillingDetails() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BillingDetails(String add_line1, String add_line2, String city, int pincode, String state) {
		super();
		this.add_line1 = add_line1;
		this.add_line2 = add_line2;
		this.city = city;
		this.pincode = pincode;
		this.state = state;
	}

	public String getAdd_line1() {
		return add_line1;
	}

	public void setAdd_line1(String add_line1) {
		this.add_line1 = add_line1;
	}

	public String getAdd_line2() {
		return add_line2;
	}

	public void setAdd_line2(String add_line2) {
		this.add_line2 = add_line2;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public int getPincode() {
		return pincode;
	}

	public void setPincode(int pincode) {
		this.pincode = pincode;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	
}

