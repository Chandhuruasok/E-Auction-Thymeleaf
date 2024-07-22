package com.chainsys.eauction.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import com.chainsys.eauction.model.Sellers;
public class BidderMapper implements RowMapper<Sellers> {

	@Override
	public Sellers mapRow(ResultSet rs, int rowNum) throws SQLException {
		Sellers sellers=new Sellers();
		sellers.setSellerName(rs.getString("seller_name"));

		sellers.setProductCategory(rs.getString("product_caterogy"));
		sellers.setProductName(rs.getString("product_name"));
		sellers.setImage(rs.getBytes("image"));
		sellers.setProductModel(rs.getString("product_model"));
		sellers.setProductCondition(rs.getString("product_condition"));
		sellers.setProductDescription(rs.getString("product_description"));
		sellers.setTerms(rs.getString("terms_and_conditions"));
		sellers.setBidStartAmount(rs.getString("bid_start_amount"));
		sellers.setStartDate(rs.getDate("bid_start_date"));
		sellers.setEndDate(rs.getDate("bid_end_date"));
		
		return sellers;
	}

}