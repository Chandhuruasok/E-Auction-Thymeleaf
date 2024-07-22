package com.chainsys.eauction.model;

import java.sql.Date;
import java.util.Arrays;

import org.springframework.stereotype.Repository;

@Repository

public class Sellers {
	int sellerId;
	String SellerName;
	
	String productName;
	String productModel;
	String productCategory;
	String productCondition;
	String productDescription;
	String terms;
	byte[] image;
	byte[] iso;
	String bidStartAmount;
	int productId;
	Date startDate;
	Date endDate;
	String base64;
	String base64Image;
	public int getSellerId() {
		return sellerId;
	}
	public void setSellerId(int sellerId) {
		this.sellerId = sellerId;
	}
	public String getSellerName() {
		return SellerName;
	}
	public void setSellerName(String sellerName) {
		SellerName = sellerName;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductModel() {
		return productModel;
	}
	public void setProductModel(String productModel) {
		this.productModel = productModel;
	}
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}
	public String getProductCondition() {
		return productCondition;
	}
	public void setProductCondition(String productCondition) {
		this.productCondition = productCondition;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public String getTerms() {
		return terms;
	}
	public void setTerms(String terms) {
		this.terms = terms;
	}
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	public byte[] getIso() {
		return iso;
	}
	public void setIso(byte[] iso) {
		this.iso = iso;
	}
	
	
	public String getBidStartAmount() {
		return bidStartAmount;
	}
	public void setBidStartAmount(String bidStartAmount) {
		this.bidStartAmount = bidStartAmount;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date date) {
		this.startDate = date;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public String getBase64() {
		return base64;
	}
	public void setBase64(String base64) {
		this.base64 = base64;
	}
	public String getBase64Image() {
		return base64Image;
	}
	public void setBase64Image(String base64Image) {
		this.base64Image = base64Image;
	}
	public Sellers()
	{
		
	}
	
	public Sellers(int sellerId, String sellerName, String productName, String productModel, String productCategory,
			String productCondition, String productDescription, String terms, byte[] image, byte[] iso,
			String bidStartAmount, int productId, Date startDate, Date endDate, String base64, String base64Image) {
		super();
		this.sellerId = sellerId;
		SellerName = sellerName;
		this.productName = productName;
		this.productModel = productModel;
		this.productCategory = productCategory;
		this.productCondition = productCondition;
		this.productDescription = productDescription;
		this.terms = terms;
		this.image = image;
		this.iso = iso;
		this.bidStartAmount = bidStartAmount;
		this.productId = productId;
		this.startDate = startDate;
		this.endDate = endDate;
		this.base64 = base64;
		this.base64Image = base64Image;
	}
	@Override
	public String toString() {
		return "Sellers [sellerId=" + sellerId + ", SellerName=" + SellerName + ", productName=" + productName
				+ ", productModel=" + productModel + ", productCategory=" + productCategory + ", productCondition="
				+ productCondition + ", productDescription=" + productDescription + ", terms=" + terms + ", image="
				+ Arrays.toString(image) + ", iso=" + Arrays.toString(iso) + ", bidStartAmount=" + bidStartAmount
				+ ", productId=" + productId + ", startDate=" + startDate + ", endDate=" + endDate + ", base64="
				+ base64 + ", base64Image=" + base64Image + "]";
	}
	
	
	
}