package com.chainsys.eauction.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.eauction.model.Bidders;
import com.chainsys.eauction.model.Sellers;
import com.chainsys.eauction.model.Transactions;
import com.chainsys.eauction.model.Users;
@Repository
public interface UserDAO {
	public boolean register(Users input); 
	public boolean login(Users userDetails);
	public Users getUserId(String email);
	public void insertSellerProducts(Sellers sellers);
	public void adminRejectSellerProduct(int productId); 
	public List<Sellers> adminViewSellerProduct();
	public void adminApproveSellerProduct(int productId);
	public List<Sellers> adminViewApprovedProducts();
	public List<Sellers> bidderViewApprovedProducts();
	public void insertBidAmount(Bidders bidders);
	public List<Bidders> viewBidders(String productName);
	public List<Bidders> biddersViewWinners(String productName);
	public void bidderPayment(Transactions transactions);
	public void successPayment(int bidderId);
	public boolean isPaid(int bidderId,String productName);
	public String sendEmailToWinner(int bidderId);
	public List<Sellers> viewLiveAuctions();
	public List<Sellers> viewEndedAuctions();
	public List<Sellers> viewUpComingAuctions();
}
