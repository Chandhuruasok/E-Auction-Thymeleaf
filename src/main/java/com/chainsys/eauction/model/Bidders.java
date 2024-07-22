package com.chainsys.eauction.model;

import org.springframework.stereotype.Repository;

@Repository
public class Bidders {
	int bidAmount;
	int userId;
	String bidderName;
	String productName;
	
	public int getBidAmount() {
		return bidAmount;
	}
	public void setBidAmount(int bidAmount) {
		this.bidAmount = bidAmount;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getBidderName() {
		return bidderName;
	}
	public void setBidderName(String bidderName) {
		this.bidderName = bidderName;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	public Bidders(int bidAmount, int userId, String bidderName, String productName) {
		super();
		this.bidAmount = bidAmount;
		this.userId = userId;
		this.bidderName = bidderName;
		this.productName = productName;
		
	}
	public Bidders()
	{
		
	}
	@Override
	public String toString() {
		return "Transaction [bidAmount=" + bidAmount + ", userId=" + userId + ", bidderName=" + bidderName
				+ ", productName=" + productName + "]";
	}
	
}