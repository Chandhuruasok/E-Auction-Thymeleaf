package com.chainsys.eauction.model;

import java.io.Serializable;

public class Users implements Serializable {
	int id;
	String email;
	String name;
	String phoneNumber;
	String password;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public Users(int id, String email, String name, String phoneNumber, String password) {
		super();
		this.id = id;
		this.email = email;
		this.name = name;
		this.phoneNumber = phoneNumber;
		this.password = password;
	}
	public Users()
	{
		
	}
	@Override
	public String toString() {
		return "UserDetails [id=" + id + ", email=" + email + ", name=" + name + ", phoneNumber=" + phoneNumber
				+ ", password=" + password + "]";
	}
	
	
}
