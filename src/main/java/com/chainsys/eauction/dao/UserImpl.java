package com.chainsys.eauction.dao;
import java.util.List;
import com.chainsys.eauction.mapper.ViewBiddersDetailsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.chainsys.eauction.mapper.ViewProductMapper;
import com.chainsys.eauction.mapper.UserMapper;
import com.chainsys.eauction.mapper.SellerMapper;
import com.chainsys.eauction.mapper.BidderMapper;

import com.chainsys.eauction.mapper.WinnersMapper;
import com.chainsys.eauction.model.Sellers;
import com.chainsys.eauction.model.Transactions;
import com.chainsys.eauction.model.Users;
import com.chainsys.eauction.model.Bidders;
@Repository("userDao")
public class UserImpl implements UserDAO{
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Override
	public boolean register(Users input) {
		
		String query="select count(*) from  register where email=?";
		Object[] params= {input.getEmail()};
		int countUsers=jdbcTemplate.queryForObject(query,Integer.class,params);
		if(countUsers==0)
		{
			String insert="insert into register(email,user_name,phone_number,password) values(?,?,?,?)";
			Object[] insertInput= {input.getEmail(),input.getName(),input.getPhoneNumber(),input.getPassword()};
			jdbcTemplate.update(insert, insertInput);
			return true;
		}
		else
		{
		return false;
		}
		
	}
	@Override
	public  boolean login(Users userDetails) {
	    
	    String loginQuery = "select count(*) from register where email=? and user_name=? and password=?";
	    Object[] params= {userDetails.getEmail(),userDetails.getName(),userDetails.getPassword()};
	    int availableUser=jdbcTemplate.queryForObject(loginQuery, Integer.class,params);
	    if(availableUser==0)
	    {
	    	return false;
	    }
	    else
	    {
		return true;
	    }
	    
	}
	@Override
	public Users getUserId(String  email) {
		
		try
		{
	    String sessionDetails="select id,email,user_name from register where email=? ";
	    Users usersId=jdbcTemplate.queryForObject(sessionDetails, new UserMapper(), email);
	    
	    return usersId;
		}
		catch(EmptyResultDataAccessException e)
		{
			return null;
		}
		
		
		}
	@Override
		public void insertSellerProducts(Sellers sellers)
		{

			String insert="insert into seller(id,seller_name,product_caterogy,product_name,image,product_model,product_condition,product_description,terms_and_conditions,bid_start_amount,bid_start_date,bid_end_date,iso_certification) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			Object[] insertProduct= {sellers.getSellerId(),sellers.getSellerName(),sellers.getProductCategory(),sellers.getProductName(),sellers.getImage(),sellers.getProductModel(),sellers.getProductCondition(),sellers.getProductDescription(),sellers.getTerms(),sellers.getBidStartAmount(),sellers.getStartDate(),sellers.getEndDate(),sellers.getIso()};
			jdbcTemplate.update(insert, insertProduct);
		
			
		}
		@Override
		public void adminRejectSellerProduct(int productId)
		{
			String rejectProduct = "update seller set is_deleted=true where product_id=?";
			Object[] rejectProductById= {productId};
			jdbcTemplate.update(rejectProduct, rejectProductById);
		}
		@Override
		public List<Sellers> adminViewSellerProduct()
		{
			String viewSellerProducts="select id,seller_name,product_id,product_caterogy,product_name,image,product_model,product_condition,product_description,terms_and_conditions,bid_start_amount,bid_start_date,iso_certification from seller where is_approval=false and is_deleted=0";
			return jdbcTemplate.query(viewSellerProducts,new SellerMapper());
		}
		@Override
		public void adminApproveSellerProduct(int productId)
		{
			String approveSellerProduct="update seller set is_approval=true where product_id=?";
			Object[] sellerProductId= {productId};
			jdbcTemplate.update(approveSellerProduct, sellerProductId);
		}

		@Override
		public List<Sellers> adminViewApprovedProducts() {
	
			String viewApprovedProducts="select seller_name,product_caterogy,product_name,image,product_model,product_condition,product_description,terms_and_conditions,bid_start_amount,bid_start_date,bid_end_date from seller where is_approval=true and is_deleted=0";
			return jdbcTemplate.query(viewApprovedProducts, new ViewProductMapper());
		}
		@Override
		public List<Sellers> bidderViewApprovedProducts() {
			
			String sellerViewApprovedProducts="select seller_name,product_id,product_caterogy,product_name,image,product_model,product_condition,product_description,terms_and_conditions,bid_start_amount,bid_start_date,bid_end_date from seller where is_approval=true and is_deleted=0  ";
			return jdbcTemplate.query(sellerViewApprovedProducts, new BidderMapper());
		}
		@Override
		public void insertBidAmount(Bidders bidders)
		{
			String insert="insert into bidder(bidder_id,bidder_name,product_name,bid_amount) values(?,?,?,?)";
			Object[] insertBidAmount= {bidders.getUserId(),bidders.getBidderName(),bidders.getProductName(),bidders.getBidAmount()};
			jdbcTemplate.update(insert, insertBidAmount);
		}

		
		@Override
		public List<Bidders> viewBidders(String productName) {
			String viewBiddersDetails="select bidder_id,bidder_name,product_name,bid_amount from bidder where product_name=?";
			return jdbcTemplate.query(viewBiddersDetails,new ViewBiddersDetailsMapper(), productName );
			 
		}
		@Override
		public List<Bidders> biddersViewWinners(String productName) {
			String viewWinners="select bidder_id, bidder_name, product_name, bid_amount " +
                    "from bidder " +
                    "where product_name = ? " +
                    "and bid_amount = (select max(bid_amount) from bidder where product_name = ?)";

			return jdbcTemplate.query(viewWinners,new WinnersMapper(), productName , productName );
		}
		@Override
		public void bidderPayment(Transactions transactions) {
			
			String payment="insert into transaction(bidder_id,bidder_name,product_name,payable_amount) values(?,?,?,?)";
			Object[] transactionDetails= {transactions.getBidderId(),transactions.getBidderName(),transactions.getProductName(),transactions.getPayableAmount()};
			jdbcTemplate.update(payment, transactionDetails);
		}
		@Override
		public void successPayment(int bidderId) {
			String successPayment="update transaction set paid_status='1' where bidder_id=? ";
			jdbcTemplate.update(successPayment, bidderId);
			
		}
		@Override
		 public boolean isPaid(int bidderId, String productName) {
	        String sql = "select paid_status from transaction where bidder_id = ? and product_name = ?";
	        try {
	            Boolean paidStatus = jdbcTemplate.queryForObject(sql,Boolean.class, new Object[]{bidderId, productName});
	            return paidStatus != null ? paidStatus : false;
	        } catch (Exception e) {
	            
	            e.printStackTrace();
	            return false;
	        }
	    }
		@Override
		public String sendEmailToWinner(int bidderId) {
			String query="select email from register where id=? ";
	           String email = jdbcTemplate.queryForObject(query, String.class, bidderId);
	            return email;
			
		}
		@Override
		public List<Sellers> viewLiveAuctions() {
	        String sql = "SELECT seller_name,product_id, product_caterogy, product_name, image, product_model, product_condition, " +
	                     "product_description, terms_and_conditions, bid_start_amount, bid_start_date,bid_end_date " +
	                     "FROM seller " +
	                     "WHERE is_approval = true AND is_deleted = 0 AND bid_end_date < bid_start_date ";
	        
	        return jdbcTemplate.query(sql, new BidderMapper());
	    }
		@Override
		public List<Sellers> viewEndedAuctions() {
			
			String sql = "SELECT seller_name, product_caterogy, product_name, image, product_model, product_condition, " +
                    "product_description, terms_and_conditions, bid_start_amount, bid_start_date,bid_end_date " +
                    "FROM seller " +
                    "WHERE is_approval = true AND is_deleted = 0 AND bid_end_date < CURDATE()";
       
       return jdbcTemplate.query(sql, new BidderMapper());
		}
		@Override
		public List<Sellers> viewUpComingAuctions() {
			String sql = "SELECT seller_name, product_caterogy, product_name, image, product_model, product_condition, " +
                    "product_description, terms_and_conditions, bid_start_amount, bid_start_date,bid_end_date " +
                    "FROM seller " +
                    "WHERE is_approval = true AND is_deleted = 0 AND bid_start_date > now()";
       
       return jdbcTemplate.query(sql, new BidderMapper());
		}

	}


