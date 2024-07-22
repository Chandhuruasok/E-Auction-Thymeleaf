package com.chainsys.eauction.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.eauction.dao.UserDAO;
import com.chainsys.eauction.model.Bidders;
import com.chainsys.eauction.model.Transactions;
import com.chainsys.eauction.util.EmailUtility;
import com.chainsys.eauction.validation.Validation;
@Controller
public class BidderController {
	@Autowired
	Bidders bidders;
	@Autowired
	UserDAO user;
	@Autowired
	Transactions transactions;
	@Autowired
	EmailUtility emailUtility;
	@Autowired
	Validation validation;
	@PostMapping("/insertbidamount")
	public String insertBidAmount(@RequestParam("userId") int BidderId,@RequestParam("biddername") String bidderName,@RequestParam("productname") String productName,@RequestParam("bidAmount") int bidAmount) throws ClassNotFoundException
	{
		bidders.setUserId(BidderId);
		bidders.setBidderName(bidderName);
		bidders.setProductName(productName);
		bidders.setBidAmount(bidAmount);
		user.insertBidAmount(bidders);
		return "biddersViewProducts";
	}
	@PostMapping("/viewbiddersDetails")
	public String viewBiddersDetails(@RequestParam("productname") String productName,Model model)
	{
		  List<Bidders>bidders=null;
		  bidders=user.viewBidders(productName);
		  model.addAttribute("bidders", bidders);
		  
	      return "viewBidders";
	}
	@PostMapping("/winners")
	public String biddersViewWinners(@RequestParam("productname") String productName,Model model)
	{
		List<Bidders>winners=null;
		winners=user.biddersViewWinners(productName);
		  model.addAttribute("winners", winners);
		  boolean isWinner = (userId.getId() == bidders.getUserId());
			boolean isPaid = user.isPaid(bidderId, productName);

		  
		  
	      return "biddersViewWinners";
	}
	@PostMapping("/payment")
	public String bidderPayment(@RequestParam("userId") int bidderId,@RequestParam("biddername") String bidderName,@RequestParam("productname") String productName,@RequestParam("amount") int payableAmount,Model model)
	{
		
		transactions.setBidderId(bidderId);
		transactions.setBidderName(bidderName);
		transactions.setProductName(productName);
		transactions.setPayableAmount(payableAmount);
		user.bidderPayment(transactions);
		user.successPayment(bidderId);
		model.addAttribute("productName", productName);
		
		String mail = user.sendEmailToWinner(bidderId);
        String subject=" Important Notice: Regarding Your Recent Participation in Auction Management in Bidderboy";
        String body="Thank you for your interest in BidderBoy.You are the winner of the auction that you have participated"+ 
                
                "\r\n"
                + "Best regards, ";
        emailUtility.sendEmail(mail, subject, body);
	      return "biddersViewWinners";
		
	}
}