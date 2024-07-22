package com.chainsys.eauction.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.chainsys.eauction.dao.UserDAO;
import com.chainsys.eauction.model.Sellers;

@Controller
public class SellerController {
	@Autowired
	UserDAO user;
	
@PostMapping("/sellerproduct")
public String insertProducts(@RequestParam("id") int sellerId,@RequestParam("username") String sellerName,@RequestParam("product_category") String productCategory,@RequestParam("product_name")String productName,@RequestParam("image") MultipartFile image,@RequestParam("product_model") String productModel,@RequestParam("product_condition") String productCondition,@RequestParam("product_description") String productDescription,@RequestParam("terms_and_conditions") String termsAndConditions,@RequestParam("average_amount") String bidStartAmount,@RequestParam("bid_start_date") Date bidStartDate,@RequestParam("myfile") MultipartFile isoCertificate)
{
	Sellers sellers=new Sellers();
	sellers.setSellerId(sellerId);
	
	sellers.setSellerName(sellerName);
	
	sellers.setProductCategory(productCategory);
	sellers.setProductName(productName);
	byte[] imageBytes=null;
	if(!image.isEmpty())
	{
		try {
			imageBytes=image.getBytes();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	byte[] isoBytes=null;
	if(!isoCertificate.isEmpty())
	{
		try {
			isoBytes=isoCertificate.getBytes();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	sellers.setImage(imageBytes);
	sellers.setProductModel(productModel);
	sellers.setProductCondition(productCondition);
	sellers.setProductDescription(productDescription);
	sellers.setTerms(termsAndConditions);
	sellers.setBidStartAmount(bidStartAmount);
	sellers.setStartDate(bidStartDate);
	LocalDate startDate = bidStartDate.toLocalDate();
    LocalDate endDate = startDate.plusDays(1);
    sellers.setEndDate(Date.valueOf(endDate));
	sellers.setIso(isoBytes);
	user.insertSellerProducts(sellers);
	return "sellerProducts";
	
}


}