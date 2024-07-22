package com.chainsys.eauction.controller;

import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.eauction.dao.UserDAO;
import com.chainsys.eauction.model.Bidders;
import com.chainsys.eauction.model.Sellers;


@Controller
public class AdminController {
	
	@Autowired
	UserDAO user;
	@Autowired
	Sellers sellers;
	
	@PostMapping("/rejectsellerproducts")
	public String rejectSellerProducts(@RequestParam("deleteproductid") int productId)
	{
		user.adminRejectSellerProduct(productId);
		
		return "admin";
	}
	@PostMapping("/approvesellerproducts")
	public String approveSellerProducts(@RequestParam("approveproductid") int productId)
	{
		user.adminApproveSellerProduct(productId);
		
		return "admin";
	}
	
	@GetMapping("/viewapprovedproducts")
	public String viewApprovedProducts(Model model)
	{
		List<Sellers> approvedProducts=null;
		approvedProducts=user.adminViewApprovedProducts();
		for (Sellers sellers : approvedProducts) {
            String base64 = Base64.getEncoder().encodeToString(sellers.getImage());
            sellers.setBase64(base64);
            
        }
		
		model.addAttribute("approvedProducts",approvedProducts);
		return "adminViewProducts";
	}
	@PostMapping("/viewbidders")
	public String viewBiddersBidAmount(@RequestParam("productname") String productName,Model model)
	{
		List<Bidders> viewBidders=null;
		viewBidders=user.viewBidders(productName);
		model.addAttribute("productName", viewBidders);
		  
	      return "adminViewBidders";
	}
	@PostMapping("/adminViewWinners")
	public String adminViewWinners(@RequestParam("productname") String productName,Model model)
	{
		  List<Bidders> viewWinners=null;
		  viewWinners=user.biddersViewWinners(productName);
		  model.addAttribute("productName", viewWinners);
		  
	      return "adminViewWinners";
	}
	
}