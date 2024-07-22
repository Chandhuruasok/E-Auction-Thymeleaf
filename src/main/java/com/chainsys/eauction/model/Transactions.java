package com.chainsys.eauction.model;

import org.springframework.stereotype.Repository;

@Repository
public class Transactions {
int bidderId;
String bidderName;
String productName;
int payableAmount;
boolean isPaid;

public boolean isPaid() {
	return isPaid;
}
public void setPaid(boolean isPaid) {
	this.isPaid = isPaid;
}
public int getBidderId() {
	return bidderId;
}
public void setBidderId(int bidderId) {
	this.bidderId = bidderId;
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
public int getPayableAmount() {
	return payableAmount;
}
public void setPayableAmount(int payableAmount) {
	this.payableAmount = payableAmount;
}
public Transactions()
{
	
}

public Transactions(int bidderId, String bidderName, String productName, int payableAmount, boolean isPaid) {
	super();
	this.bidderId = bidderId;
	this.bidderName = bidderName;
	this.productName = productName;
	this.payableAmount = payableAmount;
	this.isPaid = isPaid;
}
@Override
public String toString() {
	return "Transactions [bidderId=" + bidderId + ", bidderName=" + bidderName + ", productName=" + productName
			+ ", payableAmount=" + payableAmount + ", isPaid=" + isPaid + "]";
}


}
