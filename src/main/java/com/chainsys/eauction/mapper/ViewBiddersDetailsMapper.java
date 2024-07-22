package com.chainsys.eauction.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.eauction.model.Bidders;


public class ViewBiddersDetailsMapper implements RowMapper<Bidders>{

	@Override
	public Bidders mapRow(ResultSet rs, int rowNum) throws SQLException {
		Bidders bidders=new Bidders();
		bidders.setUserId(rs.getInt("bidder_id"));
		bidders.setBidderName(rs.getString("bidder_name"));
		bidders.setProductName(rs.getString("product_name"));
		bidders.setBidAmount(rs.getInt("bid_amount"));
		
		return bidders;
	}

}